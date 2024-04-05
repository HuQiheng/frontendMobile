import 'package:flutter/material.dart';
import 'package:wealth_wars/pages/lobby_screen.dart';

class PopUpSalas extends StatelessWidget {
  const PopUpSalas({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFEA970A);
    const Color backgroundColor = Color(0xFF083344);
    const TextStyle buttonTextStyle = TextStyle(color: Colors.white);

    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: primaryColor,
      foregroundColor: Colors.black,
      shadowColor: Colors.black54,
      elevation: 5,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
    );

    return AlertDialog(
      backgroundColor: backgroundColor,
      content: Container(
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.verified_user_rounded,
                      color: Colors.white, size: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: buttonStyle,
                      onPressed: () => _navigateToLobby(context),
                      child: const Text('Crear sala', style: buttonTextStyle),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.key, color: Colors.white, size: 40),
                  const TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Código de unión',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: buttonStyle,
                      onPressed: () => _navigateToLobby(context),
                      child: Text('Unirme', style: buttonTextStyle),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton(
            style: buttonStyle,
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cerrar', style: buttonTextStyle),
          ),
        ),
      ],
    );
  }

  void _navigateToLobby(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LobbyScreen()),
    );
  }
}
