import 'dart:async';

import 'package:flutter/services.dart';

class OpenCV {
  static final _instance = OpenCV._internal();

  OpenCV._internal();

  static OpenCV getInstance() {
    return _instance;
  }

  static const MethodChannel _channel = MethodChannel('opencv');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  // static Future<Uint8List?> adaptiveThreshold({
  //   required Uint8List? byteData,
  //   required int blockSize,
  //   required double cValue,
  // }) async {
  //   assert(blockSize > 1, "Block size > 1");
  //   assert(blockSize % 2 == 1, "Block size là số lẻ");
  //
  //   final Uint8List? result =
  //       await _channel.invokeMethod('adaptive_threshold', {
  //     'byteData': byteData,
  //     'blockSize': blockSize,
  //     'CValue': cValue,
  //   });
  //
  //   return result;
  // }

  static Future<Uint8List?> processImg({
    required Uint8List byteData,
    double threshold1 = 50.0,
    double threshold2 = 120.0,
    double kernelSize = 2.0,
    required int edgeLevel,
    required double noise,
  }) async {
    final Uint8List? result = await _channel.invokeMethod('process_image', {
      'byteData': byteData,
      'threshold1': threshold1,
      'threshold2': threshold2,
      'kernelSize': kernelSize,
      'edgeLevel': edgeLevel,
      'noise': noise,
    });

    return result;
  }
}
