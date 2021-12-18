import 'package:get_it/get_it.dart';
import 'package:kai/controllers/audio_player_controller.dart';
import 'package:kai/controllers/path_controller.dart';
import 'package:kai/controllers/record_controller.dart';
import 'package:kai/controllers/timer_controller.dart';
import 'package:kai/router/app_router.dart';
import 'package:kai/services/audio_player_service.dart';
import 'package:kai/services/logger_service.dart';
import 'package:kai/services/path_service.dart';
import 'package:kai/services/record_service.dart';
import 'package:kai/services/timer_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  Stopwatch stopwatch = Stopwatch()..start();
  locator.registerFactory<AudioPlayerController>(() => AudioPlayerController());
  locator.registerFactory<PathController>(() => PathController());
  locator.registerFactory<RecordController>(() => RecordController());
  locator.registerFactory<TimerController>(() => TimerController());
  locator.registerSingleton<AppRouter>(AppRouter());
  locator.registerLazySingleton<AudioPlayerService>(() => AudioPlayerService());
  locator.registerLazySingleton<PathService>(() => PathService());
  locator.registerLazySingleton<RecordService>(() => RecordService());
  locator.registerLazySingleton<TimerService>(() => TimerService());
  logger.d('Locator setup took ${stopwatch.elapsedMilliseconds} ms');
  stopwatch.stop();
}
