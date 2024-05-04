import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wars/methods/theme_settings.dart';
import 'package:wealth_wars/pages/loading_page.dart';
import 'package:wealth_wars/methods/sound_settings.dart';

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
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SoundSettings()),
          ChangeNotifierProvider(create: (_) => ThemeSettings()),
        ],
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeSettings>(context);
    return MaterialApp(
      title: 'Wealth Wars App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode:
          themeProvider.darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      home:
          const LoadingScreen(), // The loading screen is used as the initial screen, and later redirected to the correct one.
    );
  }
}
