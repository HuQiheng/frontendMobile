import 'package:flutter/material.dart';
import 'package:wealth_wars/methods/player_class.dart';

class PlayersLobby extends StatelessWidget {
  final List<Color> colorsIcon = [
    const Color.fromRGBO(59, 130, 246, 1),
    const Color.fromRGBO(244, 63, 94, 1),
    const Color.fromRGBO(245, 158, 11, 1),
    const Color.fromRGBO(34, 197, 94, 1),
  ];

  final List<Color> colorsBanner = [
    const Color.fromRGBO(29, 65, 123, 1),
    const Color.fromRGBO(122, 32, 47, 1),
    const Color.fromRGBO(122, 79, 5, 1),
    const Color.fromRGBO(17, 99, 47, 1),
  ];

  final List<Player> players;

  PlayersLobby({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    List<Widget> playerWidgets = [];

    for (int i = 0; i < players.length; i++) {
      playerWidgets.add(
        Card(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          elevation: 2,
          color: colorsBanner[i],
          child: ListTile(
            leading: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorsIcon[i],
                border: Border.all(color: Colors.black, width: 2.0),
              ),
              child: Image.network(
                players[i].profileImageUrl,
                width: 30,
                height: 30,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, size: 30, color: Colors.yellow),
              ),
            ),
            title: Text(
              players[i].email,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: playerWidgets,
    );
  }
}
