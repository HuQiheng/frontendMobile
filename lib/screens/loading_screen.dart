import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // Reemplaza esto con tu siguiente pantalla después del splash

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5), // Puedes cambiar el tiempo de espera aquí
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                const HomeScreen()), // Cambia YourNextScreen por tu pantalla principal
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Puedes cambiar 'assets/logo.png' por tu imagen de logo
            Image.asset('assets/logo.png', height: 120.0),
            const SizedBox(height: 20),
            const CircularProgressIndicator(), // Un indicador de carga
          ],
        ),
      ),
    );
  }
}
