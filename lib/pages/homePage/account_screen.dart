import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:wealth_wars/widgets/homeWidgets/pop_up_change_awards.dart';
import 'package:wealth_wars/widgets/homeWidgets/pop_up_change_username.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;
  final String picture;
  final String? password;
  // Strings de url1, url2, url3 con cada una de las imágenes seleccionadas para mostrar (insignias)

  const ProfileScreen({ 
    super.key,
    required this.username,
    required this.email,
    required this.picture,
    this.password,
  });

  @override
  Widget build(BuildContext context) {
    final Logger logger = Logger();
    logger.d("$username $email $picture");
    return Scaffold(
      backgroundColor: const Color(0xFF083344),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Perfil de $username',
          style: const TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFF083344),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(picture),
                ),
                Container(
                  // FALTA PASAR NUM VICTORIAS
                  padding: const EdgeInsets.all(10), // Valor ajustable
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Valor ajustable
                    color: const Color(0xFF0066CC),
                  ),
                  child: const Text(
                    'Victorias: 777',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                if (password != null) ...[
                  Row(
                    children: [
                      const Expanded(child: SizedBox.shrink()),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return PopUpChangeUsername(
                                  email: email,
                                  password: password!,
                                  picture: picture);
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF0066CC),
                          textStyle: const TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                        child: const Text('Cambiar nombre'),
                      ),
                      const Expanded(child: SizedBox.shrink()),
                    ],
                  ),
                ],
                Row(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Insignias:',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF0066CC),
                      ),
                      child: password != null
                          ? IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white),
                              onPressed: () async {
                                final List<String> myAwards = await getMyAwards(email);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return PopUpChangeAwards(
                                      myAwards: myAwards,
                                    );
                                  },
                                );
                              },
                            )
                          : const SizedBox.shrink(),
                    )
                  ],
                ),
                Container(
                  height: 1,
                  color: Colors.white24,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBadgePlaceholder(""),
                    _buildBadgePlaceholder(""),
                    _buildBadgePlaceholder(""),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadgePlaceholder(String url) {
  return Image.network(
    url,
    width: 64,
    height: 64,
    fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
    errorBuilder: (context, error, stackTrace) {
      // En caso de error al cargar la imagen, puedes mostrar un placeholder o un mensaje alternativo
      return Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(8),
        ),
      );
    },
  );
}


  Future<List<String>> getMyAwards(String email) async {
    final cookieManager = WebviewCookieManager();
    final cookies = await cookieManager.getCookies('https://wealthwars.games');
    String sessionCookie = cookies
        .firstWhere(
          (cookie) => cookie.name == 'connect.sid',
        )
        .value;
    String url = 'https://wealthwars.games:3010/users/$email/achievements';

    final Logger logger = Logger();

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'connect.sid=$sessionCookie',
        },
      );

      if (response.statusCode == 200) {
        Logger().d("Obtención de la lista de logros: ${response.body}");
        List<dynamic> awardsData = jsonDecode(response.body);
        List<String> titles = awardsData.map((award) => award["image_url"] as String).toList();
        return titles;
      } else {
        Logger().e("Error en la solicitud: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      Logger().e("Error al hacer la solicitud: $error");
      return [];
    }
  }
}
