import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';


import '../../../resource/string/app_string.dart';
import '../../../utils/app_image.dart';
import '../../../utils/disable_glow_behavior.dart';
import '../../app/app_controller.dart';
import '../../base/base_screen.dart';
import '../../theme/app_color.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_touchable.dart';
import 'setting_controller.dart';

class SettingScreen extends BaseScreen<SettingController> {
  const SettingScreen({super.key});

  Widget itemSetting(
    String image,
    String content,
    Function() onPressed, {
    bool isLanguage = false,
  }) {
    return AppTouchable(
      onPressed: onPressed,
      width: Get.width,
      height: 56.sp,
      radius: 12.0.sp,
      margin: EdgeInsets.symmetric(vertical: 8.sp),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 6,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImageWidget.asset(path: image),
          Gap(16.sp),
          Expanded(
            child: FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: Text(
                content,
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          isLanguage
              ? Obx(
                  () => Text(
                    Get.find<AppController>().languageName.value,
                    style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  Widget buildWidgets() {
    return AppContainer(
      havePadding: false,
      child: Column(
        children: [
          AppHeader(
            title: StringConstants.setting.tr,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: ScrollConfiguration(
                behavior: DisableGlowBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() {
                        final AppController appController =
                            Get.find<AppController>();

                        if (!appController.isPremium.value) {
                          return Container(
                            margin: EdgeInsets.only(
                              bottom: 6.sp,
                            ),
                            child: AspectRatio(
                              aspectRatio: 39 / 18,
                              child: Stack(
                                children: [
                                  AppImageWidget.asset(
                                      path: AppImage.imgSetting),
                                  Positioned(
                                    bottom: 12.0.sp,
                                    left: 12.0.sp,
                                    child: AppTouchable(
                                      onPressed: controller.onPressToPremium,
                                      child: AppImageWidget.asset(
                                        path: AppImage.buttonPremium,
                                        width: 118.0.sp,
                                        height: 36.0.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      }),

                      // itemSetting(
                      //     AppImage.icLanguage,
                      //     StringConstants.language.tr,
                      //     () => controller.onPressLanguage(),
                      //     isLanguage: true),
                      itemSetting(
                        AppImage.icRate,
                        StringConstants.rate.tr,
                        () => controller.onPressRate(),
                      ),
                      itemSetting(
                        AppImage.icTerm,
                        StringConstants.termOfCondition.tr,
                        () => controller.onPressTermOfCondition(),
                      ),
                      itemSetting(
                        AppImage.icPrivacy,
                        StringConstants.privacy.tr,
                        () => controller.onPressPrivacy(),
                      ),
                      itemSetting(
                        AppImage.icContact,
                        StringConstants.contact.tr,
                        () => controller.onPressContact(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
         
        ],
      ),
    );
  }
}
