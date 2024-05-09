import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// Diccionario que asocia el nombre del logro con el nombre del archivo de imagen
Map<String, String> achievementImages = {
  'Bienvenido a WealthWars': 'assets/insignias/jugar_1_partida.png',
  'Comandante principiante': 'assets/insignias/ganar_1_partida.png',
  'Comandante experimentado': 'assets/insignias/ganar_10_partidas.png',
  'Comandante veterano': 'assets/insignias/ganar_100_partidas.png',
  'Tu primer compañero': 'assets/insignias/añadir_1_amigo.png',
  'Conquistador': 'assets/insignias/conquista_1_territorio.png',
  'Industrializador': 'assets/insignias/comprar_1_fabrica.png',
  'Revolución industrial': 'assets/insignias/comprar_15_fabricas.png',
  'La Armada Invencible': 'assets/insignias/conseguir_99_tropas.png',
  'Mileurista': 'assets/insignias/conseguir_1000_monedas.png'
};

void showCustomToast(dynamic data, BuildContext context) {
  String? achievementImage = achievementImages[data['title']];

  showToastWidget(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: const Color(0xFFEA970A),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(achievementImage!, width: 50),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              "Enhorabuena, has completado el logro: ${data['title']}",
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    ),
    context: context,
    animation: StyledToastAnimation.scale,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.bottom,
    animDuration: const Duration(seconds: 1),
    duration: const Duration(seconds: 4),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
  );
}
