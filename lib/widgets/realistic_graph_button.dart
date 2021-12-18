import 'package:flutter/material.dart';
import 'package:kai/controllers/settings_controller.dart';
import 'package:kai/services/locator_service.dart';
import 'package:kai/services/snackbar_service.dart';
import 'package:provider/provider.dart';

class RealisticGraphButton extends StatefulWidget {
  const RealisticGraphButton({
    Key? key,
    required this.darkAppBarContents,
  }) : super(key: key);

  final bool darkAppBarContents;

  @override
  State<RealisticGraphButton> createState() => _RealisticGraphButtonState();
}

class _RealisticGraphButtonState extends State<RealisticGraphButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SettingsController _settingsController =
        Provider.of<SettingsController>(context);
    return IconButton(
      onPressed: () {
        _settingsController
            .setRealisticData(!_settingsController.realisticData);
        locator<SnackbarService>().showHomeSnackBar(
          _settingsController.realisticData
              ? "Accurate graph for amplitude will be shown."
              : "Smooth graph for amplitude will be shown.",
        );
      },
      icon: Icon(_settingsController.realisticData
          ? Icons.auto_graph_rounded
          : Icons.graphic_eq_rounded),
      color: widget.darkAppBarContents
          ? Theme.of(context).bottomNavigationBarTheme.unselectedItemColor
          : Theme.of(context).appBarTheme.titleTextStyle?.color,
    );
  }
}
