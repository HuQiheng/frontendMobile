import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Añadir amigo (Introducir código)',
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
                  onPressed: () {},
                ),
              ],),
              const SizedBox(height: 16), // Espacio entre el TextField y la lista
              Container(
                height: 1,
                color: Colors.white24,
              ),
              const SizedBox(height: 16), // Espacio entre la línea y la lista
              Expanded(
                child: ListView.separated(
                  itemCount: 10,
                  separatorBuilder: (context, index) =>
                      const Divider(color: Colors.white24),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        'Amigo ${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      tileColor: const Color(0xFF0066CC),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}