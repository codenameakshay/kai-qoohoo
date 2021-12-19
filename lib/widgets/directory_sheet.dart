import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kai/controllers/path_controller.dart';
import 'package:kai/router/app_router.dart';
import 'package:kai/services/locator_service.dart';
import 'package:kai/services/logger_service.dart';
import 'package:kai/widgets/scrollable_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;

class RecordingSheet extends StatefulWidget {
  const RecordingSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<RecordingSheet> createState() => _RecordingSheetState();
}

class _RecordingSheetState extends State<RecordingSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PathController _pathController = Provider.of<PathController>(context);
    return ScrollableBottomSheet(
      title: "Previous Recordings",
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
      child: (scroller) => SingleChildScrollView(
        controller: scroller,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _pathController.directory?.listSync().map((e) {
                  return RecordingCard(
                    key: ValueKey(e.path),
                    file: e,
                  );
                }).toList() ??
                [const Center(child: Text("No recordings found"))],
          ),
        ),
      ),
      action: {
        'icon': Icons.check,
        'onPressed': () {
          locator<AppRouter>().pop(context);
        },
      },
    );
  }
}

class RecordingCard extends StatelessWidget {
  const RecordingCard({
    Key? key,
    required this.file,
  }) : super(key: key);

  final FileSystemEntity file;

  @override
  Widget build(BuildContext context) {
    final String fileName = p.basename(file.path);
    final List<String> splitData = fileName.split("_");
    logger.d(splitData);
    final DateFormat dateFormat = DateFormat("dd MMM yyyy");
    final DateTime dateTime = DateTime(
      int.parse(splitData[1].toString().split("-")[0]),
      int.parse(splitData[1].toString().split("-")[1]),
      int.parse(splitData[1].toString().split("-")[2]),
      int.parse(splitData[1].toString().split("-")[3]),
      int.parse(splitData[1].toString().split("-")[4]),
      int.parse(splitData[1].toString().split("-")[5]),
    );
    final int bitRate = int.parse(splitData[2].toString());
    final int samplingRate = int.parse(splitData[3].toString());
    final String fileFormat = splitData[4].split(".")[1];
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primaryVariant,
      child: ListTile(
        onTap: () {},
        leading: const Icon(Icons.music_note),
        title: Text(dateFormat.format(dateTime)),
        subtitle: Text("${samplingRate / 1000}   ${fileFormat.toUpperCase()}"),
        trailing: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.play_arrow,
              color: Theme.of(context).colorScheme.onSecondary,
            )),
      ),
    );
  }
}
