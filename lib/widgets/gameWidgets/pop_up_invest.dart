import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:wealth_wars/widgets/gameWidgets/map.dart';

class PopUpInvest extends StatelessWidget {
  final GameRegion region;
  int numFab;
  final IO.Socket socket;
  final Function(int) callback;

  PopUpInvest({super.key, required this.region, required this.numFab, required this.callback, required this.socket});

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
                'Proceso de inversión',
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
                    '¡Elige en que invertir!',
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
                  Text(
                    region.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
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
                            builder: (BuildContext context) {
                              return PopUpFactory(
                                region: region,
                                numFab: numFab,
                                callback: callback,
                                socket: socket,
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Fábricas',
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
                            builder: (BuildContext context) {
                              return PopUpTroop(
                                region: region,
                                socket: socket,
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Tropas',
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

class PopUpFactory extends StatelessWidget {
  final GameRegion region;
  int numFab;
  final IO.Socket socket;
  final Function(int) callback;
  PopUpFactory({super.key, required this.region, required this.numFab, required this.callback, required this.socket,});

  @override
  Widget build(BuildContext context) {
    final Logger logger = Logger();
    logger.d("Mi numero es: ");
    logger.d(numFab);
    if(numFab == 0){
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
                      'Comprar fábrica - 15',
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
                      '¿Deseas comprar una fábrica \npara el siguiente territorio?',
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
                    Text(
                      region.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
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
                            if(region.factories == 1){
                              // Saca un popUp
                              Fluttertoast.showToast(
                                msg: "No puedes tener más de una\nfábrica por territorio",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: const Color(0xFFEA970A),
                                textColor: Colors.black,
                                fontSize: 16.0,
                              );
                            }
                            else{
                              numFab = 1;
                              callback(numFab);
                              socket.emit('buyActives', ['factory', region.code, 1]);
                            }
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'SI',
                            style: TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF083344),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'NO',
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
    else{
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
                      'Ya has comprado una fábrica',
                      style: TextStyle(
                        color: Color(0xFFEA970A),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
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
                      'Ya has puesto una fábrica en esta ronda tendrás que esperar a tu siguiente fase de inversión para poder colocar otra nueva',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
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
                          },
                          child: const Text(
                            'OK',
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
}

class PopUpTroop extends StatefulWidget {
  final GameRegion region;
  final IO.Socket socket;

  const PopUpTroop({super.key, required this.region, required this.socket});

  @override
  PopUpTroopState createState() => PopUpTroopState();
}

class PopUpTroopState extends State<PopUpTroop> {
  int _counter = 1;
  int _cost = 0;
  void incrementCounter() {
    setState(() {
      if (_counter < 99) {
        _counter++;
        _cost = _counter*2;
      }
    });
  }

  void decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
        _cost = _counter*2;
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
                    'Comprar tropas - 2',
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
                    '¿Cuantas tropas quieres comprar?',
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
                  Text(
                    widget.region.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
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
                  Text(
                    'Cuestan $_cost monedas',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF083344),
                      ),
                      onPressed: () {
                        if(widget.region.troops + _counter > 99){
                          // Saca un popUp
                          Fluttertoast.showToast(
                            msg: "No puedes sobrepasar las 99 tropas por territorio",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: const Color(0xFFEA970A),
                            textColor: Colors.black,
                            fontSize: 16.0,
                          );
                        }
                        else{
                          final logger = Logger();
                          logger.d(widget.region.code);
                          widget.socket.emit('buyActives', ['troop', widget.region.code, _counter]);
                          Navigator.pop(context);
                        }
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
