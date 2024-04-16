import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:wealth_wars/methods/player_class.dart';
import 'package:wealth_wars/pages/gamePage/game_screen.dart';
import 'package:wealth_wars/pages/HomePage/home_screen.dart';
import 'package:wealth_wars/widgets/lobbyWidgets/players_lobby.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LobbyScreen extends StatefulWidget {
  final bool isHost;
  final String? joinCode;
  final Player player;

  const LobbyScreen(
      {super.key, this.isHost = false, this.joinCode, required this.player});

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
          logger.d("Codigo de sala: $widget.joinCode");
          accessCode = widget.joinCode.toString();
        });
        socket.emit('joinRoom', widget.joinCode);
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

    socket.on('accessCode', (code) {
      setState(() {
        logger.d("Codigo de sala: $code");
        accessCode = code.toString();
      });
    });

    socket.on('connectedPlayers', (data) {
      logger.d("Jugador nuevo recibido: $data");
      List<dynamic> emailList = data as List<dynamic>;
      List<Player> newPlayers = emailList.map((email) {
        return Player.fromEmail(email.toString());
      }).toList();

      setState(() {
        players = newPlayers;
      });
    });

    socket.on('mapSended', (map) {
      logger.d("Mapa recibido: $map");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => GameScreen(
                socket: socket,
                gameMap: map,
              )));
    });

    socket.onError((data) {
      logger.d('Error: $data');
    });

    socket.onDisconnect((_) => logger.d('disconnect'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF083344),
        body: SafeArea(
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
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: ListTile(
                            title: const Center(
                              child: Text(
                                'Código de la sala:',
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                          msg: "Código de la sala copiado en el portapapeles",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: const Color(0xFFEA970A),
                                          textColor: Colors.black,
                                          fontSize: 16.0,
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: const Color(0xFF0066CC),
                                        textStyle: const TextStyle(
                                            fontSize: 16, fontStyle: FontStyle.italic),
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
                              socket.disconnect();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) => const HomeScreen()));
                            } else {
                              socket.emit('leaveRoom');
                              socket.disconnect();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) => const HomeScreen()));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: const Color(0xFFEA970A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                          ),
                          child: Text(
                              widget.isHost ? 'Cerrar sala' : 'Abandonar sala'),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
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
      ),
    );
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }
}
