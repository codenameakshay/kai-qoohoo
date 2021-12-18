import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kai/services/logger_service.dart';
import 'package:kai/services/timer_service.dart';

class TimerController with ChangeNotifier {
  final TimerService _timerService = TimerService();

  Timer? get timer => _timerService.timer;
  Timer? get ampTimer => _timerService.ampTimer;

  // Start timer
  void startTimer(Duration duration, Function() action) {
    _timerService.startTimer(duration, action);
    logger.d('timer started');
    notifyListeners();
  }

  // Start amplitude timer
  void startAmplitudeTimer(Duration duration, Function() action) {
    _timerService.startAmplitudeTimer(duration, action);
    logger.d('amplitude timer started');
    notifyListeners();
  }

  // Cancel timer
  void cancelTimer() {
    _timerService.cancelTimer();
    logger.d('timer canceled');
  }

  // Cancel amplitude timer
  void cancelAmplitudeTimer() {
    _timerService.cancelAmplitudeTimer();
    logger.d('amplitude timer canceled');
  }

  // Dispose service
  @override
  void dispose() {
    _timerService.dispose();
    super.dispose();
  }
}
