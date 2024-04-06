import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logger/logger.dart';
import 'package:uni_links/uni_links.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

// Widget to display the central information on the screen.
class Info extends StatelessWidget {
  final String title;
  final String description;

  const Info(this.title, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.shade900.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF083344),
            width: 4.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(),
            // Page title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // Page description
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

// Widget to display the central login information on the screen.
class InfoLogin extends StatefulWidget {
  final String title;
  final String description;
  final VoidCallback onNavigate;

  const InfoLogin(this.title, this.description,
      {super.key, required this.onNavigate});

  @override
  // ignore: library_private_types_in_public_api
  _InfoLoginState createState() => _InfoLoginState();
}

class _InfoLoginState extends State<InfoLogin> {
  final logger = Logger();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> initUniLinks() async {
    _sub = linkStream.listen((String? link) {
      if (link != null) {
        Uri uri = Uri.parse(link);

        logger.d("Received deep link: $uri");

        if (uri.path == "/signinresult") {
          // Extract data from the deep link
          String? resultJson = uri.queryParameters['token'];

          // Handle the result data
          if (resultJson != null) {
            // Parse JSON data and handle it
            logger.d("Result from website: $resultJson");
          }
        }
      }
    }, onError: (err) {
      logger.e("Failed to handle incoming link: $err");
    });
  }

  void _handleSignIn() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      logger.d("HOLA");
      logger.d(googleUser?.email);
      if(googleUser != null){
        String ruta = "https://wealthwars.games:3010/users/" + googleUser.email;
        logger.d(ruta);
        obtenerInformacion(ruta);
      }
      // Una vez que el usuario se haya autenticado correctamente, puedes obtener la información de la URL de callback
      //      
    } catch (error) {
      logger.d('Error al iniciar sesión con Google: $error');
    }
  }

  void obtenerInformacion(String url) async {
    // Hacer la solicitud HTTP a la URL de callback
    logger.d("Entro");
    final response = await http.get(url as Uri);
    logger.d("PASO");

    // Verificar si la solicitud fue exitosa (código de estado 200)
    if (response.statusCode == 200) {
      // Extraer la información de la respuesta
      String body = response.body;
      logger.d('Respuesta de la URL de callback: $body');
      widget.onNavigate();
    } else {
      // Manejar errores de solicitud
      logger.d('Error al obtener la información: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.shade900.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF083344),
            width: 4.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(),
            ElevatedButton(
              onPressed: _handleSignIn,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFFEA970A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: const Text(
                'Iniciar sesión con Google',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget with the navigation buttons of the principal page
class NavigationButtons extends StatelessWidget {
  final PageController pageController;
  final ValueNotifier<int> pageIndexNotifier;

  const NavigationButtons({
    super.key,
    required this.pageController,
    required this.pageIndexNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: pageIndexNotifier,
      builder: (_, pageIndex, __) {
        List<Widget> buttons = [];

        if (pageIndex > 0) {
          buttons.add(
            ElevatedButton(
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFFEA970A),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: const BorderSide(color: Color(0xFF083344), width: 2.0),
                ),
              ),
              child: const Text(
                'Anterior',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }

        if (pageIndex < 3) {
          buttons.add(
            ElevatedButton(
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFFEA970A),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: const BorderSide(color: Color(0xFF083344), width: 2.0),
                ),
              ),
              child: const Text(
                'Siguiente',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }

        return Row(
          mainAxisAlignment: buttons.length == 1
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceEvenly,
          children: buttons,
        );
      },
    );
  }
}
