import 'dart:async';

import 'package:flutter/services.dart';

class MetaSdk {
  static final _instance = MetaSdk._internal();

  MetaSdk._internal();

  static MetaSdk getInstance() {
    return _instance;
  }

  static const MethodChannel _channel = MethodChannel('meta_sdk');

  static Future<void> logEvent({
    required String name,
    Map<String, dynamic>? parameters,
    double? valueToSum,
  }) async {
    await _channel.invokeMethod('log_event', {
      'name': name,
      'parameters': parameters,
      'value_to_sum': valueToSum,
    });

    return;
  }

  static Future<void> logPurchase({
    double? amount,
    String? currency,
    Map<String, dynamic>? parameters,
  }) async {
    await _channel.invokeMethod('log_event', {
      'amount': amount,
      'currency': currency,
      'parameters': parameters,
    });

    return;
  }
}
