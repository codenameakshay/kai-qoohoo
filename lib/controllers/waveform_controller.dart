import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:kai/services/logger_service.dart';
import 'package:kai/services/waveform_service.dart';

class WaveformController with ChangeNotifier {
  final WaveformService _waveformService = WaveformService();

  WaveformController() {
    _waveformService.waveStateStream.listen((event) {
      logger.d('wave state changed: $event');
      notifyListeners();
    });
    _waveformService.progressStream.listen((event) {
      logger.d('wave progress changed: $event');
      notifyListeners();
    });
  }

  set waveState(WaveformState? value) {
    _waveformService.waveState = value ?? WaveformState.ready;
    notifyListeners();
  }

  Stream<WaveformState> get waveStateStream => _waveformService.waveStateStream;
  WaveformState? get waveState => _waveformService.waveStateStream.valueOrNull;

  Stream<WaveformProgress> get progressStream =>
      _waveformService.progressStream;
  WaveformProgress? get progress => _waveformService.progressStream.valueOrNull;

  // Load file from path, and convert into temp wave file
  Future<void> loadWave(String path) async {
    await _waveformService.loadWave(path);
  }

  // Dispose service
  @override
  void dispose() {
    _waveformService.dispose();
    super.dispose();
  }
}
