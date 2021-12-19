// import 'package:kai/services/logger_service.dart';
import 'package:linalg/linalg.dart';
import 'dart:math';

class SgFilter {
  late final int _order;
  late final int _frameLength;
  late int _size;
  late Matrix _kernel;

  /// The constructor for SgFilter
  /// Arguments:
  ///   - _order: int, the order of polynomial.
  ///   - _frameLength: int, the windows size for smoothing.
  /// Return:
  ///   - SgFilter
  SgFilter(this._order, this._frameLength) {
    _size = _frameLength ~/ 2;
    _kernel = _buildKernel();
  }

  /// Build the kernel for smoothing
  /// Arguments:
  ///   - void
  /// Return:
  ///   - Matrix: the kernel for smoothing
  Matrix _buildKernel() {
    List<double> baseSeq = [];
    List<List<double>> tempMatrix = [];
    Matrix matrix;
    Matrix kernel;

    // construct base sequence
    for (int i = -_size; i <= _size; i++) {
      baseSeq.add(i.toDouble());
    }

    // fill the tempMatrix
    for (int i = 0; i < _order; i++) {
      List<double> tempSeq = [];

      // make row
      for (double val in baseSeq) {
        tempSeq.add(pow(val, i).toDouble());
      }

      // add row
      tempMatrix.add(tempSeq);
    }

    // convert List<List<double>> to Matrix
    matrix = Matrix(tempMatrix).transpose();

    // Calculate the kernel
    try {
      kernel =
          matrix * (matrix.transpose() * matrix).inverse() * matrix.transpose();
    } catch (e) {
      // logger.e(e, e, s);
      kernel = matrix * (matrix.transpose() * matrix) * matrix.transpose();
    }

    return kernel;
  }

  /// Smooth given data
  /// Arguments:
  ///   - x: List<dynamic>, input data, only support int/double type.
  /// Return:
  ///   - List<dynamic>: Data after smoothing
  /// Throws:
  ///   - FormatException:
  ///      - if the data type is neither int nor double.
  ///      - Or the input length < _frameLength
  List<dynamic> smooth(List<dynamic> x) {
    List<double> dataAfterSmooth = [];
    List<double> inputData = [];

    // validate input data
    if (x.length < _frameLength) {
      throw FormatException(
          "The length of input must be >= _frameLength. (_frameLength=$_frameLength; input=${x.length})");
    }
    if (x[0].runtimeType != 0.runtimeType &&
        x[0].runtimeType != 1.0.runtimeType) {
      throw FormatException(
          "Only support int/double, get: ${x[0].runtimeType}!");
    }

    // convert List<int> to List<double> if needed
    if (x[0].runtimeType == 0.runtimeType) {
      for (int val in x) {
        inputData.add(val * 1.0);
      }
    } else {
      inputData = x as List<double>;
    }

    // add padding
    // adding padding in the front
    for (int i = 0; i < _size; i++) {
      inputData.insert(0, 1);
    }

    // adding padding at the end
    for (int i = 0; i < _size; i++) {
      inputData.add(1);
    }

    // smoothing input data
    for (int i = _size; i < inputData.length - _size; i++) {
      List<List<double>> tempWin = [
        inputData.sublist(i - _size, i + _size + 1)
      ];
      Matrix windowX = Matrix(tempWin).transpose();
      dataAfterSmooth.add((_kernel * windowX)[_size][0]);
    }

    return dataAfterSmooth;
  }

  /// getters
  int get order {
    return _order;
  }

  int get frameLength {
    return _frameLength;
  }

  Matrix get kernel {
    return _kernel;
  }
}
