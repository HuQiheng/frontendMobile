import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wars/methods/sound_settings.dart';
import 'package:wealth_wars/methods/theme_settings.dart';
import 'package:wealth_wars/widgets/homeWidgets/pop_up_close_session.dart';
import 'package:wealth_wars/widgets/homeWidgets/pop_up_delete_account.dart';

class SettingsScreen extends StatefulWidget {
  final String email;

  const SettingsScreen({super.key, required this.email});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    String email = widget.email;
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
              color: const Color(0xFF005A88),
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
                    title: const Text('Sonidos',
                        style: TextStyle(color: Colors.white)),
                    value: Provider.of<SoundSettings>(context).soundsEnabled,
                    onChanged: (bool value) {
                      Provider.of<SoundSettings>(context, listen: false)
                          .soundsEnabled = value;
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.lightBlueAccent,
                  ),
                  SwitchListTile(
                    title: const Text('Modo Oscuro',
                        style: TextStyle(color: Colors.white)),
                    value: Provider.of<ThemeSettings>(context).darkModeEnabled,
                    onChanged: (bool value) {
                      Provider.of<ThemeSettings>(context, listen: false)
                          .darkModeEnabled = value;
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.lightBlueAccent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10), // Espacio entre la línea y la lista
            Container(
              height: 1,
              color: Colors.white24,
            ),
            const SizedBox(height: 10), // Espacio entre la línea y la lista
            Row(
              children: [
                const Expanded(child: SizedBox.shrink()),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      // Cerrar sesión
                      context: context,
                      builder: (BuildContext context) {
                        return const PopUpCloseSession();
                      },
                    );
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
                    showDialog(
                      // Borrar cuenta
                      context: context,
                      builder: (BuildContext context) {
                        return PopUpDelete(email: email);
                        //return const PopUpDelete();
                      },
                    );
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
