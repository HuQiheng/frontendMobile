import 'package:flutter/material.dart';
import '../widgets/pop_up_salas.dart';
import 'package:wealth_wars/pages/account_screen.dart';
import 'package:wealth_wars/pages/awards_screen.dart';
import 'package:wealth_wars/pages/friends_screen.dart';
import 'package:wealth_wars/pages/settings_screen.dart';
import 'package:wealth_wars/methods/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToAccount() async {
      final userData = await getUserData();
      String username = userData?['name'];

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProfileScreen(username: username),
        ),
      );
    }

    void navigateToAwards() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const AwardsScreen()),
      );
    }

    void navigateToFriends() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const FriendsScreen()),
      );
    }

    void navigateToSettings() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );
    }

    return MaterialApp(
      home: Scaffold(
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
                                  onNavigate: navigateToAccount,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MenuButton(
                                  iconData: Icons.settings,
                                  label: 'Ajustes',
                                  onNavigate: navigateToSettings,
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
                                  onNavigate: navigateToAwards,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MenuButton(
                                  iconData: Icons.group,
                                  label: 'Amigos',
                                  onNavigate: navigateToFriends,
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
        borderRadius: BorderRadius.circular(13.0),
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
