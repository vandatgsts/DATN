import 'package:app_settings/app_settings.dart';
import 'package:ar_drawing/src/resource/string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'show_app_dialog.dart';

Future<void> showConnectivityDialog({
  required BuildContext context,
  required Function() firstButtonCall,
}) async {
  showAppDialog(
    context,
    StringConstants.error.tr,
    StringConstants.checkInternetConnection.tr,
    firstButtonText: StringConstants.retry.tr,
    firstButtonCallback: () {
      Get.back();

      firstButtonCall.call();
    },
    secondButtonText: StringConstants.setting.tr,
    secondButtonCallback: () async {
      await AppSettings.openAppSettings(
        type: AppSettingsType.wifi,
      );
    },
  );
}
