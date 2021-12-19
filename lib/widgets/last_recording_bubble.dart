import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kai/controllers/audio_player_controller.dart';
import 'package:kai/services/logger_service.dart';
import 'package:kai/widgets/audio_waveform_widget.dart';
import 'package:provider/provider.dart';

class LastRecordingBubble extends StatelessWidget {
  const LastRecordingBubble({
    Key? key,
    required this.time,
    required this.path,
  }) : super(key: key);
  final int time;
  final String path;

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
          LRPlayPauseButton(path: path),
          AudioWaveformWidget(
            duration: time.clamp(0, 25),
            strokeWidth: 4,
            waveColor: Theme.of(context).colorScheme.secondary,
            child: SizedBox(
              height: 60,
              width: time.clamp(0, 25) * 8.0,
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
  const LRPlayPauseButton({
    Key? key,
    required this.path,
  }) : super(key: key);
  final String path;
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
    final AudioPlayerController audioPlayerController =
        Provider.of<AudioPlayerController>(context);
    return IconButton(
      onPressed: () async {
        logger.d("Button pressed!");
        HapticFeedback.vibrate();
        if (playing) {
          controller.reverse();
          audioPlayerController.pause();
          setState(() {
            playing = false;
          });
        } else {
          controller.forward();
          await audioPlayerController.setSource(widget.path);
          setState(() {
            playing = true;
          });
          await audioPlayerController.play();
          controller.reverse();
          setState(() {
            playing = false;
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
