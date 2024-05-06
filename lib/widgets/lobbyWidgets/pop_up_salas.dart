import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:wealth_wars/pages/gamePage/lobby_screen.dart';
import 'package:wealth_wars/methods/player_class.dart';
import 'package:wealth_wars/widgets/lobbyWidgets/pop_up_info.dart';

class PopUpSalas extends StatelessWidget {
  final Player player;
  final List<dynamic> userFriends;
  final IO.Socket socket;
  PopUpSalas(
      {super.key,
      required this.player,
      required this.userFriends,
      required this.socket});

  final TextEditingController joinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFEA970A);
    const Color backgroundColor = Color(0xFF083344);
    const TextStyle buttonTextStyle = TextStyle(
      color: Colors.black,
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
                                controller: joinCodeController,
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
                            /*const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 50,
                              child: Image.asset(
                                'assets/icons/join.png',
                                fit: BoxFit.contain,
                              ),
                            ),*/
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 60,
              ),
              ElevatedButton(
                style: buttonStyle,
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cerrar', style: buttonTextStyle),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const PopUpInfo();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.all(8),
                ),
                child: const Icon(
                  Icons.help_outline,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToLobbyHost(BuildContext context) {
    socket.dispose();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LobbyScreen(
              isHost: true, player: player, userFriends: userFriends)),
    );
  }

  void _navigateToLobbyGuest(BuildContext context) {
    socket.dispose();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LobbyScreen(
              joinCode: joinCodeController.text,
              player: player,
              userFriends: null)),
    );
  }
}
