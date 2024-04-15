import 'package:flutter/material.dart';
import 'dart:async';

class PopUpAttack extends StatelessWidget {
  final String attackRegion;
  final String defenseRegion;

  const PopUpAttack(
      {super.key, required this.attackRegion, required this.defenseRegion});

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
              const Text(
                'Selección de tropas',
                style: TextStyle(
                  color: Color(0xFFEA970A),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
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
                    '¡Elige el número de tropas\ncon las que atacar!',
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
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          attackRegion,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Image.asset(
                          'assets/icons/duel.png',
                          width: 40,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          defenseRegion,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color(0xFF083344),
                    indent: 45,
                    endIndent: 45,
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF083344),
                        ),
                        onPressed: () {
                          Navigator.pop(context);

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              Future.delayed(const Duration(seconds: 8), () {
                                Navigator.of(context).pop();
                              });
                              return PopUpDuel(
                                attackRegion: attackRegion,
                                defenseRegion: defenseRegion,
                              );
                            },
                          );
                        },
                        child: const Text(
                          '1',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF083344),
                        ),
                        onPressed: () {
                          Navigator.pop(context);

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              Future.delayed(const Duration(seconds: 8), () {
                                Navigator.of(context).pop();
                              });
                              return PopUpDuel(
                                attackRegion: attackRegion,
                                defenseRegion: defenseRegion,
                              );
                            },
                          );
                        },
                        child: const Text(
                          '2',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF083344),
                        ),
                        onPressed: () {
                          Navigator.pop(context);

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              Future.delayed(const Duration(seconds: 8), () {
                                Navigator.of(context).pop();
                              });
                              return PopUpDuel(
                                attackRegion: attackRegion,
                                defenseRegion: defenseRegion,
                              );
                            },
                          );
                        },
                        child: const Text(
                          '3',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ],
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

class PopUpDuel extends StatefulWidget {
  final String attackRegion;
  final String defenseRegion;

  const PopUpDuel(
      {super.key, required this.attackRegion, required this.defenseRegion});

  @override
  _PopUpDuelState createState() => _PopUpDuelState();
}

class _PopUpDuelState extends State<PopUpDuel> {
  int countdown = 3;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          timer.cancel();
        }
      });
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
          const Text(
            'Batalla',
            style: TextStyle(
              color: Color(0xFFEA970A),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
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
                  const Divider(
                    color: Color(0xFF083344),
                    indent: 45,
                    endIndent: 45,
                    thickness: 2,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.attackRegion,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Image.asset(
                          'assets/icons/duel.png',
                          width: 40,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.defenseRegion,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color(0xFF083344),
                    indent: 45,
                    endIndent: 45,
                    thickness: 2,
                  ),
                  if (countdown == 0)
                    const Text(
                      '7 vs 4\nEl ganador es...',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (countdown > 0)
                    Text(
                      '$countdown',
                      style: const TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
