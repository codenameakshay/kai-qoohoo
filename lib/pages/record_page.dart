import 'package:flutter/material.dart';
import 'package:kai/controllers/record_controller.dart';
import 'package:kai/controllers/timer_controller.dart';
import 'package:kai/widgets/amplitude_widget.dart';
import 'package:kai/widgets/record_button.dart';
import 'package:provider/provider.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({
    Key? key,
  }) : super(key: key);

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  @override
  Widget build(BuildContext context) {
    final RecordController _recordController =
        Provider.of<RecordController>(context);
    final TimerController _timerController =
        Provider.of<TimerController>(context);
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
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    '${_formatNumber(_timerController.recordDuration ~/ 60)}:${_formatNumber(_timerController.recordDuration % 60)}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Card(
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
                              _recordController.samplingRate = 16000;
                            },
                            child: Text(
                              '16.0',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.color
                                        ?.withOpacity(
                                            _recordController.samplingRate ==
                                                    16000
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
                              _recordController.samplingRate = 44100;
                            },
                            child: Text(
                              '44.1',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.color
                                        ?.withOpacity(
                                            _recordController.samplingRate ==
                                                    44100
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
                              _recordController.samplingRate = 48000;
                            },
                            child: Text(
                              '48.0',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.color
                                        ?.withOpacity(
                                            _recordController.samplingRate ==
                                                    48000
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
                              _recordController.fileFormat = "mp3";
                            },
                            child: Text(
                              'MP3',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.color
                                        ?.withOpacity(
                                            _recordController.fileFormat ==
                                                    "mp3"
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
                              _recordController.fileFormat = "wav";
                            },
                            child: Text(
                              'WAV',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.color
                                        ?.withOpacity(
                                            _recordController.fileFormat ==
                                                    "wav"
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
                              _recordController.fileFormat = "m4a";
                            },
                            child: Text(
                              'M4A',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.color
                                        ?.withOpacity(
                                            _recordController.fileFormat ==
                                                    "m4a"
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
              ),
              const Spacer(
                flex: 2,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.folder_open_rounded)),
                  const RecordButton(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.folder_open_rounded)),
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
