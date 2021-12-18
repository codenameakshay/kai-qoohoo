import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kai/services/path_service.dart';

class PathController with ChangeNotifier {
  final PathService _pathService = PathService();

  // Get temp directory path
  Future<String> getTempPath() async {
    return _pathService.getTempPath();
  }

  // Get application documents directory path
  Future<String> getDocPath() async {
    return _pathService.getDocPath();
  }
}
