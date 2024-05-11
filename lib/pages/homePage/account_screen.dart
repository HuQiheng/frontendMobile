import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:wealth_wars/widgets/homeWidgets/pop_up_change_username.dart';

// Diccionario que asocia el nombre del logro con el nombre del archivo de imagen
Map<String, String> achievementImages = {
  'Bienvenido a WealthWars': 'assets/insignias/jugar_1_partida.png',
  'Comandante principiante': 'assets/insignias/ganar_1_partida.png',
  'Comandante experimentado': 'assets/insignias/ganar_10_partidas.png',
  'Comandante veterano': 'assets/insignias/ganar_100_partidas.png',
  'Tu primer compañero': 'assets/insignias/añadir_1_amigo.png',
  'Conquistador': 'assets/insignias/conquista_1_territorio.png',
  'Industrializador': 'assets/insignias/comprar_1_fabrica.png',
  'Revolución industrial': 'assets/insignias/comprar_15_fabricas.png',
  'La Armada Invencible': 'assets/insignias/conseguir_99_tropas.png',
  'Mileurista': 'assets/insignias/conseguir_1000_monedas.png'
};

class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;
  final String picture;
  final int numVics;
  final String? password;
  final List<String> myAwards;

  const ProfileScreen({
    super.key,
    required this.username,
    required this.email,
    required this.picture,
    required this.numVics,
    this.password,
    required this.myAwards,
  });

  @override
  Widget build(BuildContext context) {
    final Logger logger = Logger();
    logger.d("$username $email $picture");

    List<Widget> badges = myAwards.map((award) {
      String assetUrl = achievementImages[award] ?? "";
      return _buildBadgePlaceholder(assetUrl);
    }).toList();

    List<Widget> badgeRows = [];
    for (int i = 0; i < badges.length; i += 3) {
      List<Widget> rowItems =
          badges.sublist(i, i + 3 > badges.length ? badges.length : i + 3);
      if (rowItems.length < 3) {
        int placeholdersNeeded = 3 - rowItems.length;
        for (int j = 0; j < placeholdersNeeded; j++) {
          rowItems.add(_buildEmptyBadgePlaceholder());
        }
      }

      badgeRows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rowItems,
      ));

      if (i + 3 < badges.length) {
        badgeRows.add(const SizedBox(height: 16));
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFF083344),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Perfil de $username',
          style: const TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFF083344),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(picture),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF4D77FF), Color(0xFF355C7D)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.emoji_events,
                          color: Colors.yellow[700], size: 24),
                      const SizedBox(width: 10),
                      Text(
                        'Victorias: $numVics',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                if (password != null) ...[
                  Row(
                    children: [
                      const Expanded(child: SizedBox.shrink()),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return PopUpChangeUsername(
                                  email: email,
                                  password: password!,
                                  picture: picture);
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFFd68a0a),
                          textStyle: const TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                        child: const Text('Cambiar nombre'),
                      ),
                      const Expanded(child: SizedBox.shrink()),
                    ],
                  ),
                ],
                Row(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Insignias:',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF0066CC),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 1,
                  color: Colors.white24,
                ),
                const SizedBox(height: 10),
                ...badgeRows,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadgePlaceholder(String assetUrl) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: const Color(0xFF274d5b),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            assetUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyBadgePlaceholder() {
    return const SizedBox(
      width: 64,
      height: 64,
    );
  }
}
