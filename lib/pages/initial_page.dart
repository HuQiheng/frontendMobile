import 'package:flutter/material.dart';
import '../widgets/initial_page_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final PageController _pageController = PageController(initialPage: 0);
  final ValueNotifier<int> _pageIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _pageIndexNotifier.value = _pageController.page?.round() ?? 0;
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(() {});
    _pageIndexNotifier.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wealth Wars Initial Page',
      home: Scaffold(
        body: Container(
          // Background image
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/wallpaper.webp"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: const [
                    InitialPage1(),
                    InitialPage2(),
                    InitialPage3(),
                    InitialPage4(),
                  ],
                ),
              ),
              SmoothPageIndicator(
                  controller: _pageController, // PageController
                  count: 4,
                  effect: const ExpandingDotsEffect(
                    dotColor: Color.fromRGBO(234, 151, 10, 1),
                    activeDotColor: Color.fromRGBO(13, 71, 161, 1),
                  ),
                  onDotClicked: (index) {}),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: NavigationButtons(
                    pageController: _pageController,
                    pageIndexNotifier: _pageIndexNotifier),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InitialPage1 extends StatelessWidget {
  const InitialPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Wealth Wars Initial Page 1',
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Info(
            'Wealth Wars',
            'Un juego de estrategia donde tendrás que ganar dinero, erigir fábricas, y \n conquistar territorios para expandir tu influencia',
          ),
        ),
      ),
    );
  }
}

class InitialPage2 extends StatelessWidget {
  const InitialPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Wealth Wars Initial Page 2',
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SizedBox(
            width: 500,
            child: Info(
              'Completa logros',
              'Consigue completar todos los logros, tanto los más fáciles, como los más exclusivos y así hacerte con todas las insignias',
            ),
          ),
        ),
      ),
    );
  }
}

class InitialPage3 extends StatelessWidget {
  const InitialPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Wealth Wars Initial Page 3',
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SizedBox(
            width: 500,
            child: Info(
              'Agrega amigos',
              'Haz todos los amigos que desees para jugar con ellos y presumir de tus insignias con ellos',
            ),
          ),
        ),
      ),
    );
  }
}

class InitialPage4 extends StatelessWidget {
  const InitialPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Wealth Wars Initial Page 4',
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SizedBox(
            width: 500,
            child: InfoLogin(
              'Comienza a jugar',
              'Crea una nueva cuenta o incia sesión con una ya existente para empezar a jugar ya',
            ),
          ),
        ),
      ),
    );
  }
}
