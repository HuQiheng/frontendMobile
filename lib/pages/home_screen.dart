import 'package:flutter/material.dart';
import 'package:wealth_wars/pages/lobby_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  //Para perfil
  void _navigateToAccount() {}

  //Para ajustes
  void _navigateToSettings() {}

  //Para logros
  void _navigateToAwards() {}

  //Para amigos
  void _navigateToFriends() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF083344),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MenuButton(
                      iconData: Icons.gamepad,
                      label: 'Juego',
                      onNavigate: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const PopUpSalas();
                          },
                        );
                      },
                    )),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MenuButton(
                                iconData: Icons.account_circle,
                                label: 'Perfil',
                                onNavigate: _navigateToAccount,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MenuButton(
                                iconData: Icons.settings,
                                label: 'Ajustes',
                                onNavigate: _navigateToSettings,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MenuButton(
                                iconData: Icons.emoji_events,
                                label: 'Logros',
                                onNavigate: _navigateToAwards,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MenuButton(
                                iconData: Icons.group,
                                label: 'Amigos',
                                onNavigate: _navigateToFriends,
                              ),
                            ),
                          ),
                        ],
                      ),
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

class MenuButton extends StatelessWidget {
  final IconData iconData;
  final String label;
  final VoidCallback onNavigate;

  const MenuButton({
    super.key,
    required this.iconData,
    required this.label,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEA970A),
      child: InkWell(
        onTap: onNavigate,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(iconData, size: 50.0),
            Text(label, style: const TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

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
