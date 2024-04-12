import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wealth_wars/pages/GamePage/game_screen.dart';
import 'package:wealth_wars/pages/HomePage/home_screen.dart';
import 'package:wealth_wars/widgets/players_lobby.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class LobbyScreen extends StatefulWidget {
  final bool isHost;

  const LobbyScreen({super.key, this.isHost = false});

  @override
  // ignore: library_private_types_in_public_api
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  final cookieManager = WebviewCookieManager();
  late IO.Socket socket;
  String accessCode = '';
  Logger logger = Logger();

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
      logger.d('Socket connected');
      if (widget.isHost) {
        socket.emit('createRoom');
      }
    });

    socket.on('accessCode', (code) {
      setState(() {
        logger.d("Codigo de sala: $code");
        accessCode = code.toString();
      });
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
                child: PlayersLobby(players: 4),
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
                            subtitle: Center(
                              child: Text(
                                accessCode,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (widget.isHost) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) => const HomeScreen()));
                            } else {
                              socket.emit('leaveRoom', accessCode);
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
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => const GameScreen())),
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
