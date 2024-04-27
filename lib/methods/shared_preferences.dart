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
    logger.d(userJson);
    return jsonDecode(userJson);
  } else {
    logger.d("No user data found.");
  }
  return null;
}

// Para eliminar todos los datos
Future<void> clearAllData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

// Modifica un parámetro
Future<void> actualizarDatoJson(String key, String newValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userJson = prefs.getString('user_data');

  if (userJson != null) {
    // Decodificar el JSON almacenado en SharedPreferences
    Map<String, dynamic> userData = jsonDecode(userJson);

    // Actualizar el valor del dato deseado
    userData[key] = newValue;

    // Codificar el JSON actualizado y guardarlo de nuevo en SharedPreferences
    String updatedUserJson = jsonEncode(userData);
    await prefs.setString('user_data', updatedUserJson);

    logger.d('Valor actualizado correctamente.');
  } else {
    logger.d('No se encontraron datos de usuario.');
  }
}
