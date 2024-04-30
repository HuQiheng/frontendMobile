import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:wealth_wars/methods/player_class.dart';
import 'package:wealth_wars/pages/gamePage/game_screen.dart';
import 'package:wealth_wars/pages/homePage/home_screen.dart';
import 'package:wealth_wars/widgets/lobbyWidgets/players_lobby.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LobbyScreen extends StatefulWidget {
  final bool isHost;
  final String? joinCode;
  final Player player;
  List<dynamic>? userFriends;

  LobbyScreen(
      {super.key,
      this.isHost = false,
      this.joinCode,
      required this.player,
      this.userFriends});

  @override
  // ignore: library_private_types_in_public_api
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  final cookieManager = WebviewCookieManager();
  late IO.Socket socket;
  String accessCode = '';
  Logger logger = Logger();
  late List<Player> players;

  @override
  void initState() {
    super.initState();
    players = [widget.player];
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

    // Aseguramos la conexión del socket
    socket.connect();

    socket.on('connect', (_) {
      logger.d('Socket connected');
      if (widget.isHost) {
        socket.emit('createRoom');
      } else {
        setState(() {
          accessCode = widget.joinCode.toString();
          logger.d("Codigo de sala: $accessCode");
        });
        socket.emit('joinRoom', accessCode);
      }
    });

    socket.on('playerJoined', (name) {
      logger.d("Se unió $name");
      Fluttertoast.showToast(
        msg: "Se unió $name",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFFEA970A),
        textColor: Colors.black,
        fontSize: 16.0,
      );
    });

    socket.on('nonExistingRoom', (data) {
      socket.dispose();

      Fluttertoast.showToast(
        msg: "Código de sala incorrecto: $accessCode",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFFEA970A),
        textColor: Colors.black,
        fontSize: 16.0,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });

    socket.on('accessCode', (code) {
      setState(() {
        logger.d("Codigo de sala: $code");
        accessCode = code.toString();
      });
    });

    socket.on('connectedPlayers', (data) {
      logger.d("Datos: $data");

      if (data is List) {
        // Ensure data is a list
        List<Player> newPlayers = [];
        for (var playerData in data) {
          if (playerData is Map<String, dynamic>) {
            // Ensure each item is a map
            try {
              var email =
                  playerData['email']?.toString() ?? 'default@email.com';
              var username =
                  playerData['username']?.toString() ?? 'default_username';
              var picture =
                  playerData['picture']?.toString() ?? 'default_picture_url';

              newPlayers
                  .add(Player.fromEmailNamePicture(email, username, picture));
            } catch (e) {
              logger.e("Error processing player data: $e");
            }
          } else {
            logger.e("Invalid player data type: ${playerData.runtimeType}");
          }
        }

        logger.d(newPlayers.toString());

        setState(() {
          players = newPlayers;
        });
      } else {
        logger.e("Data is not a List: ${data.runtimeType}");
      }
    });

    socket.on('achievementUnlocked', (data) {
      logger.d("Enhorabuena, has completado el logro: $data");

      Fluttertoast.showToast(
        msg: "Enhorabuena, has completado el logro: $data",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFFEA970A),
        textColor: Colors.black,
        fontSize: 16.0,
      );
    });

    socket.on('mapSent', (map) {
      logger.d("Empezando partida desde lobby");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => GameScreen(
                socket: socket,
                players: players,
                gameMap: map,
              )));
    });

    socket.onError((data) {
      logger.d('Error: $data');
    });

    socket.onDisconnect((_) => logger.d('disconnect'));
  }

  double _positionFriends = -350.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF083344),
        body: GestureDetector(
          onTap: () {
            setState(() {
              _positionFriends = -350.0;
            });
          },
          child: Stack(
            children: [
              SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: PlayersLobby(players: players),
                    ),
                    Expanded(
                      flex: 2,
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(16),
                        color: const Color(0xFF1A3A4A),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (widget.isHost) ...[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _positionFriends = 0.0;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: const Color(0xFFEA970A),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                  ),
                                  child: const Text('Invitar amigos'),
                                ),
                                const SizedBox(height: 16),
                              ],
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: ListTile(
                                  title: const Center(
                                    child: Text(
                                      'Código de la sala:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  subtitle: GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(
                                          ClipboardData(text: accessCode));
                                    },
                                    child: Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              // Aquí va el codigo de amigo
                                              Clipboard.setData(ClipboardData(
                                                  text:
                                                      accessCode)); // Copia el texto al portapapeles
                                              /*ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content: Text('Texto copiado al portapapeles')),
                                        );*/
                                              Fluttertoast.showToast(
                                                msg:
                                                    "Código de la sala copiado en el portapapeles",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor:
                                                    const Color(0xFFEA970A),
                                                textColor: Colors.black,
                                                fontSize: 16.0,
                                              );
                                            },
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  const Color(0xFF0066CC),
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            child: Text(accessCode),
                                          ),
                                          /*
                                    Text(
                                      accessCode,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.content_copy,
                                      size: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.6),
                                    ),*/
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  if (widget.isHost) {
                                    socket.dispose();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()),
                                    );
                                  } else {
                                    socket.emit('leaveRoom');
                                    socket.dispose();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: const Color(0xFFEA970A),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                ),
                                child: Text(widget.isHost
                                    ? 'Cerrar sala'
                                    : 'Abandonar sala'),
                              ),
                              const SizedBox(height: 16),
                              if (widget.isHost) ...[
                                ElevatedButton(
                                  onPressed: () {
                                    socket.emit('startGame', accessCode);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: const Color(0xFFEA970A),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                  ),
                                  child: const Text('Empezar juego'),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //======Friends invitations========

              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                top: 0,
                bottom: 0,
                right: _positionFriends,
                child: Container(
                  width: 350,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: const Border(
                      left: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                        width: 2.0,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                    color: const Color(0xFF1A3A4A),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 35,
                          ),
                          onPressed: () {
                            setState(() {
                              _positionFriends = -350.0;
                            });
                          },
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.userFriends?.length ?? 0,
                        itemBuilder: (context, index) {
                          var friend = widget.userFriends![index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(friend['picture']),
                            ),
                            title: Text(
                              friend['name'],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                logger.d(
                                    "Envio invite con email: ${friend['email']}");
                                socket.emit('invite', friend['email']);
                                Fluttertoast.showToast(
                                  msg: "Invitación enviada",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: const Color(0xFFEA970A),
                                  textColor: Colors.black,
                                  fontSize: 16.0,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }
}
