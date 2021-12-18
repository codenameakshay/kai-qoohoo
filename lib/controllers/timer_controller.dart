import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kai/services/timer_service.dart';

class TimerController with ChangeNotifier {
  final TimerService _timerService = TimerService();

  Timer? get timer => _timerService.timer;
  Timer? get ampTimer => _timerService.ampTimer;

  // Start timer
  void startTimer(Duration duration, Function() action) {
    _timerService.startTimer(duration, action);
    notifyListeners();
  }

  // Start amplitude timer
  void startAmplitudeTimer(Duration duration, Function() action) {
    _timerService.startAmplitudeTimer(duration, action);
    notifyListeners();
  }

  // Cancel timer
  void cancelTimer() {
    _timerService.cancelTimer();
  }

  // Cancel amplitude timer
  void cancelAmplitudeTimer() {
    _timerService.cancelAmplitudeTimer();
  }

  // Dispose service
  @override
  void dispose() {
    _timerService.dispose();
    super.dispose();
  }
}
