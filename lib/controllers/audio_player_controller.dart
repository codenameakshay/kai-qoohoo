import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kai/services/audio_player_service.dart';

class AudioPlayerController with ChangeNotifier {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();
  late StreamSubscription<PlayerState> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;

  // add listerners
  AudioPlayerController() {
    _playerStateChangedSubscription =
        _audioPlayerService.playerStateStream.listen((state) {
      notifyListeners();
    });
    _durationChangedSubscription =
        _audioPlayerService.playerDurationStream.listen((duration) {
      notifyListeners();
    });
    _positionChangedSubscription =
        _audioPlayerService.playerPositionStream.listen((position) {
      notifyListeners();
    });
  }

  // Set audio source
  Future<void> setSource(String path) async {
    await _audioPlayerService.setSource(path);
  }

  // Play audio
  Future<void> play() async {
    await _audioPlayerService.play();
  }

  // Pause audio
  Future<void> pause() async {
    await _audioPlayerService.pause();
  }

  // Stop audio
  Future<void> stop() async {
    await _audioPlayerService.stop();
  }

  // Seek to a position
  Future<void> seek(Duration position) async {
    await _audioPlayerService.seek(position);
  }

  // Get current position
  Duration get position {
    return _audioPlayerService.position;
  }

  // Get duration
  Duration? get duration {
    return _audioPlayerService.duration;
  }

  // Get audio player
  AudioPlayer get audioPlayer {
    return _audioPlayerService.audioPlayer;
  }

  // dispose all the streams
  @override
  void dispose() {
    _playerStateChangedSubscription.cancel();
    _durationChangedSubscription.cancel();
    _positionChangedSubscription.cancel();
    _audioPlayerService.dispose();
    super.dispose();
  }
}
