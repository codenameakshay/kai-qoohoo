import 'package:flutter/material.dart';
import 'package:kai/painters/wave_painter.dart';

class AmplitudeWidget extends StatefulWidget {
  const AmplitudeWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  State<AmplitudeWidget> createState() => _AmplitudeWidgetState();
}

class _AmplitudeWidgetState extends State<AmplitudeWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController amplitudeController;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    amplitudeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {});
      });
    amplitudeController.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: WavePainter(
            color: Theme.of(context).colorScheme.primary,
            amplitude: 20 * amplitudeController.value,
            phase: 360 * controller.value,
            heightPercentage: 0.53,
            waveFrequency: 5,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - kToolbarHeight,
          ),
        ),
        widget.child,
      ],
    );
  }
}
