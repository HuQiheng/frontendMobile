import 'dart:convert';
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
        'cookie': 'connect.sid=$sessionCookie',
      },
    );

    if (response.statusCode == 200) {
      logger.d("Respuesta de la peticion de amigos ${response.body}");
      List<dynamic> friendsData = jsonDecode(response.body);
      return friendsData;
    } else if (response.statusCode == 403) {
      throw Exception('Acceso denegado');
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error al hacer la solicitud: $error');
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

  final Logger logger = Logger();

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'cookie': 'connect.sid=$sessionCookie',
      },
    );

    if (response.statusCode == 200) {
      logger.d("Respuesta de la peticion de amigos ${response.body}");
      List<dynamic> friendsData = jsonDecode(response.body);
      return friendsData;
    } else if (response.statusCode == 403) {
      throw Exception('Acceso denegado');
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error al hacer la solicitud: $error');
  }
}

void makeFriendRequest(String email, String friendEmail) async {
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
    } else if (response.statusCode == 403) {
      throw Exception('Acceso denegado');
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error al hacer la solicitud: $error');
  }
}
