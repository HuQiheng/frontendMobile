import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
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
