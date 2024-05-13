import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../theme/app_color.dart';
import '../widget/app_button.dart';

class AppDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? messageWidget;
  final bool dismissAble;
  final Widget? widgetBody;
  final Widget? coverScreenWidget;
  final String firstButtonText;
  final VoidCallback? firstButtonCallback;
  final String? secondButtonText;
  final VoidCallback? secondButtonCallback;
  final Color? backgroundColor;
  final double? heightDialog;
  final double? widthDialog;
  final bool? hideGroupButton;
  final Widget? fullContentWidget;
  final EdgeInsetsGeometry? padding;
  final TextStyle? messageTextStyle;
  final TextStyle? titleTextStyle;
  final Widget? widgetAboveTitle;
  final bool? isShowSmallNativeAds;

  const AppDialog({
    Key? key,
    this.title,
    this.message,
    this.messageWidget,
    this.dismissAble = false,
    this.widgetBody,
    this.coverScreenWidget,
    required this.firstButtonText,
    this.firstButtonCallback,
    this.secondButtonText,
    this.secondButtonCallback,
    this.backgroundColor,
    this.heightDialog,
    this.widthDialog,
    this.hideGroupButton,
    this.fullContentWidget,
    this.titleTextStyle,
    this.messageTextStyle,
    this.padding,
    this.widgetAboveTitle,
    this.isShowSmallNativeAds = true,
  }) : super(key: key);

  Widget _buildGroupButtons() {
    if ((secondButtonText ?? '').isEmpty) {
      return AppButton(
        onTap: () {
          firstButtonCallback ?? Get.back();
        },
        text: firstButtonText,
        color: AppColor.primaryColor,
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0.sp),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 18.0,
        ),
        child: Text(
          firstButtonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0.sp,
            color: AppColor.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppButton(
          onTap: firstButtonCallback ?? Get.back,
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 18.0,
          ),
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
            side: const BorderSide(
              color: AppColor.primaryColor,
              width: 1.0,
            ),
          ),
          text: firstButtonText,
          color: Colors.white,
          child: Text(
            firstButtonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0.sp,
              color: AppColor.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: 12.0.sp),
        AppButton(
          onTap: secondButtonCallback,
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 18.0,
          ),
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          color: AppColor.primaryColor,
          textColor: Colors.white,
          child: Text(
            secondButtonText ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0.sp,
              color: AppColor.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var dialogWidth = min<double>(width * 0.9, 400.0.sp);

    return WillPopScope(
      onWillPop: () async => dismissAble,
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0.sp),
        ),
        elevation: 0.0,
        backgroundColor: backgroundColor ?? Colors.white,
        child: Stack(
          children: [
            fullContentWidget ??
                Container(
                  decoration: BoxDecoration(
                    color: backgroundColor ?? AppColor.white,
                    borderRadius: BorderRadius.circular(12.0.sp),
                  ),
                  width: widthDialog ?? dialogWidth,
                  height: heightDialog,
                  padding: padding ??
                      EdgeInsets.symmetric(
                        vertical: 12.0.sp,
                        horizontal: 16.0.sp,
                      ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widgetAboveTitle ?? const SizedBox.shrink(),
                      (title ?? '').isNotEmpty
                          ? Text(
                              title!,
                              textAlign: TextAlign.center,
                              style: titleTextStyle ??
                                  TextStyle(
                                    color: AppColor.black,
                                    fontSize: 20.0.sp,
                                    fontWeight: FontWeight.w400,
                                    height: 24 / 20,
                                  ),
                            )
                          : const SizedBox.shrink(),
                      widgetBody ??
                          Column(
                            children: [
                              (message ?? '').isEmpty
                                  ? const SizedBox.shrink()
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 20.0.sp,
                                      ),
                                      child: Text(
                                        message!,
                                        textAlign: TextAlign.center,
                                        style: messageTextStyle ??
                                            TextStyle(
                                              color: AppColor.black,
                                              fontSize: 16.0.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ),
                              messageWidget ?? const SizedBox.shrink(),
                            ],
                          ),
                     
                      hideGroupButton == true
                          ? const SizedBox.shrink()
                          : _buildGroupButtons(),
                    ],
                  ),
                ),
            Positioned.fill(
              child: coverScreenWidget ?? const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
