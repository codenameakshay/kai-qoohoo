import 'package:flutter/material.dart';
import 'package:kai/controllers/settings_controller.dart';
import 'package:kai/router/app_router.dart';
import 'package:kai/services/locator_service.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    Record().hasPermission();
    locator<AppRouter>().replaceAll([const HomeRoute()]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController =
        Provider.of<SettingsController>(context);
    settingsController.init();
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
