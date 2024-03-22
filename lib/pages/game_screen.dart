import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: MapScreen(),
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/iberian_map.svg';
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: SvgPicture.asset(
            assetName,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
