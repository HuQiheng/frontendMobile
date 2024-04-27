import 'package:flutter/material.dart';
import 'package:wealth_wars/widgets/lobbyWidgets/pop_up_salas.dart';
import 'package:wealth_wars/methods/player_class.dart';

class PopUpInfo extends StatelessWidget {
  const PopUpInfo({super.key});

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

  Widget contentBox(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(width: 40),
                const Text(
                  '¿Cómo jugar?',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                IconButton(
                  color: Colors.white,
                  iconSize: 35,
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const Divider(
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: 200.0,
              child: ListView(
                children: const [
                  Center(
                    child: Text(
                      '1. Invierte en fábricas o tropas',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Durante esta fase podrás comprar una fábrica y tantas tropas como puedas, cada tropa cuesta 2 monedas y cada fábrica 15 monedas',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEA970A)),
                    ),
                  ),
                  Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                  Center(
                    child: Text(
                      '2. Conquista territorios',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Ataca tantos territorios de comandantes enemigos como puedas',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEA970A)),
                    ),
                  ),
                  Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                  Center(
                    child: Text(
                      '3. Reorganiza tus tropas',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Moviliza tropas entre dos territorios conectados entre sí por territorios de tu posición (solo podrás hacer esta acción una vez por ronda)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEA970A)),
                    ),
                  ),
                  Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
