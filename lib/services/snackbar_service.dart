import 'package:flutter/material.dart';

class SnackbarService {
  late GlobalKey<ScaffoldMessengerState> _scaffoldMessengerHomeKey;

  SnackbarService() {
    _scaffoldMessengerHomeKey = GlobalKey<ScaffoldMessengerState>();
  }
  GlobalKey<ScaffoldMessengerState> get scaffoldHomeKey =>
      _scaffoldMessengerHomeKey;

  void showHomeSnackBar(String message) {
    _scaffoldMessengerHomeKey.currentState?.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }
}
