import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:logger/logger.dart';

void showCustomToast(dynamic data, BuildContext context) {
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
          Image.network(data['image_url'], width: 50),
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
