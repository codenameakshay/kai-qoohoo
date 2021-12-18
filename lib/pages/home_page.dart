import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kai/services/logger_service.dart';

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
    final darkAppBarContents =
        Theme.of(context).scaffoldBackgroundColor.computeLuminance() > 0.5;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness:
                darkAppBarContents ? Brightness.dark : Brightness.light),
        title: Text(
          'Kai',
          style: TextStyle(
            color: darkAppBarContents
                ? Theme.of(context).bottomNavigationBarTheme.unselectedItemColor
                : Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: darkAppBarContents
                ? Theme.of(context).bottomNavigationBarTheme.unselectedItemColor
                : Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
            color: darkAppBarContents
                ? Theme.of(context).bottomNavigationBarTheme.unselectedItemColor
                : Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Text(
                  'Current theme index:',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
