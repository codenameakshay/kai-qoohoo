import 'package:flutter/material.dart';
import 'package:kai/widgets/amplitude_widget.dart';
import 'package:kai/widgets/directory_button.dart';
import 'package:kai/widgets/format_settings.dart';
import 'package:kai/widgets/last_recording_bubble.dart';
import 'package:kai/widgets/pause_button.dart';
import 'package:kai/widgets/record_button.dart';
import 'package:kai/widgets/record_duration.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  bool lastRecording = false;
  String path = "";
  @override
  Widget build(BuildContext context) {
    return AmplitudeWidget(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Spacer(
                flex: 2,
              ),
              const RecordDuration(),
              const Spacer(
                flex: 1,
              ),
              const FormatSettings(),
              const Spacer(
                flex: 1,
              ),
              lastRecording && path != ""
                  ? const LastRecordingBubble()
                  : const SizedBox(
                      height: 96,
                    ),
              const Spacer(
                flex: 1,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const PauseButton(),
                  RecordButton(
                    showLastRecording: (bool newValue, String newPath) {
                      setState(() {
                        path = newPath;
                        lastRecording = newValue;
                      });
                    },
                  ),
                  const DirectoryButton(),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
