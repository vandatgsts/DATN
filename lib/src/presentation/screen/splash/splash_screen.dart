import 'package:ar_drawing/src/presentation/app/app_controller.dart';
import 'package:ar_drawing/src/presentation/widget/app_image_widget.dart';
import 'package:ar_drawing/src/resource/string/app_string.dart';
import 'package:ar_drawing/src/utils/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/base_screen.dart';
import '../../widget/app_container.dart';
import 'splash_controller.dart';

class SplashScreen extends BaseScreen<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget buildWidgets() {
    return AppContainer(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0.sp),
                child: AppImageWidget.asset(
                  path: AppImage.logo,
                  width: Get.width / 3,
                ),
              ),
              SizedBox(
                height: 12.0.sp,
              ),
              SizedBox(
                height: 24.0.sp,
                width: 24.0.sp,
                child: CircularProgressIndicator(
                  color: const Color(0xFF12203A),
                  strokeWidth: 3.0.sp,
                ),
              ),
              SizedBox(
                height: 12.0.sp,
              ),
              Obx(
                () => !Get.find<AppController>().isPremium.value
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.0.sp,
                        ),
                        child: Text(
                          StringConstants.contentLoadingAds.tr,
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF12203A),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              )
            ],
          ),
          Column(
            children: [
              const Spacer(),
              Obx(
                () => Text(
                  controller.version.value,
                  style: controller.context.theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
