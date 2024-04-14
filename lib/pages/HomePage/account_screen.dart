import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;
  final String picture;

  const ProfileScreen({super.key, required this.username, required this.email, required this.picture});

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
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  picture,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Aquí va el codigo de amigo
                  Clipboard.setData(const ClipboardData(text: '<Mi código amigo>')); // Copia el texto al portapapeles
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Texto copiado al portapapeles')),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                      fontSize: 16, fontStyle: FontStyle.italic),
                ),
                child: const Text('<Mi código amigo>'),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Insignias:',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBadgePlaceholder(),
                  _buildBadgePlaceholder(),
                  _buildBadgePlaceholder(),
                ],
              ),
            ],
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
