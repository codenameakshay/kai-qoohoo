import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:kai/services/logger_service.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;
  Stream<Duration> get playerPositionStream => _audioPlayer.positionStream;
  Stream<Duration?> get playerDurationStream => _audioPlayer.durationStream;

  // Set audio source
  Future<void> setSource(String path) async {
    logger.d("Player source changed: $path");
    final source = AudioSource.uri(Uri.parse(path));
    await _audioPlayer.setAudioSource(source);
  }

  // Play audio
  Future<void> play() async {
    return await _audioPlayer.play();
  }

  // Pause audio
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  // Stop audio
  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  // Seek to a position
  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // Get current position
  Duration get position {
    return _audioPlayer.position;
  }

  // Get duration
  Duration? get duration {
    return _audioPlayer.duration;
  }

  // Get audio player
  AudioPlayer get audioPlayer {
    return _audioPlayer;
  }

  // Dispose record in RecordService
  void dispose() {
    _audioPlayer.dispose();
  }
}
