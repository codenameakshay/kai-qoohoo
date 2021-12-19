import 'dart:async';
import 'dart:io';

import 'package:kai/services/logger_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

enum DocState {
  ready,
  loading,
  error,
}

class PathService {
  final _docStateSubject = BehaviorSubject<DocState>.seeded(DocState.ready);

  ValueStream<DocState> get docStateStream => _docStateSubject.stream;

  set docState(DocState v) => _docStateSubject.add(v);
  // Get temp directory path
  Future<String> getTempPath() async {
    return (await getTemporaryDirectory()).path;
  }

  // Get application documents directory path
  Future<String> getDocPath() async {
    return (await getExternalStorageDirectory())?.path ?? "";
  }

  // Get application documents directory
  Future<Directory?> getDocs() async {
    docState = DocState.loading;
    try {
      final tempD = await getExternalStorageDirectory();
      docState = DocState.ready;
      return tempD;
    } catch (e, s) {
      logger.e(e, e, s);
      docState = DocState.error;
      return null;
    }
  }
}
