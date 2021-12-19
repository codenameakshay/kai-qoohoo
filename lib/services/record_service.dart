import 'dart:math' as math;

import 'package:intl/intl.dart';
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
  int bitRate = 128000;
  double samplingRate = 44100;
  String fileFormat = "wav";
  double? amplitude;
  List<double> amplitudeHistory = [];
  int lengthOfHistory = 20;

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
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd-HH-mm-ss");
    try {
      await _record.start(
        path: path +
            "/Kai_${dateFormat.format(DateTime.now())}_${bitRate}_${samplingRate.toInt()}_.$fileFormat",
        encoder: AudioEncoder.AAC_HE,
        bitRate: bitRate,
        samplingRate: samplingRate,
      );
      recordState = RecordState.recording;
    } catch (e, s) {
      logger.e(e, e, s);
      recordState = RecordState.error;
    }
  }

  // Change bit rate
  void changeBitRate(int bitRate) {
    this.bitRate = bitRate;
  }

  // Change sampling rate
  void changeSamplingRate(double samplingRate) {
    this.samplingRate = samplingRate;
  }

  // Change file format
  void changeFileFormat(String fileFormat) {
    this.fileFormat = fileFormat;
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
  Future<double?> getAmplitude() async {
    final tempAmplitude = await _record.getAmplitude();
    final double currentAmp =
        math.pow(10, tempAmplitude.current / 20).toDouble();
    amplitude = currentAmp.abs().clamp(0, 1);
    if (amplitudeHistory.length >= lengthOfHistory) {
      amplitudeHistory.removeAt(0);
      amplitudeHistory.add(amplitude ?? 0);
    } else {
      amplitudeHistory.add(amplitude ?? 0);
    }
    var sum = 0.0;
    var n = amplitudeHistory.length;
    for (int i = 0; i < n; i++) {
      sum += amplitudeHistory[i] * (i + 1);
    }
    amplitude = sum / (n * (n + 1) / 2);
    // logger.i(amplitudeHistory);
    // logger.i(amplitude);
    return amplitude;
  }

  // Dispose record in RecordService
  void dispose() {
    _recordStateSubject.close();
    _record.dispose();
  }
}
