
import 'package:ar_drawing/src/presentation/base/base_screen.dart';
import 'package:ar_drawing/src/presentation/screen/permission/permission_controller.dart';
import 'package:ar_drawing/src/presentation/theme/app_color.dart';
import 'package:ar_drawing/src/presentation/widget/app_container.dart';
import 'package:ar_drawing/src/presentation/widget/app_header.dart';
import 'package:ar_drawing/src/presentation/widget/app_switch.dart';
import 'package:ar_drawing/src/presentation/widget/app_touchable.dart';
import 'package:ar_drawing/src/resource/string/app_string.dart';
import 'package:ar_drawing/src/utils/app_log.dart';
import 'package:ar_drawing/src/utils/disable_glow_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';



class PermissionScreen extends BaseScreen<PermissionController> {
  const PermissionScreen({super.key});

  @override
  Widget buildWidgets() {
    return AppContainer(
        child: Column(
      children: [
        AppHeader(
          leftWidget: SizedBox(
            width: 40.sp,
          ),
          title: StringConstants.permission.tr,
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior: DisableGlowBehavior(),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 20.sp,
              ),
              child: Column(
                children: [
                  Text(
                    StringConstants.contentPermission.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 5.0.sp,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0.sp,
                      horizontal: 20.0.sp,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFDEDEDE),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(16.0.sp),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12.0.sp,
                        ),
                        Expanded(
                          child: Text(
                            StringConstants.camera.tr,
                            style: TextStyle(
                              color: const Color(0xFF565656),
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Obx(() => AppSwitch(
                              value: controller.statusCamera.value,
                              onToggle: (value) {
                                controller.statusCamera.value =
                                    !controller.statusCamera.value;
                                AppLog.info(controller.statusCamera.value);
                              },
                              activeColor: AppColor.primaryColor,
                            )),
                        SizedBox(
                          width: 12.0.sp,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 5.0.sp,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0.sp,
                      horizontal: 20.0.sp,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFDEDEDE),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(16.0.sp),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12.0.sp,
                        ),
                        Expanded(
                          child: Text(
                            StringConstants.micro.tr,
                            style: TextStyle(
                              color: const Color(0xFF565656),
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Obx(() => AppSwitch(
                              value: controller.statusRecordAudio.value,
                              onToggle: (value) {
                                controller.statusRecordAudio.value =
                                    !controller.statusRecordAudio.value;
                                AppLog.info(controller.statusRecordAudio.value);
                              },
                              activeColor: AppColor.primaryColor,
                            )),
                        SizedBox(
                          width: 12.0.sp,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 5.0.sp,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0.sp,
                      horizontal: 20.0.sp,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFDEDEDE),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(16.0.sp),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12.0.sp,
                        ),
                        Expanded(
                          child: Text(
                            StringConstants.storage.tr,
                            style: TextStyle(
                              color: const Color(0xFF565656),
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Obx(() => AppSwitch(
                              value: controller.statusStorage.value,
                              onToggle: (value) {
                                controller.statusStorage.value =
                                    !controller.statusStorage.value;
                                AppLog.info(controller.statusStorage.value);
                              },
                              activeColor: AppColor.primaryColor,
                            )),
                        SizedBox(
                          width: 12.0.sp,
                        ),
                      ],
                    ),
                  ),
                  Gap(20.sp),
                  AppTouchable(
                    onPressed: () => controller.onPressContinue(),
                    backgroundColor: AppColor.primaryColor,
                    radius: 12.sp,
                    padding: EdgeInsets.symmetric(
                      vertical: 14.sp,
                      horizontal: 60.sp,
                    ),
                    child: Text(
                      StringConstants.continues.tr,
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 20.sp,
                        fontFamily: "ShortStack",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
