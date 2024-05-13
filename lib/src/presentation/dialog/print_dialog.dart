import 'package:ar_drawing/src/presentation/theme/app_color.dart';
import 'package:ar_drawing/src/presentation/theme/short_stack_text_theme.dart';
import 'package:ar_drawing/src/resource/string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'show_app_dialog.dart';

Future<void> showPrintDialog(
  BuildContext context, {
  required Function() onPressCancel,
  required Function() onPressConnect,
}) async {
  await showAppDialog(
    context,
   StringConstants.print.tr,
    StringConstants.printContent.tr,
    titleTextStyle: ShortStackTextTheme.titleMedium(AppColor.textColor),
    backgroundColor: const Color(0xFFF0F0F0),
    firstButtonText: StringConstants.cancel.tr,
    secondButtonText: StringConstants.connect.tr,
    firstButtonCallback: onPressCancel,
    secondButtonCallback: onPressConnect,
  );
}
