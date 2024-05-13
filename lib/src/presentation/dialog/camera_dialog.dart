import 'package:ar_drawing/src/resource/string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/app_image.dart';
import '../theme/app_color.dart';
import '../widget/app_image_widget.dart';
import '../widget/app_touchable.dart';
import 'show_app_dialog.dart';

class _ItemDialog extends StatelessWidget {
  final String title;
  final String imgPath;
  final Function() onPressed;

  const _ItemDialog({
    required this.title,
    required this.imgPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double circularValue = 12.0.sp;

    return AppTouchable(
      onPressed: onPressed,
      width: 98.0.sp,
      height: 98.0.sp,
      radius: circularValue,
      padding: EdgeInsets.symmetric(
        vertical: 12.0.sp,
        horizontal: 8.0.sp,
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(circularValue),
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0.sp,
          ),
        ],
      ),
      child: Column(
        children: [
          AppImageWidget.asset(
            path: imgPath,
            width: 48.0.sp,
            height: 48.0.sp,
          ),
          Expanded(
            child: Text(
              title,
              style: context.textTheme.titleMedium?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showCameraDialog(
  BuildContext context, {
  required Function() onPressCamera,
  required Function() onPressPhoto,
}) async {
  await showAppDialog(
    context,
    '',
    '',
    backgroundColor: const Color(0xFFF0F0F0),
    hideGroupButton: true,
    widgetBody: Column(
      children: [
        Row(
          children: [
            const Spacer(),
            AppTouchable(
              onPressed: Get.back,
              child: const Icon(
                Icons.close_rounded,
                color: AppColor.borderColor,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25.0.sp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ItemDialog(
              onPressed: onPressCamera,
              title: StringConstants.camera.tr,
              imgPath: AppImage.imgCamera,
            ),
            SizedBox(
              width: 16.0.sp,
            ),
            _ItemDialog(
              onPressed: onPressPhoto,
              title: StringConstants.photo.tr,
              imgPath: AppImage.imgGallery,
            ),
          ],
        ),
        SizedBox(
          height: 50.0.sp,
        ),
      ],
    ),
  );
}
