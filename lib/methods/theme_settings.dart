import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSettings extends ChangeNotifier {
  bool _darkModeEnabled = false;

  ThemeSettings() {
    loadPreferences();
  }

  bool get darkModeEnabled => _darkModeEnabled;

  set darkModeEnabled(bool value) {
    _darkModeEnabled = value;
    notifyListeners();
    savePreferences();
  }

  void loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _darkModeEnabled = prefs.getBool('darkModeEnabled') ?? false;
    notifyListeners();
  }

  void savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkModeEnabled', _darkModeEnabled);
  }
}
