import 'package:flutter/material.dart';
import 'package:kai/painters/ripple_painter.dart';

class RecordButton extends StatefulWidget {
  const RecordButton({
    Key? key,
  }) : super(key: key);

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  final Tween<double> _sizeTween = Tween(begin: .4, end: 1);
  bool glow = true;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    animation = _sizeTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    )..addListener(() {
        setState(() {
          if (controller.value >= 0.7) {
            glow = false;
          } else if (controller.value <= 0.1) {
            glow = true;
          }
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            painter: RipplePainter(
                color: Theme.of(context).colorScheme.secondary,
                animationValue: animation.value,
                width: width * 0.486),
            child: SizedBox(
              height: width * 0.486,
              width: width * 0.486,
            ),
          ),
          SizedBox(
            height:
                ((width * 0.218 * 0.2 * animation.value) + width * 0.218 * 0.8),
            width:
                ((width * 0.218 * 0.2 * animation.value) + width * 0.218 * 0.8),
            child: FloatingActionButton(
              heroTag: "Record",
              shape: const CircleBorder(),
              child: const Icon(
                Icons.mic,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
