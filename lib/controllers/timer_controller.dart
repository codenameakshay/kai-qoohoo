import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kai/services/logger_service.dart';
import 'package:kai/services/timer_service.dart';

class TimerController with ChangeNotifier {
  final TimerService _timerService = TimerService();

  Timer? get timer => _timerService.timer;
  Timer? get ampTimer => _timerService.ampTimer;
  int get recordDuration => _timerService.recordDuration;

  // Start timer
  void startTimer() {
    _timerService.startTimer(() {
      notifyListeners();
    });
    logger.d('timer started');
    notifyListeners();
  }

  // Set record duration to zero
  void resetTimer() {
    _timerService.resetTimer();
    logger.d('record duration reset');
    notifyListeners();
  }

  // Start amplitude timer
  void startAmplitudeTimer(Function() action) {
    _timerService.startAmplitudeTimer(action);
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
