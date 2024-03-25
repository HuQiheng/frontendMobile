import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
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
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _showContainer = false;
  final List<types.Message> _messages = [];

  @override
  void initState() {
    super.initState();
    // Inicial Messages
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
    const String assetName = 'assets/iberian_map.svg';
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _showContainer = false;
              });
            },
            child: SvgPicture.asset(
              assetName,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _showContainer = !_showContainer;
              });
            },
            child: const Icon(Icons.chat),
          ),
        ),
        if (_showContainer)
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
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
              ),
            ),
          ),
      ],
    );
  }
}
