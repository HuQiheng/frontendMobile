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
          'Amigos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF083344),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Añadir amigo (Introducir código)',
                        hintStyle: TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Color(0xFF005A88),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.check, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFF005A88),
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Mis amigos',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.white24),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Amigo ${index + 1}',
                      style: TextStyle(color: Colors.white),
                    ),
                    tileColor: Color(0xFF0066CC),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
