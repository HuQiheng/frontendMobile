import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class FriendProfileScreen extends StatelessWidget {
  final String username;
  final String email;
  final String picture;

  const FriendProfileScreen(
      {super.key,
      required this.username,
      required this.email,
      required this.picture});

  @override
  Widget build(BuildContext context) {
    final Logger logger = Logger();
    logger.d(username + email + picture);
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
                  radius: 70,
                  backgroundImage: NetworkImage(
                    picture,
                  ),
                ),
                const Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Insignias:',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    ),                    
                  ],
                ),
                Container(
                  height: 1,
                  color: Colors.white24,
                ),
                const SizedBox(height: 10), // Espacio entre la línea y la lista
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Se habrán pasado las insignias que el usuario tiene equipadas
                    _buildBadgePlaceholder(),
                    _buildBadgePlaceholder(),
                    _buildBadgePlaceholder(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadgePlaceholder() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
