import 'package:kai/services/logger_service.dart';
import 'package:record/record.dart';
import 'dart:async';

import 'package:rxdart/rxdart.dart';

enum RecordState {
  ready,
  recording,
  paused,
  error,
}

class RecordService {
  final Record _record = Record();

  final _recordStateSubject =
      BehaviorSubject<RecordState>.seeded(RecordState.ready);

  ValueStream<RecordState> get recordStateStream => _recordStateSubject.stream;

  set recordState(RecordState v) => _recordStateSubject.add(v);

  // Check permission for recording audio
  Future<bool> checkPermission() async {
    final bool permission = await _record.hasPermission();
    if (permission) {
      recordState = RecordState.ready;
    } else {
      recordState = RecordState.error;
    }
    return permission;
  }

  // Record audio
  Future<void> startRecord(String path) async {
    try {
      await _record.start(path: path, encoder: AudioEncoder.AAC_HE);
      recordState = RecordState.recording;
    } catch (e, s) {
      logger.e(e, e, s);
      recordState = RecordState.error;
    }
  }

  // Stop recording audio
  Future<String> stopRecord() async {
    try {
      final String path = await _record.stop() ?? "";
      recordState = RecordState.ready;
      return path;
    } catch (e, s) {
      logger.e(e, e, s);
      recordState = RecordState.error;
      return "";
    }
  }

  // Pause recording audio
  Future<void> pauseRecord() async {
    try {
      await _record.pause();
      recordState = RecordState.paused;
    } catch (e, s) {
      logger.e(e, e, s);
      recordState = RecordState.error;
    }
  }

  // Resume recording audio
  Future<void> resumeRecord() async {
    try {
      await _record.resume();
      recordState = RecordState.recording;
    } catch (e, s) {
      logger.e(e, e, s);
      recordState = RecordState.error;
    }
  }

  // Is recording?
  Future<bool> isRecording() async {
    final bool isRecording = await _record.isRecording();
    if (isRecording) {
      recordState = RecordState.recording;
    } else {
      recordState = RecordState.ready;
    }
    return isRecording;
  }

  // Is paused?
  Future<bool> isPaused() async {
    final bool isPaused = await _record.isPaused();
    if (isPaused) {
      recordState = RecordState.paused;
    } else {
      recordState = RecordState.ready;
    }
    return isPaused;
  }

  // Get current amplitude
  Future<Amplitude> getAmplitude() async {
    return await _record.getAmplitude();
  }

  // Dispose record in RecordService
  void dispose() {
    _recordStateSubject.close();
    _record.dispose();
  }
}
