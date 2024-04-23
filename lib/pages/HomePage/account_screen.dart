import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:wealth_wars/widgets/homeWidgets/pop_up_change_username.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;
  final String picture;
  final String password;

  const ProfileScreen(
      {super.key,
      required this.username,
      required this.email,
      required this.picture,
      required this.password});

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
                TextButton(
                  onPressed: () {
                    // Aquí va el código de amigo
                    Clipboard.setData(const ClipboardData(
                        text:
                            '<Mi código amigo>')); // Copia el texto al portapapeles
                    Fluttertoast.showToast(
                      msg: "Código de amigo copiado en el portapapeles",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: const Color(0xFFEA970A),
                      textColor: Colors.black,
                      fontSize: 16.0,
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF0066CC),
                    textStyle: const TextStyle(
                        fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                  child: const Text('<Mi código amigo>'),
                ),
                Row(
                  children: [
                    const Expanded(child: SizedBox.shrink()),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return PopUpChangeUsername(
                                email: email, password: password, picture: picture);
                          },
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF0066CC),
                        textStyle: const TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                      child: const Text('Cambiar nombre'),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                  ],
                ),
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
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle, // Esta propiedad define la forma del contenedor como un círculo
                        color: Color(0xFF0066CC), // Color de fondo del contenedor
                      ),
                      child: 
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white), // Icono de edición con color blanco
                        onPressed: () {
                          // Abrir pop up para elegir insignia
                        },
                      ),
                    )
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
