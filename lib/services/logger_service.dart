import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final printer = LogOutputPrinter();
final logger = Logger(
  level: Level.debug,
  printer: printer,
  filter: kDebugMode
      ? PassThroughFilter()
      : PassThroughFilter(), //!ProductionFilter(), Add before final release
);

class PassThroughFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

class LogOutputPrinter extends PrettyPrinter {
  LogOutputPrinter();

  @override
  List<String> log(LogEvent event) {
    final logMsg = event.message;
    final logLvl = event.level;
    final logStrace = event.stackTrace;
    final logError = event.error;
    final color = PrettyPrinter.levelColors[logLvl];
    final prefix = SimplePrinter.levelPrefixes[logLvl];
    final timeStr = getTime().substring(0, 12);
    if (logStrace != null) {
      // print(color!('$timeStr $prefix - $logMsg \n$logStrace'));
      developer.log(
        color!('$logMsg \n$logError'),
        name: "$timeStr :: ${prefix!.replaceAll("[", "").replaceAll("]", "")}",
        stackTrace: logStrace,
        level: 2000,
      );
    } else {
      // print(color!('$timeStr $prefix - $logMsg'));
      developer.log(
        color!('$logMsg'),
        name: "$timeStr :: ${prefix!.replaceAll("[", "").replaceAll("]", "")}",
      );
    }
    return [];
  }
}
