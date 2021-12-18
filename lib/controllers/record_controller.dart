import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kai/services/logger_service.dart';
import 'package:kai/services/record_service.dart';

class RecordController with ChangeNotifier {
  final RecordService _recordService = RecordService();

  RecordController() {
    _recordService.recordStateStream.listen((event) {
      logger.d('record state changed: $event');
      notifyListeners();
    });
  }

  int get bitRate => _recordService.bitRate;
  set bitRate(int value) {
    _recordService.changeBitRate(value);
    notifyListeners();
  }

  double get samplingRate => _recordService.samplingRate;
  set samplingRate(double value) {
    _recordService.changeSamplingRate(value);
    notifyListeners();
  }

  String get fileFormat => _recordService.fileFormat;
  set fileFormat(String value) {
    _recordService.changeFileFormat(value);
    notifyListeners();
  }

  double? get amplitude => _recordService.amplitude;
  List<double> get amplitudeHistory => _recordService.amplitudeHistory;
  int get lengthOfHistory => _recordService.lengthOfHistory;

  set recordState(RecordState? value) {
    _recordService.recordState = value ?? RecordState.ready;
    notifyListeners();
  }

  Stream<RecordState> get recordStateStream => _recordService.recordStateStream;
  RecordState? get recordState => _recordService.recordStateStream.valueOrNull;

  // Check permission for recording audio
  Future<bool> checkPermission() async {
    return await _recordService.checkPermission();
  }

  // Record audio
  Future<void> startRecord(String path) async {
    return await _recordService.startRecord(path);
  }

  // Stop recording audio
  Future<String> stopRecord() async {
    final path = await _recordService.stopRecord();
    _recordService.amplitude = null;
    notifyListeners();
    return path;
  }

  // Pause recording audio
  Future<void> pauseRecord() async {
    await _recordService.pauseRecord();
    _recordService.amplitude = null;
    notifyListeners();
  }

  // Resume recording audio
  Future<void> resumeRecord() async {
    return await _recordService.resumeRecord();
  }

  // Is recording?
  Future<bool> isRecording() async {
    return await _recordService.isRecording();
  }

  // Is paused?
  Future<bool> isPaused() async {
    return await _recordService.isPaused();
  }

  // Get current amplitude
  Future<double?> getAmplitude() async {
    final amplitude = await _recordService.getAmplitude();
    notifyListeners();
    return amplitude;
  }

  // Dispose service
  @override
  void dispose() {
    _recordService.dispose();
    super.dispose();
  }
}
