import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kai/services/settings_service.dart';

class SettingsController with ChangeNotifier {
  final SettingsService _settingsService = SettingsService();
  late bool realisticData;
  Future<void> init() async {
    realisticData = false;
    realisticData = await _settingsService.init();
    notifyListeners();
  }

  void getRealisticData() {
    realisticData = _settingsService.getRealisticData();
    notifyListeners();
  }

  void setRealisticData(bool value) {
    realisticData = value;
    _settingsService.setRealisticData(value);
    notifyListeners();
  }
}
