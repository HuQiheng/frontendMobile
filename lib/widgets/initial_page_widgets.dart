import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
          border: Border.all(
            color: const Color(0xFF083344),
            width: 4.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(),
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
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

// Widget to display the central login information on the screen.
class InfoLogin extends StatefulWidget {
  final String title;
  final String description;
  final VoidCallback onNavigate;
  final VoidCallback handleSignIn;

  const InfoLogin(this.title, this.description,
      {super.key, required this.onNavigate, required this.handleSignIn});

  @override
  // ignore: library_private_types_in_public_api
  _InfoLoginState createState() => _InfoLoginState();
}

class _InfoLoginState extends State<InfoLogin> {
  final logger = Logger();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.shade900.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF083344),
            width: 4.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(),
            ElevatedButton(
              onPressed: widget.handleSignIn,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFFEA970A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: const Text(
                'Iniciar sesión con Google',
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
                backgroundColor: const Color(0xFFEA970A),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: const BorderSide(color: Color(0xFF083344), width: 2.0),
                ),
              ),
              child: const Text(
                'Anterior',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
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
                backgroundColor: const Color(0xFFEA970A),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: const BorderSide(color: Color(0xFF083344), width: 2.0),
                ),
              ),
              child: const Text(
                'Siguiente',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
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
