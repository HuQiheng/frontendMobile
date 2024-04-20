import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CircleOverlayPainter extends CustomPainter {
  final Map<String, Path> circlePaths;
  final Map<String, String> circleNumbers;
  final Map<String, Color> colors;

  CircleOverlayPainter(
      {required this.circlePaths,
      required this.circleNumbers,
      required this.colors});

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    circlePaths.forEach((id, path) {
      final Color color = colors[id] ?? Colors.transparent;
      final fillPaint = ui.Paint()
        ..color = color
        ..style = ui.PaintingStyle.fill;
      canvas.drawPath(path, fillPaint);

      final strokePaint = ui.Paint()
        ..color = Colors.black
        ..style = ui.PaintingStyle.stroke
        ..strokeWidth = 1.3;
      canvas.drawPath(path, strokePaint);

      final String number = circleNumbers[id] ?? '';
      final textSpan = TextSpan(
        style: const TextStyle(
            color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
        text: number,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final Rect bbox = path.getBounds();
      final double centerX = bbox.center.dx;
      final double centerY = bbox.center.dy;
      final offset = Offset(centerX - (textPainter.width / 2),
          centerY - (textPainter.height / 2));

      textPainter.paint(canvas, offset);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
