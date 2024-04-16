import 'package:flutter/material.dart';
import 'package:wealth_wars/pages/loading_page.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class PopUpDelete extends StatelessWidget {
  final String email;
  const PopUpDelete({super.key, required this.email});

  //const PopUpDelete({super.key});

  Future<void> deleteUser(String email) async {
    final cookieManager = WebviewCookieManager();

    // Construir la URL con el email del usuario a eliminar
    Logger logger = Logger();
    logger.d("Tengo las cookies");
    String url = 'https://wealthwars.games/users/$email';

    final cookies = await cookieManager.getCookies('https://wealthwars.games');
    String sessionCookie = cookies
        .firstWhere(
          (cookie) => cookie.name == 'connect.sid',
        )
        .value;

    try {
      // Realizar la solicitud DELETE al backend
      var response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'cookie': 'connect.sid=$sessionCookie'
        },
      );

      // Verificar si la solicitud fue exitosa (código de estado 200)
      if (response.statusCode == 200) {
        // El usuario ha sido eliminado exitosamente
        logger.d('Respuesta del servidor: ${response.body}');
      } else {
        // La solicitud no fue exitosa, mostrar el mensaje de error
        logger.d('Error al eliminar usuario: ${response.statusCode}');
      }
    } catch (error) {
      // Manejar errores de conexión u otros errores
      logger.d('Error al eliminar usuario: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final WebviewCookieManager cookieManager = WebviewCookieManager();
    Logger logger = Logger();
    logger.d(email);
    return AlertDialog(
      contentPadding:
          const EdgeInsets.only(top: 2, right: 20, left: 20, bottom: 20),
      backgroundColor: const Color(0xFF083344),
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Borrar cuenta',
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
          Expanded(
            child: Container(
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
                  const Expanded(child: SizedBox.shrink()),
                  const Text(
                    '¿Estás seguro de que quieres borrar tu cuenta?\nNo podrás recuperar ninguno de tus logros\no puntuaciones.\n¿Estás realmente seguro?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                  //SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Borrar cuenta aquí
                        await deleteUser(email);

                        cookieManager.clearCookies().then((_) {
                          logger.d("Cookies cleared successfully.");
                        }).catchError((e) {
                          logger.e("Failed to clear cookies: $e");
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoadingScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const IntrinsicWidth(
                        child: Row(
                          children: [
                            Text('Borrar cuenta'),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
