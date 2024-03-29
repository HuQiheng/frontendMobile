import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:wealth_wars/widgets/map.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: MapScreen(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double _positionChat = -300.0;
  final List<types.Message> _messages = [];

  void _onTapDown(BuildContext context, TapDownDetails details) {
    print('Usuario tocó en las coordenadas: ${details.globalPosition}');
  }

  @override
  void initState() {
    super.initState();
    // Initial Messages
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
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _positionChat = -300.0;
                FocusScope.of(context).unfocus();
              });
            },
            child: Expanded(
              child: MapWidget(
                size: 400,
              ),
            ),
          ),
        ),
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
            ),
          ),
        ),
      ],
    );
  }
}
