import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import '../../widgets/lobbyWidgets/pop_up_salas.dart';
import 'package:wealth_wars/pages/homePage/account_screen.dart';
import 'package:wealth_wars/pages/homePage/awards_screen.dart';
import 'package:wealth_wars/pages/homePage/friends_screen.dart';
import 'package:wealth_wars/pages/homePage/settings_screen.dart';
import 'package:wealth_wars/methods/shared_preferences.dart';
import 'package:wealth_wars/methods/player_class.dart';
import 'package:wealth_wars/methods/friend_manager.dart';

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
    });

    socket.on('invitationReceived', (data) {
      logger.d("Se ha recibido una invitación: $data");

      showInvitationDialog(data);
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
          title: const Text("Invitación Recibida"),
          content: Text("Invitación de: ${invitationData['userInfo']['name']}"),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Rechazar'),
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

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
              username: username,
              email: email,
              picture: picture,
              password: password),
        ),
      );
    }

    void navigateToAwards() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const AwardsScreen()),
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
