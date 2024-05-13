import '../platform_interface/plugin_platform_interface.dart';
import 'method_channel_in_app_review.dart';

abstract class InAppReviewPlatform extends PlatformInterface {
  InAppReviewPlatform() : super(token: _token);

  static InAppReviewPlatform _instance = MethodChannelInAppReview();

  static final Object _token = Object();

  static InAppReviewPlatform get instance => _instance;

  static set instance(InAppReviewPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isAvailable() {
    throw UnimplementedError('isAvailable() has not been implemented.');
  }

  Future<void> requestReview() {
    throw UnimplementedError('requestReview() has not been implemented.');
  }

  Future<void> openStoreListing({
    String? appStoreId,
    String? microsoftStoreId,
  }) {
    throw UnimplementedError('openStoreListing() has not been implemented.');
  }
}
