import 'package:flutter/material.dart';
import 'package:wealth_wars/widgets/lobbyWidgets/pop_up_salas.dart';
import 'package:wealth_wars/methods/player_class.dart';

class PopUpInfo extends StatelessWidget {
  final Player player;

  const PopUpInfo({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: const Color(0xFF083344),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                color: Colors.white,
                iconSize: 35,
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        PopUpSalas(player: player),
                  );
                },
              ),
            ],
          ),
          const Text(
            '¿Cómo jugar?',
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            height: 200.0,
            child: ListView(
              children: const [
                Divider(
                  indent: 150,
                  endIndent: 150,
                ),
                Center(
                  child: Text(
                    '1. Invierte en fábricas o tropas',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Divider(
                  indent: 150,
                  endIndent: 150,
                ),
                Center(
                  child: Text(
                    '2. Conquista territorios',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Divider(
                  indent: 150,
                  endIndent: 150,
                ),
                Center(
                  child: Text(
                    '3. Reorganiza tus tropas',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Divider(
                  indent: 150,
                  endIndent: 150,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
