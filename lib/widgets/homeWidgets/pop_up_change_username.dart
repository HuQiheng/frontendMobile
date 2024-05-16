import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:wealth_wars/methods/account_manager.dart';
import 'package:wealth_wars/methods/shared_preferences.dart';
import 'package:wealth_wars/pages/homePage/home_screen.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class PopUpChangeUsername extends StatefulWidget {
  final String email;
  final String password;
  final String picture;

  const PopUpChangeUsername(
      {Key? key,
      required this.email,
      required this.password,
      required this.picture});

  @override
  _PopUpChangeUsernameState createState() => _PopUpChangeUsernameState();
}

class _PopUpChangeUsernameState extends State<PopUpChangeUsername> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Logger logger = Logger();
    return AlertDialog(
      contentPadding:
          const EdgeInsets.only(top: 2, right: 20, left: 20, bottom: 20),
      backgroundColor: const Color(0xFF083344),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Cambiar nombre de usuario',
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
            Container(
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
                  const SizedBox(height: 8),
                  TextField(
                    controller:
                        _usernameController, // Asocia el controlador al TextField
                    decoration: InputDecoration(
                      hintText: 'Introduce tu nuevo nombre de usuario',
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color(0xFF005A88),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Obtener el texto del TextField
                        String newUsername = _usernameController.text;
                        logger.d(newUsername);
                        await updateUser(widget.email, newUsername,
                            widget.password, widget.picture);
                        // Regresa a pantalla principal (maybe un pop up más de feedback)
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0066CC),
                        foregroundColor: Colors.white,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Confirmar'),
                          SizedBox(width: 10),
                          Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
