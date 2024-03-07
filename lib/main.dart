import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/loading_screen.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Asegura que tengas inicialización para los widgets
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Wealth Wars App',
      home:
          LoadingScreen(), // Usa tu pantalla de carga como la pantalla inicial
    );
  }
}
