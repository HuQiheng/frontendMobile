import 'package:flutter/material.dart';
import 'package:wealth_wars/pages/home_screen.dart';

class PopUpSurrender extends StatelessWidget {
  const PopUpSurrender({super.key});

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
                'Abandonar partida',
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
                children: [
                  const Expanded(child: SizedBox.shrink()),
                  const Text(
                    '¿Estás seguro de que quieres rendirte?\nNo podrás regresar a la partida\ny perderás tus territorios',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                  //SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const IntrinsicWidth(
                        child: Row(
                          children: [
                            Text('Abandonar'),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
