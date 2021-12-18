import 'package:flutter/material.dart';
import 'package:kai/widgets/amplitude_widget.dart';
import 'package:kai/widgets/record_button.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({
    Key? key,
  }) : super(key: key);

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
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    '01:12:49',
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
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            '16.0',
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.color
                                          ?.withOpacity(0.5),
                                    ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            '44.1',
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.color
                                          ?.withOpacity(1),
                                    ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            '48.0',
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.color
                                          ?.withOpacity(0.5),
                                    ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            'MP3',
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.color
                                          ?.withOpacity(0.5),
                                    ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            'WAV',
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.color
                                          ?.withOpacity(1),
                                    ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            'M4A',
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.color
                                          ?.withOpacity(0.5),
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
