import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../resource/string/app_string.dart';
import '../../../utils/app_image.dart';
import '../../../utils/firebase_analytics.dart';
import '../../theme/app_color.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_touchable.dart';

class DenyCameraScreen extends StatelessWidget {
  const DenyCameraScreen({super.key, this.isDenyPhoto = false});

  final bool isDenyPhoto;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          const AppHeader(),
          const Spacer(),
          AppImageWidget.asset(
            path: AppImage.imgDenyCamera,
            width: Get.width * 0.6,
          ),
          Gap(28.sp),
          Text(
            isDenyPhoto
                ? StringConstants.denyStorage.tr
                : StringConstants.denyCamera.tr,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
                color: AppColor.textColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
          Gap(10.sp),
          AppTouchable(
            onPressed: () async {
              AppFirebaseAnalytics.instance.logEvent(name: "open_app_setting");
              await openAppSettings();
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 32.sp,
                vertical: 18.sp,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0.sp),
                color: AppColor.primaryColor,
              ),
              child: Text(
                StringConstants.openSettings.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0.sp,
                  color: AppColor.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Gap(100.sp),
          const Spacer(),
        ],
      ),
    );
  }
}
