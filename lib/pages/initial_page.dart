import 'package:flutter/material.dart';
import '../widgets/initial_page_widgets.dart';

class InitialScreen1 extends StatelessWidget {
  const InitialScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wealth Wars Initial Page 1',
      home: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 85,
              padding: const EdgeInsets.all(10),
            ),
            const Info(
                'Wealth Wars',
                'Un juego de estrategia donde tendrás que ganar dinero, erigir fábricas, y \n conquistar territorios para expandir tu influencia.',
                InitialScreen2()),
            const ScrollButtonRight(InitialScreen2()),
          ],
        ),
      ),
    );
  }
}

class InitialScreen2 extends StatelessWidget {
  const InitialScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wealth Wars Initial Page 2',
      home: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 85,
              padding: const EdgeInsets.all(10),
            ),
            const Info('Juega Con Tus Amigos', '...', InitialScreen1()),
            const ScrollButtonRight(InitialScreen1()),
          ],
        ),
      ),
    );
  }
}
