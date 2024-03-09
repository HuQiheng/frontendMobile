import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

// Widget to display the central information on the screen.
class Info extends StatelessWidget {
  final String title;
  final String description;
  final Widget destinationPage;
  final Widget originPage;

  const Info(
      this.title, this.description, this.destinationPage, this.originPage,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
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
            ),
          ),
          // Page button
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(PageTransition(
              type: PageTransitionType.rightToLeftJoined,
              childCurrent: originPage,
              duration: const Duration(milliseconds: 800),
              reverseDuration: const Duration(milliseconds: 800),
              child: destinationPage,
            )),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: const Text(
              'SIGUIENTE',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget to display the central login information on the screen.
class InfoLogin extends StatelessWidget {
  final String title;
  final String description;
  final Widget destinationPage;
  final Widget originPage;

  const InfoLogin(
      this.title, this.description, this.destinationPage, this.originPage,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
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
            ),
          ),
          // Page button
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(PageTransition(
              type: PageTransitionType.rightToLeftJoined,
              childCurrent: originPage,
              duration: const Duration(milliseconds: 800),
              reverseDuration: const Duration(milliseconds: 800),
              child: destinationPage,
            )),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget to display the right scrolling button.
class ScrollButtonRight extends StatelessWidget {
  final Widget destinationPage;
  final Widget originPage;

  const ScrollButtonRight(this.destinationPage, this.originPage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(PageTransition(
              type: PageTransitionType.rightToLeftJoined,
              childCurrent: originPage,
              duration: const Duration(milliseconds: 800),
              reverseDuration: const Duration(milliseconds: 800),
              child: destinationPage,
            )),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: const Text(
              '>',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget to display the left scrolling button.
class ScrollButtonLeft extends StatelessWidget {
  final Widget destinationPage;
  final Widget originPage;

  const ScrollButtonLeft(this.destinationPage, this.originPage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(PageTransition(
              type: PageTransitionType.leftToRightJoined,
              childCurrent: originPage,
              duration: const Duration(milliseconds: 800),
              reverseDuration: const Duration(milliseconds: 800),
              child: destinationPage,
            )),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: const Text(
              '<',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
