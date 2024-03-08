import 'package:flutter/material.dart';
import 'custom_page_route.dart';

// Widget to display the central information on the screen.
class Info extends StatelessWidget {
  final String title;
  final String description;
  final Widget page;

  const Info(this.title, this.description, this.page, {super.key});

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
            onPressed: () => Navigator.of(context).push(
              CustomPageRoute(child: page),
            ),
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

// Widget to display the right scrolling button.
class ScrollButtonRight extends StatelessWidget {
  final Widget page;

  const ScrollButtonRight(this.page, {super.key});

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
            onPressed: () => Navigator.of(context).push(
              CustomPageRoute(child: page),
            ),
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
