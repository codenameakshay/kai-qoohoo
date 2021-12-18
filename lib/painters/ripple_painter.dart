import 'dart:math';

import 'package:flutter/material.dart';

class RipplePainter extends CustomPainter {
  final double animationValue;
  final Color color;
  final double width;
  const RipplePainter({
    required this.color,
    required this.animationValue,
    required this.width,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final double opacity = ((1 - animationValue)).clamp(0, 0.2);
    canvas.drawCircle(
        Offset(width / 2, width / 2),
        animationValue * width * 0.5,
        Paint()..color = color.withOpacity(pow(opacity, 2).toDouble()));
    canvas.drawCircle(
        Offset(width / 2, width / 2),
        animationValue * width * 0.45,
        Paint()..color = color.withOpacity(pow(opacity, 1.5).toDouble()));
    canvas.drawCircle(
        Offset(width / 2, width / 2),
        animationValue * width * 0.4,
        Paint()..color = color.withOpacity(opacity));
  }

  @override
  bool shouldRepaint(RipplePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(RipplePainter oldDelegate) => false;
}
