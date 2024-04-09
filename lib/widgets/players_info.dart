import 'package:flutter/material.dart';

class PlayersInfo extends StatelessWidget {
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

  final List<String> usuarios = ['User 1', 'User 2', 'User 3', 'User 4'];

  final int players;

  PlayersInfo({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    List<Widget> playerWidgets = [];

    double maxWidth = 0.0;

    //username width
    for (String texto in usuarios) {
      TextSpan span = TextSpan(
        text: texto,
      );
      TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      if (tp.width > maxWidth) {
        if (tp.width < 135) {
          maxWidth = tp.width + 45;
        } else {
          maxWidth = 180;
        }
      }
    }

    for (int i = 0; i < players; i++) {
      playerWidgets.add(
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 6.5, bottom: 6.5),
              padding: const EdgeInsets.only(left: 35),
              width: maxWidth,
              height: 37.5,
              decoration: BoxDecoration(
                color: colorsBanner[i],
                border: const Border(
                  top: BorderSide(color: Colors.black, width: 2.0),
                  bottom: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  usuarios[i],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorsIcon[i],
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: const Icon(
                  Icons.supervised_user_circle,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: playerWidgets,
    );
  }
}
