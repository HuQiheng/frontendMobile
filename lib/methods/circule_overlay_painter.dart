import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CircleOverlayPainter extends CustomPainter {
  final Map<String, Path> circlePaths;
  final Map<String, String> circleNumbers;

  CircleOverlayPainter(
      {required this.circlePaths, required this.circleNumbers});

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    circlePaths.forEach((id, path) {
      final fillPaint = ui.Paint()
        ..color = Colors.white
        ..style = ui.PaintingStyle.fill;
      canvas.drawPath(path, fillPaint);

      final strokePaint = ui.Paint()
        ..color = Colors.black
        ..style = ui.PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawPath(path, strokePaint);

      final String number = circleNumbers[id] ?? '';
      final textSpan = TextSpan(
        style: const TextStyle(color: Colors.black, fontSize: 14),
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
