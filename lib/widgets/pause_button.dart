import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kai/controllers/record_controller.dart';
import 'package:kai/controllers/timer_controller.dart';
import 'package:kai/services/record_service.dart';
import 'package:provider/provider.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RecordController recordController =
        Provider.of<RecordController>(context);
    final TimerController timerController =
        Provider.of<TimerController>(context);
    return IconButton(
      onPressed: (recordController.recordState == RecordState.ready ||
              recordController.recordState == RecordState.error)
          ? null
          : (recordController.recordState == RecordState.recording)
              ? () {
                  HapticFeedback.vibrate();
                  timerController.cancelAmplitudeTimer();
                  timerController.cancelTimer();
                  recordController.pauseRecord();
                }
              : () {
                  HapticFeedback.vibrate();
                  timerController.startTimer();
                  timerController.startAmplitudeTimer(() {
                    recordController.getAmplitude();
                  });
                  recordController.resumeRecord();
                },
      icon: StreamBuilder(
        stream: recordController.recordStateStream,
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case RecordState.ready:
              return const Icon(
                Icons.pause,
              );
            case RecordState.recording:
              return const Icon(
                Icons.pause,
              );
            case RecordState.paused:
              return const Icon(
                Icons.play_arrow,
              );
            case RecordState.error:
              return const Icon(
                Icons.pause,
              );
            default:
              return const Icon(
                Icons.pause,
              );
          }
        },
      ),
    );
  }
}
