import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kai/services/record_service.dart';
import 'package:record/record.dart';

class RecordController with ChangeNotifier {
  final RecordService _recordService = RecordService();

  RecordController() {
    _recordService.recordStateStream.listen((event) {
      notifyListeners();
    });
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
    return await _recordService.stopRecord();
  }

  // Pause recording audio
  Future<void> pauseRecord() async {
    return await _recordService.pauseRecord();
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
  Future<Amplitude> getAmplitude() async {
    return await _recordService.getAmplitude();
  }

  // Dispose service
  @override
  void dispose() {
    _recordService.dispose();
    super.dispose();
  }
}