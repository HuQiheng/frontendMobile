//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:logger/logger.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:wealth_wars/methods/player_class.dart';
import 'package:wealth_wars/widgets/gameWidgets/map.dart';
import 'package:wealth_wars/widgets/gameWidgets/turn_info.dart';
import 'package:wealth_wars/widgets/gameWidgets/resources_info.dart';
import 'package:wealth_wars/widgets/gameWidgets/players_info.dart';
import 'package:wealth_wars/widgets/gameWidgets/pop_up_surrender.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class GameScreen extends StatelessWidget {
  final IO.Socket socket;
  final Map<String, dynamic> gameMap;
  final List<Player> players;
  const GameScreen(
      {super.key,
      required this.socket,
      required this.gameMap,
      required this.players});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MapScreen(
          gameMap: gameMap,
          players: players,
          socket: socket,
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  final IO.Socket socket;
  final List<Player> players;
  final Map<String, dynamic> gameMap;
  const MapScreen(
      {super.key,
      required this.gameMap,
      required this.players,
      required this.socket});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double _positionChat = -300.0;
  final List<types.Message> _messages = [];
  Logger logger = Logger();
  bool _isLoading = true;

  int phase = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      logger.d("Carga completada, actualizando estado...");

      setState(() {
        _isLoading = false;
      });
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: const types.User(id: 'user1'), // Actual User
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toString(),
      text: message.text,
    );

    setState(() {
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
                  gameMap: widget.gameMap,
                )),
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
              child: TurnInfo(players: widget.players)),
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return PopUpSurrender(socket: widget.socket);
                  },
                );
              },
              icon: const Icon(
                Icons.logout,
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
                  color: const Color.fromARGB(255, 255, 206, 120),
                ),
                child: Chat(
                  messages: _messages,
                  onSendPressed: _handleSendPressed,
                  user: const types.User(id: 'user1'), // Actual User
                  theme: const DefaultChatTheme(
                    backgroundColor: Color.fromARGB(255, 255, 206, 120),
                  ),
                  showUserNames: true,
                )),
          ),
          //=====================================
          //==========PANTALLA DE CARGA==========
          if (_isLoading)
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
