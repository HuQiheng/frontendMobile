import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:wealth_wars/widgets/gameWidgets/map.dart';

class PopUpMove extends StatefulWidget {
  final GameRegion region1, region2;
  final IO.Socket socket;

  const PopUpAttack(
      {super.key,
      required this.region1,
      required this.region2,
      required this.socket});

  @override
  PopUpMoveState createState() => PopUpMoveState();
}

class PopUpMoveState extends State<PopUpMove> {  

  int _counter = 1;
  void incrementCounter() {
    setState(() {
      if (_counter < widget.region1.troops - 1) {
        _counter++;
      }
    });
  }

  void decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding:
          const EdgeInsets.only(top: 2, right: 20, left: 20, bottom: 20),
      backgroundColor: const Color(0xFF083344),
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text(
                    'Mover tropas',
                    style: TextStyle(
                      color: Color(0xFFEA970A),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.monetization_on_outlined,
                    size: 30,
                    color: Color(0xFFEA970A),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(4.0),
                color: const Color(0xFFEA970A),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    '¿Cuantas tropas quieres movilizar?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                  const Divider(
                    color: Color(0xFF083344),
                    indent: 45,
                    endIndent: 45,
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Desde ",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.region1.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        " van a ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.region2.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF083344),
                          ),
                          onPressed: decrementCounter,
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$_counter',
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF083344),
                          ),
                          onPressed: incrementCounter,
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color(0xFF083344),
                    indent: 45,
                    endIndent: 45,
                    thickness: 2,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF083344),
                      ),
                      onPressed: () {
                        final logger = Logger();
                        logger.d(widget.region1.code);
                        widget.socket.emit('moveTroops', [
                          widget.region1.code,
                          widget.region2.code,
                          _counter
                        ]);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'CONFIRMAR',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
