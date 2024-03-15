import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF083344),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: MenuButton(
                    iconData: Icons.gamepad,
                    label: 'Juego',
                  ),
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
                              padding: EdgeInsets.all(8.0),
                              child: MenuButton(
                                iconData: Icons.account_circle,
                                label: 'Perfil',
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: MenuButton(
                                iconData: Icons.settings,
                                label: 'Ajustes',
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
                              padding: EdgeInsets.all(8.0),
                              child: MenuButton(
                                iconData: Icons.emoji_events,
                                label: 'Logros',
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: MenuButton(
                                iconData: Icons.group,
                                label: 'Amigos',
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

  const MenuButton({
    super.key,
    required this.iconData,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEA970A),
      child: InkWell(
        onTap: () {},
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
