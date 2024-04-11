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
          ],
        ),
      ),
    );
  }
}
