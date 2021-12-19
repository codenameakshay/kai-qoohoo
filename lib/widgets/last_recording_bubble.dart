import 'package:flutter/material.dart';
import 'package:kai/services/logger_service.dart';
import 'package:kai/widgets/audio_waveform_widget.dart';

class LastRecordingBubble extends StatelessWidget {
  const LastRecordingBubble({
    Key? key,
    required this.time,
  }) : super(key: key);
  final int time;

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LRPlayPauseButton(),
          AudioWaveformWidget(
            duration: time,
            strokeWidth: 4,
            waveColor: Theme.of(context).colorScheme.secondary,
            child: const SizedBox(
              height: 60,
              width: 70,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextButton(
              onPressed: () {},
              child: Text(
                '${_formatNumber(time ~/ 60)}:${_formatNumber(time % 60)}',
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

class LRPlayPauseButton extends StatefulWidget {
  const LRPlayPauseButton({Key? key}) : super(key: key);

  @override
  _LRPlayPauseButtonState createState() => _LRPlayPauseButtonState();
}

class _LRPlayPauseButtonState extends State<LRPlayPauseButton>
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
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
      ),
    );
  }
}
