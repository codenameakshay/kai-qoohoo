import 'package:flutter/material.dart';
import 'package:kai/services/locator_service.dart';
import 'package:kai/services/snackbar_service.dart';

class DirectoryButton extends StatelessWidget {
  const DirectoryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SnackbarService _snackbarService = locator<SnackbarService>();
    return IconButton(
        onPressed: () {
          _snackbarService.showHomeSnackBar("Coming soon!");
        },
        icon: const Icon(Icons.folder_open_rounded));
  }
}
