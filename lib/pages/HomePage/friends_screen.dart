import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF083344),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Mis amigos:',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF083344),
      ),
      body: Container(
        color: const Color(0xFF083344), // Color de fondo deseado
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Añadir amigo (Introducir código):',
                          hintStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: const Color(0xFF005A88),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.white),
                      //Se busca en la base de datos
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ],
                ),
                const SizedBox(
                    height: 16), // Espacio entre el TextField y la lista
                Container(
                  height: 1,
                  color: Colors.white24,
                ),
                const SizedBox(height: 16), // Espacio entre la línea y la lista
                Expanded(
                  child: ListView.separated(
                    itemCount:
                        10, // Cambia esto por la longitud de tu lista de amigos
                    separatorBuilder: (context, index) =>
                        const Divider(color: Colors.white24),
                    itemBuilder: (BuildContext context, int index) {
                      // Aquí puedes construir cada elemento de la lista
                      return Material(
                        color: const Color(
                            0xFF0066CC), // Color de fondo del ListTile
                        child: ListTile(
                          title: Text(
                            'Amigo $index',
                            style: const TextStyle(
                                color: Colors
                                    .white), // Color del texto del ListTile
                          ),
                          onTap: () {
                            // Acción al hacer tap en el amigo
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
