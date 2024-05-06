import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

Future<List<dynamic>> getUserFriends(String email) async {
  final cookieManager = WebviewCookieManager();
  final cookies = await cookieManager.getCookies('https://wealthwars.games');
  String sessionCookie = cookies
      .firstWhere(
        (cookie) => cookie.name == 'connect.sid',
      )
      .value;
  String url = 'https://wealthwars.games:3010/users/$email/friends';

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
      Logger().d("Obtención de la lista de amigos: ${response.body}");
      return jsonDecode(response.body);
    } else {
      Logger().e("Error en la solicitud: ${response.statusCode}");
      return [];
    }
  } catch (error) {
    Logger().e("Error al hacer la solicitud: $error");
    return [];
  }
}

Future<List<dynamic>> getUserRequests(String email) async {
  final cookieManager = WebviewCookieManager();
  final cookies = await cookieManager.getCookies('https://wealthwars.games');
  String sessionCookie = cookies
      .firstWhere(
        (cookie) => cookie.name == 'connect.sid',
      )
      .value;
  String url = 'https://wealthwars.games:3010/users/$email/friendsRequests';

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'connect.sid=$sessionCookie',
      },
    );

    if (response.statusCode == 200) {
      Logger().d(
          "Obtención de la lista de peticiones de amistad: ${response.body}");
      return jsonDecode(response.body);
    } else {
      Logger().e("Error en la solicitud: ${response.statusCode}");
      return [];
    }
  } catch (error) {
    Logger().e("Error al hacer la solicitud: $error");
    return [];
  }
}

Future<List<dynamic>> getUserSendedRequests(String email) async {
  final cookieManager = WebviewCookieManager();
  final cookies = await cookieManager.getCookies('https://wealthwars.games');
  String sessionCookie = cookies
      .firstWhere(
        (cookie) => cookie.name == 'connect.sid',
      )
      .value;
  String url = 'https://wealthwars.games:3010/users/$email/myFriendsRequests';

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
      Logger().d(
          "Obtención de la lista de mis peticiones de amistad: ${response.body}");
      return jsonDecode(response.body);
    } else {
      Logger().e("Error en la solicitud: ${response.statusCode}");
      return [];
    }
  } catch (error) {
    Logger().e("Error al hacer la solicitud: $error");
    return [];
  }
}

Future<bool> makeFriendRequest(String email, String friendEmail) async {
  final cookieManager = WebviewCookieManager();
  final cookies = await cookieManager.getCookies('https://wealthwars.games');
  String sessionCookie = cookies
      .firstWhere(
        (cookie) => cookie.name == 'connect.sid',
      )
      .value;
  String url = 'https://wealthwars.games:3010/users/$email/friendRequests';

  final Logger logger = Logger();

  try {
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'connect.sid=$sessionCookie',
      },
      body: jsonEncode({'to': friendEmail}),
    );

    if (response.statusCode == 200) {
      logger.d("Respuesta de la peticion de añadir amigo ${response.body}");
      return true;
    } else {
      logger.e('Error en la solicitud: ${response.statusCode}');
      return false;
    }
  } catch (error) {
    logger.e('Error al hacer la solicitud: $error');
    return false;
  }
}

void deleteFriendRequest(String email, String friendEmail) async {
  final cookieManager = WebviewCookieManager();
  final cookies = await cookieManager.getCookies('https://wealthwars.games');
  String sessionCookie = cookies
      .firstWhere(
        (cookie) => cookie.name == 'connect.sid',
      )
      .value;
  String url = 'https://wealthwars.games:3010/users/$email/friendRequests';

  final Logger logger = Logger();

  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'connect.sid=$sessionCookie',
      },
      body: jsonEncode({'to': friendEmail}),
    );

    if (response.statusCode == 200) {
      logger.d(
          "Respuesta de la peticion de eliminar peticion de amistad ${response.body}");
    } else {
      logger.e('Error en la solicitud: ${response.statusCode}');
    }
  } catch (error) {
    logger.e('Error al hacer la solicitud: $error');
  }
}

void acceptFriendRequest(String userEmail, String requesterEmail) async {
  final cookieManager = WebviewCookieManager();
  final cookies = await cookieManager.getCookies('https://wealthwars.games');
  String sessionCookie = cookies
      .firstWhere(
        (cookie) => cookie.name == 'connect.sid',
      )
      .value;

  final String url = 'https://wealthwars.games:3010/users/$userEmail/friends';
  final Logger logger = Logger();

  try {
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'connect.sid=$sessionCookie',
      },
      body: jsonEncode({'email': requesterEmail}),
    );

    if (response.statusCode == 200) {
      logger.d("La petición de amistad ha sido aceptada: ${response.body}");
    } else {
      logger.e("No se pudo aceptar la petición de amistad: ${response.body}");
    }
  } catch (e) {
    logger.e("Error al hacer la solicitud: $e");
  }
}

void deleteFriend(String userEmail, String requesterEmail) async {
  final cookieManager = WebviewCookieManager();
  final cookies = await cookieManager.getCookies('https://wealthwars.games');
  String sessionCookie = cookies
      .firstWhere(
        (cookie) => cookie.name == 'connect.sid',
      )
      .value;

  final String url = 'https://wealthwars.games:3010/users/$userEmail/friends';
  final Logger logger = Logger();

  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'connect.sid=$sessionCookie',
      },
      body: jsonEncode({'email': requesterEmail}),
    );

    if (response.statusCode == 200) {
      logger.d("La relacion de amistad ha sido borrada: ${response.body}");
    } else {
      logger.e("No se pudo aceptar la petición de amistad: ${response.body}");
    }
  } catch (e) {
    logger.e("Error al hacer la solicitud: $e");
  }
}

Future<bool> checkFriendship(String email1, String email2) async {
  final cookieManager = WebviewCookieManager();
  final cookies = await cookieManager.getCookies('https://wealthwars.games');
  String sessionCookie = cookies
      .firstWhere(
        (cookie) => cookie.name == 'connect.sid',
      )
      .value;

  final String url =
      'https://wealthwars.games:3010/users/$email1/$email2/friendship';
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
      final result = jsonDecode(response.body);
      logger.d("Comprobación de amistad: ${response.body}");
      return result['areFriends'] ?? false;
    } else {
      logger.e(
          "Error al comprobar la amistad: ${response.statusCode}, ${response.body}");
      return false;
    }
  } catch (e) {
    logger.e("Error al hacer la solicitud: $e");
    return false;
  }
}
