import 'dart:async';

import 'in_app_review_platform_interface.dart';

class InAppReview {
  InAppReview._();

  static final InAppReview instance = InAppReview._();

  Future<bool> isAvailable() async => await InAppReviewPlatform.instance.isAvailable();

  Future<void> requestReview() async => await InAppReviewPlatform.instance.requestReview();

  Future<void> openStoreListing({
    String? appStoreId,
    String? microsoftStoreId,
  }) =>
      InAppReviewPlatform.instance.openStoreListing(
        appStoreId: appStoreId,
        microsoftStoreId: microsoftStoreId,
      );
}
