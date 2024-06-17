import 'dart:math';

import 'package:ar_drawing/src/presentation/screen/home/widget/home_level.dart';
import 'package:ar_drawing/src/utils/app_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../resource/string/app_string.dart';
import '../../../utils/app_image.dart';
import '../../base/base_screen.dart';
import '../../theme/app_color.dart';
import '../../theme/short_stack_text_theme.dart';
import '../../widget/app_container.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_touchable.dart';
import '../../widget/dots_border/dotted_border.dart';
import 'home_controller.dart';
import 'widget/home_line_category.dart';

class HomeScreen extends BaseScreen<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget buildWidgets() {
    return AppContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(controller.context).padding.top,
          ),
          Row(
            children: [
              SizedBox(
                width: 30.0.sp,
              ),
              const Spacer(),
              Text(
                "Ar Draw",
                style: ShortStackTextTheme.headlineSmall(
                  Colors.black,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 30.0.sp,
              )
            ],
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: min(6, controller.listImageAndAds.length + 3),
                padding: EdgeInsets.only(
                  bottom: 16.0.sp,
                ),
                itemBuilder: (context, index) {
                  AppLog.info(controller.listImageAndAds.length);
                  // if (index == 0) {
                  //   return Padding(
                  //     padding: EdgeInsets.only(
                  //       top: 12.0.sp,
                  //       bottom: 12.0.sp,
                  //     ),
                  //     child: const HomeSlider(),
                  //   );
                  // }
                  if (index == 0) return const HomeLevel();
                  if (index == 1) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: AppTouchable(
                            height: 160.0.sp,
                            onPressed: controller.onPressCamera,
                            rippleColor: AppColor.transparent,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              color: AppColor.primaryColor,
                              dashPattern: const [8, 3],
                              radius: Radius.circular(20.0.sp),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.0.sp,
                                vertical: 24.0.sp,
                              ),
                              child: SizedBox(
                                width: Get.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppImageWidget.asset(
                                      path: AppImage.imgCamera,
                                      width: 52.0.sp,
                                      height: 52.0.sp,
                                    ),
                                    SizedBox(
                                      height: 6.0.sp,
                                    ),
                                    Text(
                                      StringConstants.camera.tr,
                                      textAlign: TextAlign.center,
                                      style: controller
                                          .context.textTheme.titleMedium
                                          ?.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.0.sp,
                        ),
                        Expanded(
                          flex: 5,
                          child: AppTouchable(
                            height: 160.0.sp,
                            onPressed: controller.onPressPhoto,
                            rippleColor: AppColor.transparent,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              color: AppColor.primaryColor,
                              dashPattern: const [8, 3],
                              radius: Radius.circular(20.0.sp),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.0.sp,
                                vertical: 24.0.sp,
                              ),
                              child: SizedBox(
                                width: Get.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppImageWidget.asset(
                                      path: AppImage.icImage,
                                      width: 52.0.sp,
                                      height: 52.0.sp,
                                    ),
                                    SizedBox(
                                      height: 6.0.sp,
                                    ),
                                    Text(
                                      StringConstants.photo.tr,
                                      textAlign: TextAlign.center,
                                      style: controller
                                          .context.textTheme.titleMedium
                                          ?.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.0.sp,
                        ),
                        Expanded(
                          flex: 4,
                          child: AppTouchable(
                            // width: Get.width,
                            height: 160.0.sp,
                            onPressed: controller.onPressAlbum,
                            radius: 20.0.sp,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(20.0.sp),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppImageWidget.asset(
                                  path: AppImage.icGallery,
                                  height: 52.sp,
                                  fit: BoxFit.fitHeight,
                                ),
                                Gap(6.0.sp),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    StringConstants.myAlbum.tr,
                                    textAlign: TextAlign.center,
                                    style: controller
                                        .context.textTheme.titleMedium
                                        ?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  // if (index == 2) {
                  //   return const HomeLevel();
                  // }

                  if (index > 2) {
                    return HomeLineCategory(
                      data: controller.listImageAndAds[index - 3]["data"] ?? [],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
