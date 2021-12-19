import 'package:flutter/material.dart';
import 'package:kai/painters/audio_waveform_painter.dart';

class AudioWaveformWidget extends StatelessWidget {
  final Color waveColor;
  final double strokeWidth;
  final Widget child;
  final int duration;

  const AudioWaveformWidget({
    Key? key,
    required this.duration,
    required this.child,
    this.waveColor = Colors.blue,
    this.strokeWidth = 5.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        willChange: false,
        painter: AudioWaveformPainter(
          waveColor: waveColor,
          duration: duration,
          strokeWidth: strokeWidth,
        ),
        child: child);
  }
}
