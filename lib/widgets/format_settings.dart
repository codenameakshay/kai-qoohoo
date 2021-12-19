import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kai/controllers/record_controller.dart';
import 'package:provider/provider.dart';

class FormatSettings extends StatelessWidget {
  const FormatSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RecordController _recordController =
        Provider.of<RecordController>(context);
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextButton(
                  onPressed: () {
                    HapticFeedback.vibrate();
                    _recordController.samplingRate = 16000;
                  },
                  child: Text(
                    '16.0',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.color
                              ?.withOpacity(
                                  _recordController.samplingRate == 16000
                                      ? 1
                                      : 0.5),
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextButton(
                  onPressed: () {
                    HapticFeedback.vibrate();
                    _recordController.samplingRate = 44100;
                  },
                  child: Text(
                    '44.1',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.color
                              ?.withOpacity(
                                  _recordController.samplingRate == 44100
                                      ? 1
                                      : 0.5),
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextButton(
                  onPressed: () {
                    HapticFeedback.vibrate();
                    _recordController.samplingRate = 48000;
                  },
                  child: Text(
                    '48.0',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.color
                              ?.withOpacity(
                                  _recordController.samplingRate == 48000
                                      ? 1
                                      : 0.5),
                        ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextButton(
                  onPressed: () {
                    HapticFeedback.vibrate();
                    _recordController.fileFormat = "mp3";
                  },
                  child: Text(
                    'MP3',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.color
                              ?.withOpacity(
                                  _recordController.fileFormat == "mp3"
                                      ? 1
                                      : 0.5),
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextButton(
                  onPressed: () {
                    HapticFeedback.vibrate();
                    _recordController.fileFormat = "wav";
                  },
                  child: Text(
                    'WAV',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.color
                              ?.withOpacity(
                                  _recordController.fileFormat == "wav"
                                      ? 1
                                      : 0.5),
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextButton(
                  onPressed: () {
                    HapticFeedback.vibrate();
                    _recordController.fileFormat = "m4a";
                  },
                  child: Text(
                    'M4A',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.color
                              ?.withOpacity(
                                  _recordController.fileFormat == "m4a"
                                      ? 1
                                      : 0.5),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
