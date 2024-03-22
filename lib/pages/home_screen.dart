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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LobbyScreen()),
                        );
                      }),
                ),
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
