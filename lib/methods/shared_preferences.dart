import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Logger logger = Logger();

// Para guardar datos
Future<void> saveUserData(Map<String, dynamic> userData) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String userJson = jsonEncode(userData);
  await prefs.setString('user_data', userJson);
  logger.d("User data saved successfully.");
}

// Para recuperar datos
Future<Map<String, dynamic>?> getUserData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userJson = prefs.getString('user_data');
  if (userJson != null) {
    logger.d("User data retrieved successfully.");
    return jsonDecode(userJson);
  }
  logger.d("No user data found.");
  return null;
}
