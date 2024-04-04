import 'package:flutter/material.dart';
import 'package:wealth_wars/pages/lobby_screen.dart';

class PopUpSalas extends StatelessWidget {
  const PopUpSalas({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF083344),
      content: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                  color: const Color(0xFFEA970A),
                ),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LobbyScreen()),
                      );
                    },
                    child: const Text('Crear sala'),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 0, 0, 0), width: 3.0),
                  borderRadius: BorderRadius.circular(4.0),
                  color: const Color(0xFFEA970A),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Codigo de unión',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {},
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LobbyScreen()),
                        );
                      },
                      child: const Text('Unirme'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cerrar'),
          ),
        ),
      ],
    );
  }
}
