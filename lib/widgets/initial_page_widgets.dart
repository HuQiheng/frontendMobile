import 'package:flutter/material.dart';

// Widget to display the central information on the screen.
class Info extends StatelessWidget {
  final String title;
  final String description;

  const Info(this.title, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.shade900.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Page title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // Page description
            const SizedBox(height: 20),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget to display the central login information on the screen.
class InfoLogin extends StatelessWidget {
  final String title;
  final String description;

  const InfoLogin(this.title, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.shade900.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Page title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // Page description
            const SizedBox(height: 20),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // Page button
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {}, // Login functionality
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // Button border radius
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 10), // Button padding
              ),
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget with the navigation buttons of the principal page
class NavigationButtons extends StatelessWidget {
  final PageController pageController;
  final ValueNotifier<int> pageIndexNotifier;

  const NavigationButtons({
    super.key,
    required this.pageController,
    required this.pageIndexNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: pageIndexNotifier,
      builder: (_, pageIndex, __) {
        List<Widget> buttons = [];

        if (pageIndex > 0) {
          buttons.add(
            ElevatedButton(
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.yellow,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                'Anterior',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        }

        if (pageIndex < 3) {
          buttons.add(
            ElevatedButton(
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.yellow,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                'Siguiente',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        }

        return Row(
          mainAxisAlignment: buttons.length == 1
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceEvenly,
          children: buttons,
        );
      },
    );
  }
}
