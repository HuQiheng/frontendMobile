import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:wealth_wars/methods/player_class.dart';

final List<Color> colors = [
  const Color.fromRGBO(59, 130, 246, 1),
  const Color.fromRGBO(244, 63, 94, 1),
  const Color.fromRGBO(245, 158, 11, 1),
  const Color.fromRGBO(34, 197, 94, 1),
];

class TurnInfo extends StatefulWidget {
  final IO.Socket socket;
  final List<Player> players;
  const TurnInfo({super.key, required this.players, required this.socket});

  @override
  State<TurnInfo> createState() => _TurnInfoState();
}

class _TurnInfoState extends State<TurnInfo> {
  final logger = Logger();
  int phase = 0;
  int player = 0; // backend in json
  int timerSeconds = 90;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds > 0) {
        setState(() {
          timerSeconds--; // Decrementa el contador
        });
      } else {
        timer.cancel(); // Detiene el temporizador
        changePhase(); // Cambia de fase o jugador
        resetTimer();
      }
    });
  }

  void resetTimer() {
    setState(() {
      timerSeconds = 90; // Restablece el contador a 60 segundos
      startTimer(); // Reinicia el temporizador
    });
  }

  void changePhase() {
    setState(() {
      // setstate using for the rerender the screen
      // if we not use than it not show the sceond text
      if (phase + 1 == 3) {
        logger.d("Tocaría cambiar de jugador");
        player = (player + 1) % widget.players.length;
      }
      if (phase + 1 == 3) {
        widget.socket.emit("nextTurn");
      } else {
        widget.socket.emit("nextPhase");
      }
      phase = (phase + 1) % 3;
      timerSeconds = 90;
    });
  }

  @override
  Widget build(BuildContext context) {
    var texts = [
      // list of text which the text get form here
      "INVERTIR",
      "CONQUISTAR",
      "REORGANIZAR",
    ];

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          width: 315.0,
          height: 60.0,
          decoration: const BoxDecoration(
            color: Color.fromARGB(175, 57, 57, 57),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.players[player].name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(
                height: 0,
              ),
              Text(
                texts[phase],
                style: const TextStyle(
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
              color: colors[player],
              border: Border.all(color: Colors.black, width: 3.0),
            ),
            child: ClipOval(
              child: Image.network(
                widget.players[player].profileImageUrl.trim(),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
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
              color: colors[player],
              border: Border.all(color: Colors.black, width: 3.0),
            ),
            child: IconButton(
              onPressed: () {
                changePhase();
                logger.d("Estás en fase: $phase ");
              },
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
              color: colors[player],
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(color: Colors.black, width: 2.0),
            ),
            child: Center(
              child: Text(
                '$timerSeconds',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
