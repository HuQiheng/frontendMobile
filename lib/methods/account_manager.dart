import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:wealth_wars/methods/shared_preferences.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

Future<List<String>> getMyAwards(String email) async {
  final cookieManager = WebviewCookieManager();
  final cookies = await cookieManager.getCookies('https://wealthwars.games');
  String sessionCookie = cookies
      .firstWhere(
        (cookie) => cookie.name == 'connect.sid',
      )
      .value;
  String url = 'https://wealthwars.games:3010/users/$email/achievements';

  final Logger logger = Logger();

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'connect.sid=$sessionCookie',
      },
    );

    if (response.statusCode == 200) {
      Logger().d("Obtención de la lista de logros: ${response.body}");
      List<dynamic> awardsData = jsonDecode(response.body);
      List<String> titles =
          awardsData.map((award) => award["title"] as String).toList();
      return titles;
    } else {
      Logger().e("Error en la solicitud: ${response.statusCode}");
      return [];
    }
  } catch (error) {
    Logger().e("Error al hacer la solicitud: $error");
    return [];
  }
}

Future<void> logout() async {
  final cookieManager = WebviewCookieManager();
  final cookies = await cookieManager.getCookies('https://wealthwars.games');
  String sessionCookie = cookies
      .firstWhere(
        (cookie) => cookie.name == 'connect.sid',
      )
      .value;
  String url = 'https://wealthwars.games:3010/auth/logout';

  final Logger logger = Logger();

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'connect.sid=$sessionCookie',
      },
    );

    if (response.statusCode == 200) {
      logger.d("Logout successful. Response: ${response.body}");
    } else if (response.statusCode == 302) {
      // 302 Redireccion
      logger.d("Logout successful. Redirecting to home.");
    } else {
      logger.e("Error in logout request: ${response.statusCode}");
    }
  } catch (error) {
    logger.e("Error during logout request: $error");
  }
}

Future<int> getNumVics(String email) async {
  final cookieManager = WebviewCookieManager();
  final cookies = await cookieManager.getCookies('https://wealthwars.games');
  String sessionCookie = cookies
      .firstWhere(
        (cookie) => cookie.name == 'connect.sid',
      )
      .value;
  String url = 'https://wealthwars.games:3010/users/$email/wins';

  final Logger logger = Logger();

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'connect.sid=$sessionCookie',
      },
    );

    if (response.statusCode == 200) {
      logger.d("Obtención del numero de victorias: ${response.body}");
      int victorias = jsonDecode(response.body);
      return victorias;
    } else {
      logger.e("Error en la solicitud: ${response.statusCode}");
      return 0;
    }
  } catch (error) {
    logger.e("Error al hacer la solicitud: $error");
    return 0;
  }
}

Future<void> deleteUser(String email) async {
  final cookieManager = WebviewCookieManager();

  // Construir la URL con el email del usuario a eliminar
  Logger logger = Logger();
  logger.d("Tengo las cookies");
  String url = 'https://wealthwars.games:3010/users/$email';
  logger.d(url);

  final cookies = await cookieManager.getCookies('https://wealthwars.games');
  String sessionCookie = cookies
      .firstWhere(
        (cookie) => cookie.name == 'connect.sid',
      )
      .value;

  try {
    // Realizar la solicitud DELETE al backend
    var response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'cookie': 'connect.sid=$sessionCookie'
      },
    );

    // Verificar si la solicitud fue exitosa (código de estado 200)
    if (response.statusCode == 200) {
      // El usuario ha sido eliminado exitosamente
      logger.d('Respuesta del servidor: ${response.body}');
    } else {
      // La solicitud no fue exitosa, mostrar el mensaje de error
      logger.d('Error al eliminar usuario: ${response.statusCode}');
    }
  } catch (error) {
    // Manejar errores de conexión u otros errores
    logger.d('Error al eliminar usuario: $error');
  }
}

Future<String> getUser(String email) async {
  final cookieManager = WebviewCookieManager();

  final cookies = await cookieManager.getCookies('https://wealthwars.games');
  String sessionCookie = cookies
      .firstWhere(
        (cookie) => cookie.name == 'connect.sid',
      )
      .value;

  String url = 'https://wealthwars.games:3010/users/$email';
  final Logger logger = Logger();
  try {
    // Realizar la solicitud PUT al backend
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'cookie': 'connect.sid=$sessionCookie'
      },
    );

    // Verificar si la solicitud fue exitosa (código de estado 200)
    if (response.statusCode == 200) {
      // El usuario ha sido actualizado exitosamente
      logger.d('Usuario actualizado exitosamente.');
      // Imprimir la respuesta del servidor
      logger.d('Respuesta del servidor: ${response.body}');
      return response.body;
    } else {
      // La solicitud no fue exitosa, mostrar el mensaje de error
      logger.d('Error al actualizar usuario: ${response.statusCode}');
      return "";
    }
  } catch (error) {
    // Manejar errores de conexión u otros errores
    logger.d('Error al actualizar usuario: $error');
    return "";
  }
}

Future<void> updateUser(
    String email, String newUsername, String password, String picture) async {
  final cookieManager = WebviewCookieManager();

  final cookies = await cookieManager.getCookies('https://wealthwars.games');
  String sessionCookie = cookies
      .firstWhere(
        (cookie) => cookie.name == 'connect.sid',
      )
      .value;

  String url =
      'https://wealthwars.games:3010/users/$email'; // La URL del endpoint debe ser /users/:email para que coincida con la ruta en el backend
  final Logger logger = Logger();

  try {
    // Construir el cuerpo de la solicitud JSON
    Map<String, dynamic> requestBody = {
      'username': newUsername,
      'password': password,
      'picture': picture,
    };

    // Realizar la solicitud PUT al backend
    var response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'cookie': 'connect.sid=$sessionCookie'
      },
      body: jsonEncode(requestBody),
    );

    logger.d(response.body);
    // Verificar si la solicitud fue exitosa (código de estado 200)
    if (response.statusCode == 200) {
      // El usuario ha sido actualizado exitosamente
      logger.d('Usuario actualizado exitosamente.');
      // Imprimir la respuesta del servidor
      logger.d('Respuesta del servidor: ${response.body}');

      String userSal = await getUser(email);
      Map<String, dynamic> user = jsonDecode(userSal);
      String nombre = user["username"];

      await actualizarDatoJson("name", nombre);
    } else {
      // La solicitud no fue exitosa, mostrar el mensaje de error
      logger.d('Error al actualizar usuario: ${response.statusCode}');
    }
  } catch (error) {
    // Manejar errores de conexión u otros errores
    logger.d('Error al actualizar usuario: $error');
  }
}
