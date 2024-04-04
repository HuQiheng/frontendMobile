import 'package:flutter/material.dart';

class RegionOverlayPainter extends CustomPainter {
  final Map<String, Path> paths; // Map from id region to paths
  final Map<String, Color> colors; // Map from id region to color

  RegionOverlayPainter({required this.paths, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    paths.forEach((id, path) {
      final paint = Paint()
        ..color = colors[id] ?? Colors.transparent
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
