

import 'package:ar_drawing/src/presentation/base/base_screen.dart';
import 'package:ar_drawing/src/presentation/screen/language/language_controller.dart';
import 'package:ar_drawing/src/presentation/widget/app_container.dart';
import 'package:ar_drawing/src/presentation/widget/app_header.dart';
import 'package:ar_drawing/src/presentation/widget/app_image_widget.dart';
import 'package:ar_drawing/src/presentation/widget/app_touchable.dart';
import 'package:ar_drawing/src/resource/string/app_string.dart';
import 'package:ar_drawing/src/utils/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/app_color.dart';

class LanguageScreen extends BaseScreen<LanguageController> {
  const LanguageScreen({super.key});

  @override
  Widget buildWidgets() {
    return AppContainer(
      child: Column(
        children: [
          Obx(() => AppHeader(
                leftWidget:
                    controller.isShowBack.value ? null : SizedBox(width: 40.sp),
                onPressBack: controller.onPressBack,
                title: StringConstants.language.tr,
                rightWidget: AppTouchable(
                  onPressed: controller.onPressConfirm,
                  padding: EdgeInsets.all(5.0.sp),
                  margin: EdgeInsets.only(right: 10.sp),
                  child: AppImageWidget.asset(path: AppImage.iconTick),
                ),
              )),
          Expanded(
            child: ListView.builder(
              itemCount: controller.listLanguage.length,
              padding: EdgeInsets.only(
                top: 0,
                bottom: 0.sp,
                left: 12.0.sp,
                right: 12.0.sp,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Map map = controller.listLanguage[index];
                if (index % 4 == 3 &&
                    index != controller.listLanguage.length - 1) {
                  return Column(
                    children: [
                      Obx(
                        () => AppTouchable(
                          onPressed: () {
                            controller.selectLanguage(index);
                          },
                          margin: EdgeInsets.symmetric(
                            vertical: 10.0.sp,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 16.0.sp,
                            horizontal: 20.0.sp,
                          ),
                          radius: 16.0.sp,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              width: 1,
                              color: controller.selectIndex.value == index
                                  ? AppColor.primaryColor
                                  : const Color(0xFFDEDEDE),
                            ),
                            borderRadius: BorderRadius.circular(16.0.sp),
                          ),
                          child: Row(
                            children: [
                              AppImageWidget.asset(
                                path: map["image"],
                                width: 40.0.sp,
                              ),
                              SizedBox(
                                width: 12.0.sp,
                              ),
                              Expanded(
                                child: Text(
                                  map["name"],
                                  style: TextStyle(
                                    color: const Color(0xFF565656),
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Obx(() => controller.selectIndex.value == index
                                  ? AppImageWidget.asset(
                                      path: AppImage.iconTick,
                                      width: 16.sp,
                                      height: 16.sp,
                                    )
                                  : const SizedBox.shrink())
                            ],
                          ),
                        ),
                      ),

                    ],
                  );
                }
                return Obx(
                  () => AppTouchable(
                    onPressed: () {
                      controller.selectLanguage(index);
                    },
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0.sp,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0.sp,
                      horizontal: 20.0.sp,
                    ),
                    radius: 16.0.sp,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        width: 1,
                        color: controller.selectIndex.value == index
                            ? AppColor.primaryColor
                            : const Color(0xFFDEDEDE),
                      ),
                      borderRadius: BorderRadius.circular(16.0.sp),
                    ),
                    child: Row(
                      children: [
                        AppImageWidget.asset(
                          path: map["image"],
                          width: 40.0.sp,
                        ),
                        SizedBox(
                          width: 12.0.sp,
                        ),
                        Expanded(
                          child: Text(
                            map["name"],
                            style: TextStyle(
                              color: const Color(0xFF565656),
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Obx(() => controller.selectIndex.value == index
                            ? AppImageWidget.asset(
                                path: AppImage.iconTick,
                                width: 16.sp,
                                height: 16.sp,
                              )
                            : const SizedBox.shrink())
                      ],
                    ),
                  ),
                );
                // if (map["type"] == "item") {
                //
                //   return AppTouchable(
                //     onPressed: () {
                //       scrollController.animateTo(92.sp * index,
                //           duration: const Duration(milliseconds: 500),
                //           curve: Curves.bounceInOut);
                //       controller.selectLanguage(index);
                //     },
                //     margin: EdgeInsets.symmetric(
                //       vertical: 10.0.sp,
                //     ),
                //     padding: EdgeInsets.symmetric(
                //       vertical: 16.0.sp,
                //       horizontal: 20.0.sp,
                //     ),
                //     radius: 16.0.sp,
                //     decoration: BoxDecoration(
                //       color: context.theme.colorScheme.background,
                //       shape: BoxShape.rectangle,
                //       boxShadow: [
                //         BoxShadow(
                //           offset: const Offset(0, 0),
                //           blurRadius: 6,
                //           color: context.theme.colorScheme.shadow,
                //         )
                //       ],
                //       borderRadius: BorderRadius.circular(16.0.sp),
                //     ),
                //     child: Row(
                //       children: [
                //         AppImageWidget.asset(
                //           path: languageModel.icPath,
                //           width: 40.0.sp,
                //         ),
                //         SizedBox(
                //           width: 12.0.sp,
                //         ),
                //         Expanded(
                //           child: Text(
                //             languageModel.name,
                //             style:
                //             AppTextTheme.headlineMedium(AppColor.black)
                //                 ?.copyWith(
                //               fontSize: 16.0.sp,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //         ),
                //         Container(
                //           width: 24.0.sp,
                //           height: 24.0.sp,
                //           decoration: BoxDecoration(
                //             color: AppColor.transparent,
                //             shape: BoxShape.circle,
                //             border: Border.all(
                //               color: context.theme.primaryColor,
                //               width: 2.0.sp,
                //             ),
                //           ),
                //           child: Obx(
                //                 () => Container(
                //               margin: EdgeInsets.all(2.0.sp),
                //               decoration: BoxDecoration(
                //                 color: controller.selectIndex.value == index
                //                     ? context.theme.primaryColor
                //                     : AppColor.transparent,
                //                 shape: BoxShape.circle,
                //               ),
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //   );
                // } else {
                //   // return const NativeSmallAdsWidget();
                //   return const SizedBox.shrink();
                // }
              },
            ),
          ),
        ],
      ),
    );
  }
}
