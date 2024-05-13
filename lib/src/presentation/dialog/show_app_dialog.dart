import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resource/string/app_string.dart';
import 'app_dialog.dart';

Future showAppDialog(
  BuildContext context,
  String titleText,
  String messageText, {
  Widget? messageWidget,
  TextStyle? messageTextStyle,
  TextStyle? titleTextStyle,
  Widget? widgetBody,
  Widget? widgetTopRight,
  Widget? coverScreenWidget,
  String? firstButtonText,
  VoidCallback? firstButtonCallback,
  String? secondButtonText,
  VoidCallback? secondButtonCallback,
  bool dismissAble = false,
  WidgetBuilder? builder,
  Color? backgroundColor,
  double? heightDialog,
  double? widthDialog,
  bool? hideGroupButton,
  Widget? fullContentWidget,
  EdgeInsetsGeometry? padding,
  Widget? widgetAboveTitle,
      bool? isShowNativeAd,
}) {
  return showDialog(
    context: context,
    barrierDismissible: dismissAble,
    builder: builder ??
        (BuildContext context) => AppDialog(
              title: titleText,
              message: messageText,
              messageWidget: messageWidget,
              widgetBody: widgetBody,
              coverScreenWidget: coverScreenWidget,
              firstButtonCallback: firstButtonCallback,
              titleTextStyle: titleTextStyle,
              messageTextStyle: messageTextStyle,
              secondButtonText: secondButtonText,
              secondButtonCallback: secondButtonCallback,
              backgroundColor: backgroundColor,
              heightDialog: heightDialog,
              widthDialog: widthDialog,
              hideGroupButton: hideGroupButton,
              fullContentWidget: fullContentWidget,
              firstButtonText: firstButtonText ?? StringConstants.cancel.tr,
              padding: padding,
              widgetAboveTitle: widgetAboveTitle,
          isShowSmallNativeAds: isShowNativeAd,
            ),
  );
}
