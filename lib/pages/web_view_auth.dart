import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final VoidCallback onNavigate;

  const WebViewScreen({super.key, required this.onNavigate});

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Iniciar sesión"),
      ),
      body: WebView(
        initialUrl: "https://wealthwars.games:3010/auth/google",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {},
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://wealthwars.games:3010/')) {
            Uri uri = Uri.parse(request.url);
            String userJson = uri.queryParameters['user'] ?? '';
            Map<String, dynamic> user =
                jsonDecode(Uri.decodeComponent(userJson));
            logger.d("Usuario: $user");
            Navigator.pop(context);
            widget.onNavigate();
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
