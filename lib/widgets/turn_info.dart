import 'package:flutter/material.dart';

class TurnInfo extends StatelessWidget {
  const TurnInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          width: 315.0,
          height: 60.0,
          decoration: const BoxDecoration(
            color: Color.fromARGB(175, 57, 57, 57),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Nombre de usuario',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                height: 0,
              ),
              Text(
                'INVERTIR',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: 10,
          child: Container(
            width: 75.0,
            height: 75.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(color: Colors.black, width: 3.0),
            ),
            child: const Icon(
              Icons.supervised_user_circle,
              size: 60,
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 10,
          child: Container(
            width: 75.0,
            height: 75.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(color: Colors.black, width: 3.0),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.skip_next,
                size: 55,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Positioned(
          right: 17.5,
          top: 70,
          child: Container(
            width: 40,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(color: Colors.black, width: 2.0),
            ),
            child: const Center(
              child: Text(
                '60',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
