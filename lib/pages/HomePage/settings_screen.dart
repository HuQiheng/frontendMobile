import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _soundsEnabled = false;
  bool _darkModeEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF083344),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Ajustes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF083344),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color(0xFF005A88),
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Ajustes:',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  SwitchListTile(
                    title: const Text('Notificaciones',
                        style: TextStyle(color: Colors.white)),
                    value: _notificationsEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.lightBlueAccent,
                  ),
                  SwitchListTile(
                    title: const Text('Sonidos',
                        style: TextStyle(color: Colors.white)),
                    value: _soundsEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _soundsEnabled = value;
                      });
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.lightBlueAccent,
                  ),
                  SwitchListTile(
                    title: const Text('Modo oscuro',
                        style: TextStyle(color: Colors.white)),
                    value: _darkModeEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _darkModeEnabled = value;
                      });
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.lightBlueAccent,
                  ),
                  
                ],
              ),
            ),
            const SizedBox(height: 5), // Espacio entre la línea y la lista
            Container(
              height: 1,
              color: Colors.white24,
            ),
            const SizedBox(height: 5), // Espacio entre la línea y la lista
            Row(
                children: [
                  const Expanded(child: SizedBox.shrink()),
                  ElevatedButton(
                    onPressed: () {
                      
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const IntrinsicWidth(
                      child: Column(
                        children: [
                          Text('Cerrar sesión'),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                  ElevatedButton(
                    onPressed: () {
                      
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const IntrinsicWidth(
                      child: Column(
                        children: [
                          Text('Borrar cuenta'),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                ],
              ),
              const SizedBox(height: 10), // Espacio entre la línea y la lista
          ],
        ),
      ),
    );
  }
}
