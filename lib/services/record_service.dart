import 'package:record/record.dart';
import 'dart:async';

class RecordService {
  final Record _record = Record();

  // Check permission for recording audio
  Future<bool> checkPermission() async {
    return await _record.hasPermission();
  }

  // Record audio
  Future<void> startRecord(String path) async {
    return await _record.start(path: path, encoder: AudioEncoder.AAC_HE);
  }

  // Stop recording audio
  Future<String> stopRecord() async {
    return await _record.stop() ?? "";
  }

  // Pause recording audio
  Future<void> pauseRecord() async {
    return await _record.pause();
  }

  // Resume recording audio
  Future<void> resumeRecord() async {
    return await _record.resume();
  }

  // Is recording?
  Future<bool> isRecording() async {
    return await _record.isRecording();
  }

  // Is paused?
  Future<bool> isPaused() async {
    return await _record.isPaused();
  }

  // Get current amplitude
  Future<Amplitude> getAmplitude() async {
    return await _record.getAmplitude();
  }

  // Dispose record in RecordService
  void dispose() {
    _record.dispose();
  }
}
