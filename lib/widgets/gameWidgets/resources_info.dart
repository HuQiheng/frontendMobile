import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wealth_wars/methods/player_class.dart';

class ResourcesInfo extends StatelessWidget {
  final Map<String, dynamic> gameMap;
  final List<Player> players;
  const ResourcesInfo(
      {super.key, required this.gameMap, required this.players});

  @override
  Widget build(BuildContext context) {
    var currentPlayer = gameMap['players'][0];
    Logger logger = Logger();
    logger.d(
        "Nombre de usuario del que se muestra info: ${currentPlayer['email']} ");

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
