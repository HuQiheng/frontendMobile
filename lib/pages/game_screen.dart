import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: MapScreen(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _showContainer = false;

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/iberian_map.svg';
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _showContainer = false;
              });
            },
            child: SvgPicture.asset(
              assetName,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _showContainer = !_showContainer;
              });
            },
            child: const Icon(Icons.chat),
          ),
        ),
        if (_showContainer)
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: const Border(
                  left: BorderSide(
                    color: Color.fromARGB(255, 0, 0, 0),
                    width: 2.0,
                  ),
                ),
                borderRadius: BorderRadius.circular(4.0),
                color: const Color.fromARGB(255, 255, 206, 120),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 255, 255, 255),
                            filled: true,
                            hintText: 'Enviar mensaje',
                            prefixIcon: const Icon(Icons.chat),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
