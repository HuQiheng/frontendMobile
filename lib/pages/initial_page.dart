import 'package:flutter/material.dart';
import '../widgets/initial_page_widgets.dart';

class InitialPage1 extends StatelessWidget {
  const InitialPage1({super.key});

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
            Info(
                'Wealth Wars',
                'Un juego de estrategia donde tendrás que ganar dinero, erigir fábricas, y \n conquistar territorios para expandir tu influencia',
                const InitialPage2(),
                this),
            ScrollButtonRight(const InitialPage2(), this),
          ],
        ),
      ),
    );
  }
}

class InitialPage2 extends StatelessWidget {
  const InitialPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wealth Wars Initial Page 2',
      home: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ScrollButtonLeft(const InitialPage1(), this),
            Info(
                'Completa logros',
                'Consigue completar todos los logros, tanto los más fáciles, \n como los más exclusivos y así hacerte con todas las insignias',
                const InitialPage3(),
                this),
            ScrollButtonRight(const InitialPage3(), this),
          ],
        ),
      ),
    );
  }
}

class InitialPage3 extends StatelessWidget {
  const InitialPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wealth Wars Initial Page 3',
      home: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ScrollButtonLeft(const InitialPage2(), this),
            Info(
                'Agrega amigos',
                'Haz todos los amigos que desees para jugar con ellos y \n presumir de tus insignias con ellos',
                const InitialPage4(),
                this),
            ScrollButtonRight(const InitialPage4(), this),
          ],
        ),
      ),
    );
  }
}

class InitialPage4 extends StatelessWidget {
  const InitialPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wealth Wars Initial Page 4',
      home: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ScrollButtonLeft(const InitialPage3(), this),
            InfoLogin(
                'Comienza a jugar',
                'Crea una nueva cuenta o incia sesión con una ya existente \n para empezar a jugar ya',
                const InitialPage1(),
                this),
            Container(
              width: 85,
              padding: const EdgeInsets.all(10),
            ),
          ],
        ),
      ),
    );
  }
}
