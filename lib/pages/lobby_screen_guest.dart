import 'package:flutter/material.dart';
import 'package:wealth_wars/pages/home_screen.dart';
import 'package:wealth_wars/widgets/players_info.dart';

class LobbyScreenGuest extends StatelessWidget {
  const LobbyScreenGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF083344),
        body: SafeArea(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: PlayersInfo(players: 4),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.yellow, width: 2.0),
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.yellow,
                      ),
                      child: const ListTile(
                        title: Text(
                          'Código:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('<Código>'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (_) => const HomeScreen())),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xFFEA970A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text('Abandonar sala'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
