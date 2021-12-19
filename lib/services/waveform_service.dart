import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:just_waveform/just_waveform.dart';
import 'package:kai/services/locator_service.dart';
import 'package:kai/services/path_service.dart';
import 'dart:async';

import 'package:rxdart/rxdart.dart';

enum WaveformState {
  ready,
  loading,
  error,
}

class WaveformService {
  final PathService _pathService = locator<PathService>();

  final _waveStateSubject =
      BehaviorSubject<WaveformState>.seeded(WaveformState.ready);
  final progressStream = BehaviorSubject<WaveformProgress>();

  ValueStream<WaveformState> get waveStateStream => _waveStateSubject.stream;

  set waveState(WaveformState v) => _waveStateSubject.add(v);

  // Load file from path, and convert into temp wave file
  Future<void> loadWave(String path) async {
    waveState = WaveformState.loading;
    final audioFile = File(path);
    try {
      final waveFile =
          File(p.join(await _pathService.getTempPath(), 'temp.wave'));
      // JustWaveform.parse(audioFile).asStream().listen(progressStream.add, onError: progressStream.addError);
      JustWaveform.extract(
              audioInFile: audioFile,
              waveOutFile: waveFile,
              zoom: const WaveformZoom.pixelsPerSecond(100))
          .listen(progressStream.add, onError: progressStream.addError);
      waveState = WaveformState.ready;
    } catch (e) {
      progressStream.addError(e);
      waveState = WaveformState.error;
    }
  }

  // Dispose streams
  void dispose() {
    _waveStateSubject.close();
    progressStream.close();
  }
}
