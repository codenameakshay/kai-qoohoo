import 'dart:async';

import 'package:path_provider/path_provider.dart';

class PathService {
  // Get temp directory path
  Future<String> getTempPath() async {
    return (await getTemporaryDirectory()).path;
  }

  // Get application documents directory path
  Future<String> getDocPath() async {
    return (await getExternalStorageDirectory())?.path ?? "";
  }
}
