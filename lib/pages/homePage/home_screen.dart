import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:wealth_wars/methods/account_manager.dart';
import 'package:wealth_wars/methods/custom_toast.dart';
import 'package:wealth_wars/pages/gamePage/game_screen.dart';
import 'package:wealth_wars/pages/gamePage/lobby_screen.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import '../../widgets/lobbyWidgets/pop_up_salas.dart';
import 'package:wealth_wars/pages/homePage/account_screen.dart';
import 'package:wealth_wars/pages/homePage/awards_screen.dart';
import 'package:wealth_wars/pages/homePage/friends_screen.dart';
import 'package:wealth_wars/pages/homePage/settings_screen.dart';
import 'package:wealth_wars/methods/shared_preferences.dart';
import 'package:wealth_wars/methods/player_class.dart';
import 'package:wealth_wars/methods/friend_manager.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late IO.Socket socket;
  final cookieManager = WebviewCookieManager();

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  Future<void> initSocket() async {
    final cookies = await cookieManager.getCookies('https://wealthwars.games');
    String sessionCookie = cookies
        .firstWhere(
          (cookie) => cookie.name == 'connect.sid',
        )
        .value;

    socket = IO.io('https://wealthwars.games:3010', <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': {'cookie': 'connect.sid=$sessionCookie'},
      'withCredentials': true,
    });

    socket.on('connect', (_) {
      logger.d('Socket connected for invitation');
      logger.d("Envio evento sendMap");
      socket.emit('sendMap');
    });

    socket.on('invitationReceived', (data) {
      logger.d("Se ha recibido una invitación: $data");

      showInvitationDialog(data);
    });

    socket.on('mapSent', (map) {
      logger.d("Reconectando al usuario $map");

      List<Player> players = [];
      List<dynamic> playersJson = map['players'];
      List<int> surrendered = List<int>.from(map['surrendered']);

      for (int i = 0; i < playersJson.length; i++) {
        var playerJson = playersJson[i];
        Player player = Player.fromEmailNamePicture(
            playerJson['email'], playerJson['name'], playerJson['picture']);
        // Check if this player's index is in the surrendered list
        if (surrendered.contains(i)) {
          player.surrender = true;
        }
        players.add(player);
      }

      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => GameScreen(
                socket: socket,
                players: players,
                gameMap: map,
              )));
    });

    socket.on('achievementUnlocked', (data) {
      logger.d("Enhorabuena, has completado el logro: $data");

      showCustomToast(data, context);
    });

    socket.onError((data) {
      logger.d('Error: $data');
    });

    socket.onDisconnect((_) => logger.d('disconnect'));

    socket.connect();
  }

  void showInvitationDialog(dynamic invitationData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Invitación Recibida",
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Invitación de: ${invitationData['userInfo']['name']}",
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              ClipOval(
                child: Image.network(
                  invitationData['userInfo']['picture'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Aceptar', style: TextStyle(color: Colors.green)),
              onPressed: () async {
                var userData = await getUserData();
                Player player = Player(
                    email: userData?['email'],
                    profileImageUrl: userData?['picture'],
                    name: userData?['name']);

                socket.dispose();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LobbyScreen(
                          joinCode: invitationData['userCode'].toString(),
                          player: player,
                          userFriends: null)),
                );
              },
            ),
            TextButton(
              child:
                  const Text('Rechazar', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void navigateToAccount() async {
      var userData = await getUserData();
      String username = userData?['name'];
      String email = userData?['email'];
      String picture = userData?['picture'];
      String password = userData?['password'];
      int numVics = await getNumVics(email);
      List<String> myAwards = await getMyAwards(email);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
              username: username,
              email: email,
              picture: picture,
              numVics: numVics,
              password: password,
              myAwards: myAwards),
        ),
      );
    }

    Future<void> navigateToAwards() async {
      var userData = await getUserData();
      String email = userData?['email'];
      List<String> myAwards = await getMyAwards(email);
      final Logger logger = Logger();
      logger.d(myAwards);
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => AwardsScreen(myAwards: myAwards)),
      );
    }

    Future<void> navigateToFriends() async {
      var userData = await getUserData();
      String email = userData?['email'];

      List<dynamic> myFriends = await getUserFriends(email);

      List<dynamic> myRequests = await getUserRequests(email);

      List<dynamic> sendedRequests = await getUserSendedRequests(email);

      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => FriendsScreen(
                myFriends: myFriends,
                myRequests: myRequests,
                sendedRequests: sendedRequests,
                email: email)),
      );
    }

    void navigateToSettings() async {
      var userData = await getUserData();
      String email = userData?['email'];

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SettingsScreen(email: email),
        ),
      );
    }

    void showGamePopup() async {
      var userData = await getUserData();
      Player player = Player(
          email: userData?['email'],
          profileImageUrl: userData?['picture'],
          name: userData?['name']);

      List<dynamic> myFriends = await getUserFriends(userData?['email']);

      showDialog(
        context: context,
        builder: (BuildContext context) =>
            PopUpSalas(player: player, userFriends: myFriends, socket: socket),
      );
    }

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF083344),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MenuButton(
                          iconData: Icons.gamepad,
                          label: 'Juego',
                          onNavigate: showGamePopup)),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MenuButton(
                                  iconData: Icons.account_circle,
                                  label: 'Perfil',
                                  onNavigate: navigateToAccount,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MenuButton(
                                  iconData: Icons.settings,
                                  label: 'Ajustes',
                                  onNavigate: navigateToSettings,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MenuButton(
                                  iconData: Icons.emoji_events,
                                  label: 'Logros',
                                  onNavigate: navigateToAwards,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MenuButton(
                                  iconData: Icons.group,
                                  label: 'Amigos',
                                  onNavigate: navigateToFriends,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<int> getNumVics(String email) async {
    final cookieManager = WebviewCookieManager();
    final cookies = await cookieManager.getCookies('https://wealthwars.games');
    String sessionCookie = cookies
        .firstWhere(
          (cookie) => cookie.name == 'connect.sid',
        )
        .value;
    String url = 'https://wealthwars.games:3010/users/$email/wins';

    final Logger logger = Logger();

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'connect.sid=$sessionCookie',
        },
      );

      if (response.statusCode == 200) {
        logger.d("Obtención del numero de victorias: ${response.body}");
        int victorias = jsonDecode(response.body);
        return victorias;
      } else {
        logger.e("Error en la solicitud: ${response.statusCode}");
        return 0;
      }
    } catch (error) {
      logger.e("Error al hacer la solicitud: $error");
      return 0;
    }
  }
}

class MenuButton extends StatelessWidget {
  final IconData iconData;
  final String label;
  final VoidCallback onNavigate;

  const MenuButton({
    super.key,
    required this.iconData,
    required this.label,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEA970A),
      child: InkWell(
        borderRadius: BorderRadius.circular(13.0),
        onTap: onNavigate,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(iconData, size: 50.0),
            Text(label, style: const TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
