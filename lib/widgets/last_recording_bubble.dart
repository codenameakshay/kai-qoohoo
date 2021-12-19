import 'package:flutter/material.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:kai/controllers/waveform_controller.dart';
import 'package:kai/services/logger_service.dart';
import 'package:kai/widgets/audio_waveform_widget.dart';
import 'package:provider/provider.dart';

class LastRecordingBubble extends StatefulWidget {
  const LastRecordingBubble({
    Key? key,
  }) : super(key: key);

  @override
  State<LastRecordingBubble> createState() => _LastRecordingBubbleState();
}

class _LastRecordingBubbleState extends State<LastRecordingBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool playing = false;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WaveformController waveformController =
        Provider.of<WaveformController>(context);
    final double progress = waveformController.progress?.progress ?? 0.0;
    final Waveform? waveform = waveformController.progress?.waveform;
    return Card(
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                logger.d("Button pressed!");
                if (playing) {
                  controller.reverse();
                  setState(() {
                    playing = false;
                  });
                } else {
                  controller.forward();
                  setState(() {
                    playing = true;
                  });
                }
              },
              icon: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: animation,
              )),
          (waveform == null)
              ? Center(
                  child: Text(
                    '${(100 * progress).toInt()}%',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
              : AudioWaveformWidget(
                  waveform: waveform,
                  start: Duration.zero,
                  duration: Duration(seconds: 2),
                  // duration: waveform.duration,
                  pixelsPerStep: 10,
                  child: Text("yijafni"),
                ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextButton(
              onPressed: () {},
              child: Text(
                '16.0',
                style: Theme.of(context).textTheme.overline?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .overline
                          ?.color
                          ?.withOpacity(1),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
