import 'package:flutter/material.dart';
import 'package:wealth_wars/pages/homePage/home_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PopUpWinner extends StatelessWidget {
  final dynamic data;
  final IO.Socket socket;
  const PopUpWinner({super.key, required this.data, required this.socket});

  @override
  Widget build(BuildContext context) {
    List<dynamic> ranking = data['ranking'];

    // Email que queremos encontrar
    String targetEmail = data['email'];

    // Buscar el nombre correspondiente al email
    String name = "";
    for (var player in ranking) {
      if (player['email'] == targetEmail) {
        name = player['name'];
        break;
      }
    }

    return AlertDialog(
      contentPadding:
          const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
      backgroundColor: const Color(0xFF083344),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              // data['message'],
              "$name ha ganado la partida!!",
              style: const TextStyle(
                color: Color(0xFFEA970A),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: data['ranking'].length,
                itemBuilder: (context, index) {
                  var player = data['ranking'][index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(player['picture']),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(player['name'],
                        style: const TextStyle(color: Colors.white)),
                    subtitle: Row(
                      children: [
                        Icon(Icons.monetization_on,
                            color: Colors.yellow[700], size: 16),
                        Text(' ${player['coins']} ',
                            style: const TextStyle(color: Colors.white70)),
                        Icon(Icons.star, color: Colors.amber[400], size: 16),
                        Text(' ${player['points']}',
                            style: const TextStyle(color: Colors.white70)),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Comprobar socket
                socket.dispose();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066CC),
                foregroundColor: Colors.white,
              ),
              child: const Text('Salir de la partida'),
            ),
          ],
        ),
      ),
    );
  }
}
