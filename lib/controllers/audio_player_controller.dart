import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kai/services/audio_player_service.dart';
import 'package:kai/services/logger_service.dart';

class AudioPlayerController with ChangeNotifier {
  final AudioPlayerService _audioPlayerService = AudioPlayerService();
  late StreamSubscription<PlayerState> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;

  // add listerners
  AudioPlayerController(String path) {
    _audioPlayerService.setSource(path);
    _playerStateChangedSubscription =
        _audioPlayerService.playerStateStream.listen((state) {
      logger.d('player state changed: $state');
      notifyListeners();
    });
    _durationChangedSubscription =
        _audioPlayerService.playerDurationStream.listen((duration) {
      logger.d('player duration changed: ${duration?.inSeconds}');
      notifyListeners();
    });
    _positionChangedSubscription =
        _audioPlayerService.playerPositionStream.listen((position) {
      logger.d('player position changed: ${duration?.inSeconds}');
      notifyListeners();
    });
  }

  // Set audio source
  Future<void> setSource(String path) async {
    await _audioPlayerService.setSource(path);
  }

  // Play audio
  Future<void> play() async {
    return await _audioPlayerService.play();
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
