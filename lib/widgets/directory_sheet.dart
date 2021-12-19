import 'package:flutter/material.dart';
import 'package:kai/controllers/path_controller.dart';
import 'package:kai/widgets/recording_card.dart';
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
    var files = _pathController.directory?.listSync();
    files?.sort((a, b) => p.basename(b.path).compareTo(p.basename(a.path)));
    files?.removeWhere(
        (element) => p.basename(element.path).substring(0, 3) != 'Kai');
    if (files?.isEmpty == true) files = null;
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
            children: (files?.map((e) {
                  return RecordingCard(
                    key: ValueKey(e.path),
                    file: e,
                  ) as Widget;
                }).toList() ??
                [const Center(child: Text("No recordings found"))])
              ..add(const SizedBox(
                height: 16,
              )),
          ),
        ),
      ),
      disabled: true,
    );
  }
}
