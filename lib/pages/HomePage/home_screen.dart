import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../widgets/lobbyWidgets/pop_up_salas.dart';
import 'package:wealth_wars/pages/HomePage/account_screen.dart';
import 'package:wealth_wars/pages/HomePage/awards_screen.dart';
import 'package:wealth_wars/pages/HomePage/friends_screen.dart';
import 'package:wealth_wars/pages/HomePage/settings_screen.dart';
import 'package:wealth_wars/methods/shared_preferences.dart';
import 'package:wealth_wars/methods/player_class.dart';

import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToAccount() async {
      var userData = await getUserData();
      String username = userData?['name'];
      String email = userData?['email'];
      String picture = userData?['picture'];
      String password = userData?['password'];

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
              username: username,
              email: email,
              picture: picture,
              password: password),
        ),
      );
    }

    void navigateToAwards() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const AwardsScreen()),
      );
    }

    Future<void> navigateToFriends() async {
      var userData = await getUserData();
      String email = userData?['email'];

      List<dynamic> myFriends = await getUserFriends(email);

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => FriendsScreen(myFriends: myFriends)),
      );
    }

    void navigateToSettings() async {
      var userData = await getUserData();
      String email = userData?['email'];

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SettingsScreen(email: email),
        ),
      );
    }

    void showGamePopup() async {
      var userData = await getUserData();
      Player player = Player(
          email: userData?['email'],
          profileImageUrl: userData?['picture'],
          name: userData?['name']);

      showDialog(
        context: context,
        builder: (BuildContext context) => PopUpSalas(player: player),
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
                          onNavigate: showGamePopup)),
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

Future<List<dynamic>> getUserFriends(String email) async {
  final cookieManager = WebviewCookieManager();
  final cookies = await cookieManager.getCookies('https://wealthwars.games');
  String sessionCookie = cookies
      .firstWhere(
        (cookie) => cookie.name == 'connect.sid',
      )
      .value;
  String url = 'https://wealthwars.games:3010/users/$email/friends';
  
  final Logger logger = Logger();
  logger.d(url);

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'cookie': 'connect.sid=$sessionCookie',
      },
    );

    if (response.statusCode == 200) {
      // La solicitud fue exitosa, decodificar el JSON y devolver los datos
      List<dynamic> friendsData = json.decode(response.body);
      return friendsData;
    } else if (response.statusCode == 403) {
      // Acceso denegado
      throw Exception('Acceso denegado');
    } else {
      // Otro código de estado, manejar según sea necesario
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  } catch (error) {
    // Manejar errores de conexión o de otro tipo
    throw Exception('Error al hacer la solicitud: $error');
  }
}