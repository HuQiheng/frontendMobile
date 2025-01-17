import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PopUpSurrender extends StatelessWidget {
  final IO.Socket socket;
  const PopUpSurrender({super.key, required this.socket});

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
                'Rendirse',
                style: TextStyle(
                  color: Color(0xFFEA970A),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context, false);
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
                    '¿Estás seguro de que quieres rendirte?\nTe quedaras viendo la partida\ny perderás tus territorios',
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
                        socket.emit("surrender");
                        Navigator.pop(context, true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const IntrinsicWidth(
                        child: Row(
                          children: [
                            Text('Rendirse'),
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
