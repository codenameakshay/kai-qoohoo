import 'package:flutter/material.dart';
import 'package:kai/services/logger_service.dart';

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
