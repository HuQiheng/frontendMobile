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
            child: const Expanded(
              child: MapWidget(),
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
        const Align(alignment: Alignment.bottomCenter, child: TurnInfo()),
        Padding(
          padding: const EdgeInsets.only(bottom: 75, right: 10),
          child: Align(
              alignment: Alignment.centerRight, child: PlayersInfo(players: 4)),
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

class TurnInfo extends StatelessWidget {
  const TurnInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          width: 315.0,
          height: 60.0,
          decoration: const BoxDecoration(
            color: Color.fromARGB(175, 57, 57, 57),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Nombre de usuario',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                height: 0,
              ),
              Text(
                'INVERTIR',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: 10,
          child: Container(
            width: 75.0,
            height: 75.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(color: Colors.black, width: 3.0),
            ),
            child: const Icon(
              Icons.supervised_user_circle,
              size: 60,
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 10,
          child: Container(
            width: 75.0,
            height: 75.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(color: Colors.black, width: 3.0),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.skip_next,
                size: 55,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Positioned(
          right: 17.5,
          top: 70,
          child: Container(
            width: 40,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(color: Colors.black, width: 2.0),
            ),
            child: const Center(
              child: Text(
                '60',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PlayersInfo extends StatelessWidget {
  final List<Color> colors = [
    const Color.fromRGBO(59, 130, 246, 1),
    const Color.fromRGBO(244, 63, 94, 1),
    const Color.fromRGBO(245, 158, 11, 1),
    const Color.fromRGBO(34, 197, 94, 1),
  ];

  final int players;

  PlayersInfo({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    List<Widget> playerWidgets = [];

    int i = players;

    while (i > 0) {
      playerWidgets.add(
        Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors[i - 1],
            border: Border.all(color: Colors.black, width: 2.0),
          ),
          child: const Icon(
            Icons.supervised_user_circle,
            size: 40,
          ),
        ),
      );
      i--;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: playerWidgets,
    );
  }
}
