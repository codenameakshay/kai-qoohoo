import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kai/controllers/theme_controller.dart';
import 'package:kai/pages/record_page.dart';
import 'package:kai/services/locator_service.dart';
import 'package:kai/services/logger_service.dart';
import 'package:kai/services/snackbar_service.dart';
import 'package:kai/widgets/bug_report_button.dart';
import 'package:kai/widgets/realistic_graph_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    logger.d('App init done.');
  }

  @override
  Widget build(BuildContext context) {
    // logger.d("${90 / MediaQuery.of(context).size.width}");
    final darkAppBarContents =
        Theme.of(context).scaffoldBackgroundColor.computeLuminance() > 0.5;

    return ScaffoldMessenger(
      key: locator<SnackbarService>().scaffoldHomeKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness:
                  darkAppBarContents ? Brightness.dark : Brightness.light),
          title: Text(
            'Kai',
            style: TextStyle(
              color: darkAppBarContents
                  ? Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor
                  : Theme.of(context).appBarTheme.titleTextStyle?.color,
            ),
          ),
          actions: [
            RealisticGraphButton(darkAppBarContents: darkAppBarContents),
            IconButton(
              onPressed: () {
                context.read<ThemeController>().setSchemeIndex(
                      (context.read<ThemeController>().schemeIndex + 1) % 40,
                    );
              },
              icon: const Icon(Icons.brightness_4_rounded),
              color: darkAppBarContents
                  ? Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor
                  : Theme.of(context).appBarTheme.titleTextStyle?.color,
            ),
            BugReportButton(darkAppBarContents: darkAppBarContents),
          ],
        ),
        body: const RecordPage(),
      ),
    );
  }
}
