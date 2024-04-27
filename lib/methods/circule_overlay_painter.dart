import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CircleOverlayPainter extends CustomPainter {
  final Map<String, Path> circlePaths;
  final Map<String, String> circleNumbers;
  final Map<String, Color> colors;
  final Map<String, int> factories;

  CircleOverlayPainter(
      {required this.circlePaths,
      required this.circleNumbers,
      required this.colors,
      required this.factories});

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    circlePaths.forEach((id, path) {
      final Color color = colors[id] ?? Colors.transparent;
      final fillPaint = ui.Paint()
        ..color = color
        ..style = ui.PaintingStyle.fill;
      canvas.drawPath(path, fillPaint);

      final int factory = factories[id] ?? 0;
      final double strokeWidth = factory == 0 ? 1.2 : 2.7;
      final strokePaint = ui.Paint()
        ..color = Colors.black
        ..style = ui.PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
      canvas.drawPath(path, strokePaint);

      final String number = circleNumbers[id] ?? '';
      final textSpan = TextSpan(
        style: const TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
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
