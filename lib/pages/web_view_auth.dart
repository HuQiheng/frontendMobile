import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final VoidCallback onNavigate;

  const WebViewScreen({super.key, required this.onNavigate});

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  final WebviewCookieManager cookieManager = WebviewCookieManager();
  Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
          'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36')
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url
                .startsWith('https://wealthwars.games:3010/?user=')) {
              Uri uri = Uri.parse(request.url);
              logger.d("La uri es $uri");
              String userJson = uri.queryParameters['user'] ?? '';
              logger.d("JSON recibido de user: $userJson");

              if (userJson.isNotEmpty) {
                try {
                  Map<String, dynamic> user = jsonDecode(userJson);
                  logger.d("Nombre de usuario: ${user['name']}");
                } catch (e) {
                  logger.e("Error parsing user JSON: $e");
                }
              } else {
                logger.d("No user JSON data found.");
              }

              Navigator.pop(context);
              widget.onNavigate();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://wealthwars.games:3010/auth/google'));

    cookieManager.clearCookies().then((_) {
      logger.d("Cookies cleared successfully.");
    }).catchError((e) {
      logger.e("Failed to clear cookies: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Iniciar sesión"),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
