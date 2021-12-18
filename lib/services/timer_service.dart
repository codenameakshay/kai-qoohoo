import 'dart:async';

class TimerService {
  Timer? _timer;
  Timer? _ampTimer;

  int _recordDuration = 0;

  Timer? get timer => _timer;
  Timer? get ampTimer => _ampTimer;
  int get recordDuration => _recordDuration;

  // Start timer
  void startTimer(Function() action) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _recordDuration++;
      action();
    });
  }

  // Set record duration to zero
  void resetTimer() {
    _recordDuration = 0;
  }

  // Start amplitude timer
  void startAmplitudeTimer(Function() action) {
    _ampTimer?.cancel();
    _ampTimer = Timer.periodic(const Duration(milliseconds: 100), (Timer t) {
      action();
    });
  }

  // Cancel timer
  void cancelTimer() {
    _timer?.cancel();
  }

  // Cancel amplitude timer
  void cancelAmplitudeTimer() {
    _ampTimer?.cancel();
  }

  // Dispose timers
  void dispose() {
    _timer?.cancel();
    _ampTimer?.cancel();
  }
}
