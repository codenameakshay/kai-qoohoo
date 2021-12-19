import 'package:flutter/material.dart';
import 'package:kai/controllers/path_controller.dart';
import 'package:kai/router/app_router.dart';
import 'package:kai/services/locator_service.dart';
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
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _pathController.directory
                    ?.listSync()
                    .map((e) => ListTile(
                          title: Text(p.basename(e.path)),
                        ))
                    .toList() ??
                [Center(child: Text("No recordings found"))],
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
