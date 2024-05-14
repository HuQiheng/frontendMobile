//import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:wealth_wars/methods/player_class.dart';
import 'package:wealth_wars/methods/sound_settings.dart';
import 'package:wealth_wars/widgets/gameWidgets/map.dart';
import 'package:wealth_wars/widgets/gameWidgets/turn_info.dart';
import 'package:wealth_wars/widgets/gameWidgets/resources_info.dart';
import 'package:wealth_wars/widgets/gameWidgets/players_info.dart';
import 'package:wealth_wars/widgets/gameWidgets/pop_up_leave_room.dart';
import 'package:wealth_wars/widgets/gameWidgets/pop_up_surrender.dart';
import 'package:wealth_wars/widgets/gameWidgets/pop_up_winner.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class GameScreen extends StatelessWidget {
  final IO.Socket socket;
  final List<Player> players;
  final Map<String, dynamic> gameMap;
  const GameScreen(
      {super.key,
      required this.socket,
      required this.players,
      required this.gameMap});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MapScreen(
          players: players,
          socket: socket,
          gameMap: gameMap,
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  final IO.Socket socket;
  final List<Player> players;
  Map<String, dynamic> gameMap;
  MapScreen(
      {super.key,
      required this.players,
      required this.socket,
      required this.gameMap});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double _positionChat = -300.0;
  final List<types.Message> _messages = [];
  Logger logger = Logger();
  bool _isLoading = true;
  bool sended = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  late ConfettiController _confettiController;
  bool hasSurrendered = false;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));

    initMusic();

    widget.socket.off('mapSent');

    widget.socket.on('mapSent', (map) {
      logger.d("Mapa recibido desde pantalla game: $map");
      setState(() {
        widget.gameMap = map;
      });
    });

    widget.socket.on('gameOver', (data) {
      widget.socket.dispose();
      _audioPlayer.stop();
      _audioPlayer.dispose();
      logger.d("Informacion de fin de partida: $data");
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PopUpWinner(
            data: data,
          );
        },
      );
    });

    widget.socket.on('victory', (sal) {
      logger.d("Victoria recibida $sal");
      bool soundsEnabled =
          Provider.of<SoundSettings>(context, listen: false).soundsEnabled;
      if (soundsEnabled) {
        AudioPlayer winnerSound = AudioPlayer();
        _playSound(winnerSound);
      }
      _confettiController.play();
    });

    widget.socket.on('messageReceived', (message) {
      logger.d("Mensaje recibido $message");
      // Si no es mensaje mio
      if (!sended) {
        int index = widget.players
            .indexWhere((player) => player.email.trim() == message['user']);

        if (index != -1) {
          final textMessage = types.TextMessage(
            author: types.User(
                id: '${message['user']}',
                firstName: widget.players[index].name,
                imageUrl: widget.players[index].profileImageUrl),
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: DateTime.now().toString(),
            text: message['message'],
          );

          setState(() {
            _messages.insert(0, textMessage);
          });
        }
      } else {
        // He recibido un mensaje mio
        setState(() {
          sended = false;
        });
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      logger.d("Carga completada, actualizando estado...");

      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    widget.socket.dispose();
    _confettiController.dispose();
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  void initMusic() async {
    bool soundsEnabled =
        Provider.of<SoundSettings>(context, listen: false).soundsEnabled;
    if (soundsEnabled) {
      logger.d("Reproduccion de musica: ");
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.play(AssetSource('sounds/game_music.mp3'));
    }
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: const types.User(id: 'user1'), // Actual User
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toString(),
      text: message.text,
    );

    widget.socket.emit('sendMessage', message.text.toString());

    setState(() {
      sended = true;
      _messages.insert(0, textMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //=======================
          //==========MAP==========
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _positionChat = -300.0;
                  FocusScope.of(context).unfocus();
                });
              },
              child: MapWidget(
                  key: ValueKey(widget.gameMap),
                  gameMap: widget.gameMap,
                  socket: widget.socket),
            ),
          ),
          //=============================
          //==========CHAT_ICON==========
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _positionChat = 0.0;
                });
              },
              child: const Icon(Icons.chat),
            ),
          ),
          //=============================
          //==========TURN_INFO==========
          Align(
              alignment: Alignment.bottomCenter,
              child: TurnInfo(
                socket: widget.socket,
                players: widget.players,
                gameMap: widget.gameMap,
              )),
          //================================
          //==========PLAYERS_INFO==========
          Padding(
            padding: const EdgeInsets.only(bottom: 75),
            child: Align(
                alignment: Alignment.centerRight,
                child: PlayersInfo(players: widget.players)),
          ),
          //============================
          //==========SURRENDER==========
          Positioned(
            left: 10,
            top: 5,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _positionChat = -300.0;
                  FocusScope.of(context).unfocus();
                });
                if (!hasSurrendered) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PopUpSurrender(socket: widget.socket);
                    },
                  ).then((value) {
                    // Verificar si el valor devuelto es verdadero, lo que indica que se ha rendido
                    if (value == true) {
                      setState(() {
                        hasSurrendered = true;
                      });
                    }
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PopUpLeaveRoom(
                          socket: widget.socket, audioPlayer: _audioPlayer);
                    },
                  );
                }
              },
              icon: Icon(
                hasSurrendered ? Icons.logout : Icons.flag,
                size: 60,
                color: Colors.red,
              ),
            ),
          ),
          //==================================
          //==========RESOURCES_INFO==========
          Align(
            alignment: Alignment.centerLeft,
            child:
                ResourcesInfo(gameMap: widget.gameMap, players: widget.players),
          ),
          //========================
          //==========CHAT==========
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            top: 0,
            bottom: 0,
            right: _positionChat,
            child: Container(
                width: 300,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: const Border(
                    left: BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                  color: const Color(0xFF083344),
                ),
                child: Chat(
                  messages: _messages,
                  onSendPressed: _handleSendPressed,
                  user: const types.User(id: 'user1'), // Actual User
                  theme: const DefaultChatTheme(
                    backgroundColor: Color(0xFF083344),
                  ),
                  showUserNames: true,
                )),
          ),
          //=====================================
          //==========PANTALLA DE CARGA==========     Si da problemas se quita y no se pone
          if (_isLoading)
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Conectando con el servidor de juego'),
                  SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            ),
          Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                maxBlastForce: 20,
                minBlastForce: 5,
                emissionFrequency: 0.02,
                numberOfParticles: 100,
                gravity: 0.3,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ],
                particleDrag: 0.05,
              )),
        ],
      ),
    );
  }
}

Future<void> _playSound(winner) async {
  await winner.play(AssetSource('sounds/trumpet_victory.mp3'));
}
