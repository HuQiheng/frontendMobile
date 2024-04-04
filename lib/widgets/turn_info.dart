import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final List<Color> colors = [
  const Color.fromRGBO(59, 130, 246, 1),
  const Color.fromRGBO(244, 63, 94, 1),
  const Color.fromRGBO(245, 158, 11, 1),
  const Color.fromRGBO(34, 197, 94, 1),
];

// debug
final List<String> usuarios = ['User 1', 'User 2', 'User 3', 'User 4'];

class TurnInfo extends StatefulWidget {
  const TurnInfo({super.key});

  @override
  State<TurnInfo> createState() => _TurnInfoState();
}

class _TurnInfoState extends State<TurnInfo> {
  final logger = Logger();
  var fase = 0;
  var player = 0;   // backend in json

  void buttonClicked() {
    setState(() {       
      // setstate using for the rerender the screen 
      // if we not use than it not show the sceond text
      if(fase+1 == 3){
        logger.d("Tocaría cambiar de jugador");
        player = (player + 1) % 4;
      }
      fase = (fase + 1) % 3;
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
                usuarios[player],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(
                height: 0,
              ),
              Text(
                texts[fase],
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
              color: colors[player],
              border: Border.all(color: Colors.black, width: 3.0),
            ),
            child: IconButton(
              onPressed: () {
                buttonClicked();
                logger.d("Estás en fase: $fase ");
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
            child: const Center(
              child: Text(
                '60',
                style: TextStyle(
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
