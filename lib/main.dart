import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wealth_wars/pages/loading_page.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures the initialization of the widgets.

  SystemChrome.setEnabledSystemUIMode(
    //Full screen mode
    SystemUiMode.immersiveSticky,
  );

  // It is set in horizontal format.
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
          LoadingScreen(), // The loading screen is used as the initial screen, and later redirected to the correct one.
    );
  }
}
