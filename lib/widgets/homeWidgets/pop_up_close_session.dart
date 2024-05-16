import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:wealth_wars/methods/shared_preferences.dart';
import 'package:wealth_wars/pages/loading_page.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:logger/logger.dart';
import 'package:wealth_wars/methods/account_manager.dart';

class PopUpCloseSession extends StatelessWidget {
  final IO.Socket socket;
  const PopUpCloseSession({super.key, required this.socket});

  @override
  Widget build(BuildContext context) {
    final WebviewCookieManager cookieManager = WebviewCookieManager();
    Logger logger = Logger();
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
                'Cerrar sesión',
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
                    '¿Estás seguro de que quieres cerrar sesión?\nTendrás que volver a iniciar sesión',
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
                        if (socket.connected) {
                          socket.disconnect();
                        }
                        socket.dispose();
                        logout();
                        await clearAllData();
                        cookieManager.clearCookies().then((_) {
                          logger.d("Cookies cleared successfully.");
                        }).catchError((e) {
                          logger.e("Failed to clear cookies: $e");
                        });
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoadingScreen()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const IntrinsicWidth(
                        child: Row(
                          children: [
                            Text('Cerrar sesión'),
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
