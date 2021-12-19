import 'dart:math';

import 'package:flutter/material.dart';

class AudioWaveformPainter extends CustomPainter {
  final double strokeWidth;
  final Paint wavePaint;
  final int duration;

  AudioWaveformPainter({
    required this.duration,
    Color waveColor = Colors.blue,
    this.strokeWidth = 5.0,
  }) : wavePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..color = waveColor;

  @override
  void paint(Canvas canvas, Size size) {
    // logger.d("Paint called $duration");
    if (duration == 0) return;
    // logger.d("Paint ahead");

    // logger.d("Paint before for loop");
    for (double i = 0; i <= duration; i += 1) {
      final List<double> plotList = [
        13,
        5,
        18,
        10,
        7,
        -14,
        15,
        -18,
        20,
        -13,
        9,
        -6,
        3,
        -17,
        0,
        11,
        -10,
        2,
        8,
        -2,
        -15,
        -8,
        6,
        -11,
        -12,
        14,
        -5,
        -20,
        -16,
        -9,
        17,
        -19,
        -4,
        -3,
        -7,
        1,
        -1,
        16,
        19,
        4,
        12
      ];
      final x = i * 8;
      final double plot = plotList[i.clamp(0, plotList.length - 1).toInt()] * 1;
      // logger.d('$i $x $plot');
      canvas.drawLine(
        Offset(x + strokeWidth / 2, max(0, plot) + 30),
        Offset(x + strokeWidth / 2, min(0, plot) + 30),
        wavePaint,
      );
    }
    // logger.d("Paint after for loop");
  }

  @override
  bool shouldRepaint(AudioWaveformPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(AudioWaveformPainter oldDelegate) => false;
}
