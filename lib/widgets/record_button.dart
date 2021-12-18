import 'package:flutter/material.dart';
import 'package:kai/controllers/path_controller.dart';
import 'package:kai/controllers/record_controller.dart';
import 'package:kai/controllers/timer_controller.dart';
import 'package:kai/painters/ripple_painter.dart';
import 'package:kai/services/logger_service.dart';
import 'package:kai/services/record_service.dart';
import 'package:provider/provider.dart';

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
    final RecordController recordController =
        Provider.of<RecordController>(context);
    final PathController pathController = Provider.of<PathController>(context);
    final TimerController timerController =
        Provider.of<TimerController>(context);
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
              child: StreamBuilder(
                stream: recordController.recordStateStream,
                builder: (context, snapshot) {
                  switch (snapshot.data) {
                    case RecordState.ready:
                      return const Icon(
                        Icons.mic,
                      );
                    case RecordState.recording:
                      return const Icon(
                        Icons.stop,
                      );
                    case RecordState.paused:
                      return const Icon(
                        Icons.stop,
                      );
                    case RecordState.error:
                      return const Icon(
                        Icons.error,
                      );
                    default:
                      return const Icon(
                        Icons.mic,
                      );
                  }
                },
              ),
              onPressed: () async {
                switch (recordController.recordState) {
                  case RecordState.ready:
                    final permission = await recordController.checkPermission();
                    logger.e(permission);
                    if (permission) {
                      final path = await pathController.getDocPath();
                      logger.e(path);
                      timerController.resetTimer();
                      timerController.startTimer();
                      timerController.startAmplitudeTimer(() {
                        recordController.getAmplitude();
                      });
                      recordController.startRecord(path);
                    } else {
                      recordController.recordState = RecordState.error;
                    }
                    break;
                  case RecordState.recording:
                    timerController.cancelAmplitudeTimer();
                    timerController.cancelTimer();
                    recordController.stopRecord();
                    break;
                  case RecordState.paused:
                    timerController.cancelAmplitudeTimer();
                    timerController.cancelTimer();
                    recordController.stopRecord();
                    break;
                  case RecordState.error:
                    break;
                  default:
                    final permission = await recordController.checkPermission();
                    logger.e(permission);
                    if (permission) {
                      final path = await pathController.getDocPath();
                      logger.e(path);
                      timerController.resetTimer();
                      timerController.startTimer();
                      timerController.startAmplitudeTimer(() {
                        recordController.getAmplitude();
                      });
                      recordController.startRecord(path);
                    } else {
                      recordController.recordState = RecordState.error;
                    }
                    break;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
