import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'in_app_review_platform_interface.dart';

class MethodChannelInAppReview extends InAppReviewPlatform {
  MethodChannel _channel = const MethodChannel('in_app_review');

  @visibleForTesting
  set channel(MethodChannel channel) => _channel = channel;

  @override
  Future<bool> isAvailable() async {
    if (kIsWeb) return false;
    return _channel
        .invokeMethod<bool>('isAvailable')
        .then((available) => available ?? false, onError: (_) => false);
  }

  @override
  Future<void> requestReview() => _channel.invokeMethod('requestReview');

  @override
  Future<void> openStoreListing({
    String? appStoreId,
    String? microsoftStoreId,
  }) async {
    final bool isiOS = Platform.isIOS;
    final bool isAndroid = Platform.isAndroid;

    if (isiOS) {
      await _channel.invokeMethod(
        'openStoreListing',
        ArgumentError.checkNotNull(appStoreId, 'appStoreId'),
      );
    } else if (isAndroid) {
      await _channel.invokeMethod('openStoreListing');
    } else {
      throw UnsupportedError(
        'Platform(${Platform.operatingSystem}) not supported',
      );
    }
  }
}
