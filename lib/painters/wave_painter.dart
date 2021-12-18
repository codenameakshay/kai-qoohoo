import 'dart:math';

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final Color color;
  final double heightPercentage;
  final List<double> amplitudeHistory;
  final double phase;
  final double waveFrequency;
  WavePainter({
    required this.color,
    required this.heightPercentage,
    required this.amplitudeHistory,
    required this.phase,
    required this.waveFrequency,
  });
  double viewWidth = 0.0;
  double _tempA = 0.0;
  double _tempB = 0.0;
  final Paint _paint = Paint();
  @override
  void paint(Canvas canvas, Size size) {
    double viewCenterY = size.height * (heightPercentage + 0.1);
    viewWidth = size.width;
    final path = Path();
    path.reset();
    path.moveTo(0.0,
        viewCenterY + amplitudeHistory[0] * _getSinY(phase, waveFrequency, -1));
    for (int i = 1; i < size.width + 1; i++) {
      path.lineTo(
          i.toDouble(),
          viewCenterY +
              amplitudeHistory[(0 +
                          ((amplitudeHistory.length - 1 - 0) /
                                  (size.width - 1)) *
                              (i - 1))
                      .toInt()] *
                  _getSinY(phase, waveFrequency, i));
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    _paint.color = color;
    _paint.style = PaintingStyle.fill;
    canvas.drawPath(path, _paint);
  }

  double _getSinY(
      double startradius, double waveFrequency, int currentposition) {
    if (_tempA == 0) {
      _tempA = pi / viewWidth;
    }
    if (_tempB == 0) {
      _tempB = 2 * pi / 360.0;
    }

    return (sin(
        _tempA * waveFrequency * (currentposition + 1) + startradius * _tempB));
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(WavePainter oldDelegate) => false;
}

class WavePainterOld extends CustomPainter {
  final Color color;
  final double heightPercentage;
  final double amplitude;
  final double phase;
  final double waveFrequency;
  WavePainterOld({
    required this.color,
    required this.heightPercentage,
    required this.amplitude,
    required this.phase,
    required this.waveFrequency,
  });
  double viewWidth = 0.0;
  double _tempA = 0.0;
  double _tempB = 0.0;
  final Paint _paint = Paint();
  @override
  void paint(Canvas canvas, Size size) {
    double viewCenterY = size.height * (heightPercentage + 0.1);
    viewWidth = size.width;
    final path = Path();
    path.reset();
    path.moveTo(
        0.0, viewCenterY + amplitude * _getSinY(phase, waveFrequency, -1));
    for (int i = 1; i < size.width + 1; i++) {
      path.lineTo(i.toDouble(),
          viewCenterY + amplitude * _getSinY(phase, waveFrequency, i));
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    _paint.color = color;
    _paint.style = PaintingStyle.fill;
    canvas.drawPath(path, _paint);
  }

  double _getSinY(
      double startradius, double waveFrequency, int currentposition) {
    if (_tempA == 0) {
      _tempA = pi / viewWidth;
    }
    if (_tempB == 0) {
      _tempB = 2 * pi / 360.0;
    }

    return (sin(
        _tempA * waveFrequency * (currentposition + 1) + startradius * _tempB));
  }

  @override
  bool shouldRepaint(WavePainterOld oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(WavePainterOld oldDelegate) => false;
}
