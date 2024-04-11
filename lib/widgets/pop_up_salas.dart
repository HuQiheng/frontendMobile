import 'package:flutter/material.dart';
import 'package:wealth_wars/pages/lobby_screen.dart';

class PopUpSalas extends StatelessWidget {
  const PopUpSalas({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFEA970A);
    const Color backgroundColor = Color(0xFF083344);
    const TextStyle buttonTextStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: primaryColor,
      foregroundColor: Colors.black,
      shadowColor: Colors.black54,
      elevation: 5,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
    );

    final OutlineInputBorder borderStyle = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white70),
      borderRadius: BorderRadius.circular(10),
    );

    MediaQueryData originalMediaQueryData = MediaQuery.of(context);

    MediaQueryData customMediaQueryData = originalMediaQueryData.copyWith(
        viewInsets: EdgeInsets.zero, viewPadding: EdgeInsets.zero);

    return MediaQuery(
      data: customMediaQueryData,
      child: AlertDialog(
        backgroundColor: backgroundColor,
        content: SizedBox(
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                child: Card(
                  color: const Color(0xFF1A3A4A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Image.asset(
                            'assets/icons/play.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ElevatedButton(
                            style: buttonStyle,
                            onPressed: () => _navigateToLobbyHost(context),
                            child: const Text('Crear sala',
                                style: buttonTextStyle),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  color: const Color(0xFF1A3A4A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Row(
                          children: [
                            Flexible(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: 'Código de unión',
                                  labelStyle:
                                      const TextStyle(color: Colors.white70),
                                  enabledBorder: borderStyle,
                                  focusedBorder: borderStyle.copyWith(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 50, // Cambia este valor al tamaño deseado
                              child: Image.asset(
                                'assets/icons/join.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ElevatedButton(
                            style: buttonStyle,
                            onPressed: () => _navigateToLobbyGuest(context),
                            child: const Text('Unirme', style: buttonTextStyle),
                          ),
                        ),
                      ],
                    ),
                  ),
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
              child: const Text('Cerrar', style: buttonTextStyle),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToLobbyHost(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const LobbyScreen(
                isHost: true,
              )),
    );
  }

  void _navigateToLobbyGuest(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LobbyScreen()),
    );
  }
}
