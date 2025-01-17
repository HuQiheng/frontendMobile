import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:wealth_wars/methods/player_class.dart';
import 'package:wealth_wars/widgets/gameWidgets/map.dart' as mapa;
import 'package:wealth_wars/methods/shared_preferences.dart';

final List<Color> colors = [
  const Color.fromRGBO(59, 130, 246, 1),
  const Color.fromRGBO(244, 63, 94, 1),
  const Color.fromRGBO(245, 158, 11, 1),
  const Color.fromRGBO(34, 197, 94, 1),
];

class TurnInfo extends StatefulWidget {
  final Map<String, dynamic> gameMap;
  final IO.Socket socket;
  final List<Player> players;
  const TurnInfo(
      {super.key,
      required this.players,
      required this.socket,
      required this.gameMap});

  @override
  State<TurnInfo> createState() => _TurnInfoState();
}

class _TurnInfoState extends State<TurnInfo> {
  final logger = Logger();
  int phase = 0;
  int player = 0;

  // ignore: prefer_typing_uninitialized_variables
  var playerSystem;

  @override
  void initState() {
    super.initState();
    phase = widget.gameMap['phase'];
    player = widget.gameMap['turn'];

    // Queremos saber quien es el usuario del sistema
    getUserData().then((userData) {
      setState(() {
        var playerEmail = userData?['email'];
        playerSystem =
            widget.players.indexWhere((player) => player.email == playerEmail);
        logger.d("Indice del jugador del sistema: $playerSystem");
      });
    });

    widget.socket.on('nextTurn', (data) {
      logger.d("Siguiente turno recibido");
      setState(() {
        logger.d("He recibido siguiente turno: $player");
        do {
          player = (player + 1) % widget.players.length;
        } while (widget.players[player].surrender);
        logger.d("Jugador resultante: $player");
        mapa.updatePlayer(player);
        if (playerSystem == player) {
          logger.d("Me toca a mi y soy el jugador del movil");
        }
      });
    });

    widget.socket.on('userSurrendered', (email) {
      logger.d("Email de la persona que se rindio: $email");

      int playerIndex =
          widget.players.indexWhere((player) => player.email == email);

      widget.socket.emit("nextTurn");

      if (playerIndex != -1) {
        setState(() {
          widget.players[playerIndex].surrender = true;
        });
        logger.d("${widget.players[playerIndex].name} se ha rendido.");
      } else {
        logger.e("No se encontró al jugador con el email: $email");
      }
    });
  }

  void changePhase() {
    setState(() {
      if (phase == 2) {
        widget.socket.emit("nextTurn");
      } else {
        widget.socket.emit("nextPhase");
      }
      phase = (phase + 1) % 3;
      mapa.updatePhase(phase);
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

    // Consider if the player is the user fo the app
    if (player == playerSystem && !widget.players[playerSystem].surrender) {
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
        ],
      );
    } else {
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
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
