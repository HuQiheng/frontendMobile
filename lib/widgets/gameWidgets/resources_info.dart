import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wealth_wars/methods/player_class.dart';
import 'package:wealth_wars/methods/shared_preferences.dart';

class ResourcesInfo extends StatefulWidget {
  final Map<String, dynamic> gameMap;
  final List<Player> players;

  const ResourcesInfo(
      {super.key, required this.gameMap, required this.players});

  @override
  _ResourcesInfoState createState() => _ResourcesInfoState();
}

class _ResourcesInfoState extends State<ResourcesInfo> {
  // Jugador del sistema
  // ignore: prefer_typing_uninitialized_variables
  var playerSystem;

  @override
  void initState() {
    super.initState();
    getUserData().then((userData) {
      setState(() {
        playerSystem = userData?['email'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentPlayer = widget.gameMap['players']
        [widget.players.indexWhere((player) => player.email == playerSystem)];
    Logger logger = Logger();
    logger.d(
        "Email de usuario del que se muestra info: ${currentPlayer['email']} ");

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(7.5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF083344),
          width: 2.0,
        ),
      ),
      child: IntrinsicHeight(
        child: IntrinsicWidth(
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.monetization_on_outlined,
                    size: 30,
                    color: Color(0xFFEA970A),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${currentPlayer['coins']}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
