import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundSettings extends ChangeNotifier {
  bool _soundsEnabled = true;

  SoundSettings() {
    loadPreferences();
  }

  bool get soundsEnabled => _soundsEnabled;

  set soundsEnabled(bool value) {
    _soundsEnabled = value;
    notifyListeners();
    savePreferences();
  }

  void loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _soundsEnabled = prefs.getBool('soundsEnabled') ?? false;
    notifyListeners();
  }

  void savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('soundsEnabled', _soundsEnabled);
  }
}
