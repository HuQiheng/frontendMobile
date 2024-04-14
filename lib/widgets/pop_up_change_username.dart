import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:wealth_wars/pages/HomePage/home_screen.dart';

class PopUpChangeUsername extends StatefulWidget {
  final String email;
  final String password;

  const PopUpChangeUsername({Key? key, required this.email, required this.password});

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
      contentPadding: const EdgeInsets.only(top: 2, right: 20, left: 20, bottom: 20),
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
                    controller: _usernameController, // Asocia el controlador al TextField
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
                        await updateUser(widget.email, newUsername, widget.password);
                        // Regresa a pantalla principal (maybe un pop up más de feedback)
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
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


Future<void> updateUser(String email, String newUsername, String password) async {
  String url = 'http://wealthwarsgames:3010/users/$email'; // La URL del endpoint debe ser /users/:email para que coincida con la ruta en el backend
  final Logger logger = Logger();
  try {
    // Construir el cuerpo de la solicitud JSON
    Map<String, dynamic> requestBody = {
      'username': newUsername,
      'password': password,
    };

    // Realizar la solicitud PUT al backend
    var response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    // Verificar si la solicitud fue exitosa (código de estado 200)
    if (response.statusCode == 200) {
      // El usuario ha sido actualizado exitosamente
      logger.d('Usuario actualizado exitosamente.');
      // Imprimir la respuesta del servidor
      logger.d('Respuesta del servidor: ${response.body}');
    } else {
      // La solicitud no fue exitosa, mostrar el mensaje de error
      logger.d('Error al actualizar usuario: ${response.statusCode}');
    }
  } catch (error) {
    // Manejar errores de conexión u otros errores
    logger.d('Error al actualizar usuario: $error');
  }
}
