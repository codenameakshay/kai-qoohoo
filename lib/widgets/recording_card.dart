import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kai/controllers/audio_player_controller.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

class RecordingCard extends StatelessWidget {
  const RecordingCard({
    Key? key,
    required this.file,
  }) : super(key: key);

  final FileSystemEntity file;
  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  @override
  Widget build(BuildContext context) {
    final String fileName = p.basename(file.path);
    if (fileName.substring(0, 3) != "Kai") {
      return Container();
    }
    final List<String> splitData = fileName.split("_");
    // logger.d(splitData);
    final DateFormat dateFormat = DateFormat("dd MMM yyyy");
    final DateTime dateTime = DateTime(
      int.parse(splitData[1].toString().split("-")[0]),
      int.parse(splitData[1].toString().split("-")[1]),
      int.parse(splitData[1].toString().split("-")[2]),
      int.parse(splitData[1].toString().split("-")[3]),
      int.parse(splitData[1].toString().split("-")[4]),
      int.parse(splitData[1].toString().split("-")[5]),
    );
    // final int bitRate = int.parse(splitData[2].toString());
    final int samplingRate = int.parse(splitData[3].toString());
    final String fileFormat = splitData[4].split(".")[1];
    return ChangeNotifierProvider<AudioPlayerController>(
      create: (_) => AudioPlayerController(file.path),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.primaryVariant,
        child: Consumer<AudioPlayerController>(builder: (context, apc, child) {
          return Column(
            children: [
              ListTile(
                onTap: () async {
                  HapticFeedback.vibrate();
                  if (apc.audioPlayer.playing &&
                      apc.audioPlayer.processingState !=
                          ProcessingState.completed) {
                    apc.stop();
                  } else {
                    await apc.setSource(file.path);
                    apc.play();
                  }
                },
                leading: const Icon(Icons.music_note),
                title: Text(dateFormat.format(dateTime)),
                subtitle: Text(
                    "${_formatNumber((apc.duration?.inSeconds ?? 0) ~/ 60)}:${_formatNumber((apc.duration?.inSeconds ?? 0) % 60)}   ${samplingRate / 1000}   ${fileFormat.toUpperCase()}"),
                trailing: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      apc.audioPlayer.playing &&
                              apc.audioPlayer.processingState !=
                                  ProcessingState.completed
                          ? Icons.stop
                          : Icons.play_arrow,
                      color: Theme.of(context).colorScheme.onSecondary,
                    )),
              ),
              Stack(
                children: [
                  Container(
                    height: 2,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width *
                        0.9 *
                        (apc.audioPlayer.position.inMilliseconds /
                                (apc.audioPlayer.duration?.inMilliseconds ?? 1))
                            .toDouble(),
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
