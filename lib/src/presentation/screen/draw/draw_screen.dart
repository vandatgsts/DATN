import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';


import '../../../resource/string/app_string.dart';
import '../../../utils/app_image.dart';
import '../../../utils/app_utils.dart';
import '../../app/app_controller.dart';
import '../../base/base_screen.dart';
import '../../theme/app_color.dart';
import '../../theme/short_stack_text_theme.dart';
import '../../widget/app_button.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_touchable.dart';
import '../../widget/custom_track_slider.dart';
import '../camera_screen.dart';
import '../drag_area.dart';
import 'draw_controller.dart';

class DrawScreen extends BaseScreen<DrawController> {
  const DrawScreen({super.key});

  Widget _buildHeader() {
    double radius = 6.0.sp;

    return AppHeader(
      title: StringConstants.draw.tr,
      titleTextStyle: ShortStackTextTheme.titleMedium(
        AppColor.black,
      ),
      onPressBack: () async {
        if (Get.find<AppController>().isPremium.value) {
          Get.back();
          Get.back();
        } else {
          Get.back();
          Get.back();
        }
        await showRateDialog(controller.context);
      },
      radius: 5 * radius,
      paddingBottom: 16.0.sp,
      backgroundColor: Colors.white,
      rightWidget: AppTouchable(
        onPressed: controller.onPressHowToUse,
        width: 40.0.sp,
        height: 40.0.sp,
        padding: EdgeInsets.all(8.0.sp),
        margin: EdgeInsets.only(right: 12.sp),
        child: SvgPicture.asset(
          AppImage.icTutorial,
          width: 24.0.sp,
          height: 24.0.sp,
          color: AppColor.primaryColor,
        ),
      ),
      shadowHeader: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 10,
          offset: const Offset(0, 2),
        )
      ],
      extendWidget: Row(
        children: [
          Obx(() => controller.isTrace.value
              ? Gap(40.sp)
              : AppTouchable(
                  onPressed: controller.onPressFlash,
                  width: 40.0.sp,
                  height: 40.0.sp,
                  padding: EdgeInsets.all(2.0.sp),
                  margin: EdgeInsets.only(left: 12.sp),
                  child: controller.onFlash.value
                      ? SvgPicture.asset(
                          AppImage.icFlash,
                          width: 24.0.sp,
                          height: 24.0.sp,
                          color: Colors.orangeAccent,
                        )
                      : AppImageWidget.asset(
                          path: AppImage.icFlash,
                          width: 24.0.sp,
                          height: 24.0.sp,
                        ),
                )),
          const Spacer(),
          Obx(() => AppTouchable(
                onPressed: controller.onPressSketch,
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 18.0,
                ),
                radius: radius,
                decoration: BoxDecoration(
                  color: !controller.isTrace.value
                      ? AppColor.primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(
                    color: AppColor.primaryColor,
                    width: 1.0,
                  ),
                ),
                child: Text(
                  StringConstants.sketch.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    color: !controller.isTrace.value
                        ? Colors.white
                        : AppColor.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )),
          SizedBox(width: 12.0.sp),
          Obx(() => AppTouchable(
                onPressed: controller.onPressTrace,
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 18.0,
                ),
                radius: radius,
                decoration: BoxDecoration(
                  color: controller.isTrace.value
                      ? AppColor.primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(
                    color: AppColor.primaryColor,
                    width: 1.0,
                  ),
                ),
                child: Text(
                  StringConstants.trace.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    color: controller.isTrace.value
                        ? Colors.white
                        : AppColor.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )),
          const Spacer(),
          AppTouchable(
            onPressed: controller.onPressFavorite,
            width: 40.0.sp,
            height: 40.0.sp,
            padding: EdgeInsets.all(2.0.sp),
            margin: EdgeInsets.only(right: 12.sp),
            child: Obx(
              () => AppImageWidget.asset(
                path: controller.isFavorite.value
                    ? AppImage.icFavorite
                    : AppImage.icNoteFavorite,
                width: 24.0.sp,
                height: 24.0.sp,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _itemRowButton({
    required Function() onPressed,
    required String icPath,
    required String title,
    required int index,
  }) {
    return AppTouchable(
      onPressed: onPressed,
      radius: 8.0.sp,
      padding: EdgeInsets.symmetric(horizontal: 2.0.sp, vertical: 6.sp),
      margin: EdgeInsets.symmetric(horizontal: 4.sp),
      child: Column(
        children: [
          SvgPicture.asset(
            icPath,
            width: 24.0.sp,
            height: 24.0.sp,
            color: controller.currentIndex.value == index
                ? AppColor.primaryColor
                : AppColor.borderColor,
          ),
          SizedBox(
            height: 4.0.sp,
          ),
          Text(
            title,
            style: controller.context.textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: controller.currentIndex.value == index
                  ? AppColor.primaryColor
                  : AppColor.borderColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _option() {
    return Container(
      height: 180.sp,
      padding: EdgeInsets.only(
        top: 10.sp,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.sp),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: controller.currentIndex.value == 1
          ? _optionTools()
          : controller.currentIndex.value == 2
              ? _optionPhoto()
              : _optionRecord(),
    );
  }

  Widget _optionTools() {
    return Column(
      children: [
        Row(
          children: [
            Gap(28.sp),
            SizedBox(
              width: Get.width - 72.sp - 250.sp - 28.sp,
              child: FittedBox(
                alignment: Alignment.bottomLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  StringConstants.style.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.textColor,
                  ),
                ),
              ),
            ),
            Gap(27.sp),
            Obx(
              () => AppTouchable(
                onPressed: () => controller.isStroke.value = true,
                padding: EdgeInsets.symmetric(
                  vertical: 6.sp,
                  horizontal: 30.sp,
                ),
                radius: 8.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: controller.isStroke.value
                      ? AppColor.primaryColor
                      : Colors.white,
                  border: Border.all(
                    color: AppColor.primaryColor,
                    width: 0.5.sp,
                  ),
                ),
                child: Text(
                  StringConstants.stroke.tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: !controller.isStroke.value
                        ? AppColor.textColor
                        : Colors.white,
                  ),
                ),
              ),
            ),
            Gap(5.sp),
            Obx(
              () => AppTouchable(
                onPressed: () => controller.isStroke.value = false,
                padding: EdgeInsets.symmetric(
                  vertical: 6.sp,
                  horizontal: 30.sp,
                ),
                radius: 8.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: !controller.isStroke.value
                      ? AppColor.primaryColor
                      : Colors.white,
                  border: Border.all(
                    color: AppColor.primaryColor,
                    width: 0.5.sp,
                  ),
                ),
                child: Text(
                  StringConstants.original.tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: controller.isStroke.value
                        ? AppColor.textColor
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        Gap(10.sp),
        const Spacer(),
        Row(
          children: [
            Gap(28.sp),
            SizedBox(
              width: Get.width - 72.sp - 250.sp - 28.sp,
              child: FittedBox(
                alignment: Alignment.bottomLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  StringConstants.opacity.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.textColor,
                  ),
                ),
              ),
            ),
            Gap(27.sp),
            Obx(
              () => SizedBox(
                  width: 250.sp,
                  height: 20.sp,
                  child: SliderTheme(
                    data: SliderTheme.of(controller.context).copyWith(
                      trackHeight: 2.0,
                      // Đặt độ dày của thanh trượt tại đây
                      trackShape: CustomTrackShape(),
                    ),
                    child: Slider(
                      thumbColor: AppColor.primaryColor,
                      onChanged: (double value) {
                        controller.opacity.value = value;
                      },
                      inactiveColor: const Color(0xFFD9D9D9),
                      activeColor: const Color(0xFFD9D9D9),
                      value: controller.opacity.value,
                    ),
                  )),
            ),
          ],
        ),
        Gap(10.sp),
        Obx(
          () => controller.isStroke.value
              ? Row(
                  children: [
                    Gap(28.sp),
                    SizedBox(
                      width: Get.width - 72.sp - 250.sp - 28.sp,
                      child: FittedBox(
                        alignment: Alignment.bottomLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          StringConstants.edgeLevel.tr,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColor.textColor,
                          ),
                        ),
                      ),
                    ),
                    Gap(27.sp),
                    Obx(
                      () => SizedBox(
                          width: 250.sp,
                          height: 20.sp,
                          child: SliderTheme(
                            data: SliderTheme.of(controller.context).copyWith(
                              trackHeight: 2.0,
                              // Đặt độ dày của thanh trượt tại đây
                              trackShape: CustomTrackShape(),
                            ),
                            child: Slider(
                              thumbColor: AppColor.primaryColor,
                              onChangeEnd: (double value) {
                                controller.onChangeEdgeLevel();
                              },
                              inactiveColor: const Color(0xFFD9D9D9),
                              activeColor: const Color(0xFFD9D9D9),
                              value: controller.edgeLV.value,
                              onChanged: (double value) {
                                controller.edgeLV.value = value;
                              },
                            ),
                          )),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
        Gap(10.sp),
        Obx(
          () => controller.isStroke.value
              ? Row(
                  children: [
                    Gap(28.sp),
                    SizedBox(
                      width: Get.width - 72.sp - 250.sp - 28.sp,
                      child: FittedBox(
                        alignment: Alignment.bottomLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          StringConstants.noise.tr,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColor.textColor,
                          ),
                        ),
                      ),
                    ),
                    Gap(27.sp),
                    Obx(
                      () => SizedBox(
                          width: 250.sp,
                          height: 20.sp,
                          child: SliderTheme(
                            data: SliderTheme.of(controller.context).copyWith(
                              trackHeight: 2.0,
                              // Đặt độ dày của thanh trượt tại đây
                              trackShape: CustomTrackShape(),
                            ),
                            child: Slider(
                              thumbColor: AppColor.primaryColor,
                              onChangeEnd: (double value) {
                                controller.onChangeNoise();
                              },
                              inactiveColor: const Color(0xFFD9D9D9),
                              activeColor: const Color(0xFFD9D9D9),
                              value: controller.noise.value,
                              onChanged: (double value) {
                                controller.noise.value = value;
                              },
                            ),
                          )),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _optionPhoto() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '',
          style: controller.context.textTheme.bodyMedium
              ?.copyWith(color: AppColor.textColor),
        ),
        Gap(3.sp),
        AppButton(
          onTap: controller.onPressTakeAPhoto,
          shapeBorder: const CircleBorder(),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD9D9D9),
            ),
            margin: EdgeInsets.all(6.sp),
            child: Container(
              height: 58.sp,
              width: 58.sp,
              margin: EdgeInsets.all(10.sp),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.textColor,
              ),
            ),
          ),
        ),
        Gap(10.0.sp),
      ],
    );
  }

  Widget _optionRecord() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => Text(
            controller.formatTime(controller.start.value),
            style: controller.context.textTheme.bodyMedium
                ?.copyWith(color: AppColor.textColor),
          ),
        ),
        Gap(3.sp),
        AppTouchable(
          onPressed: controller.onPressStartRecord,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFD9D9D9),
          ),
          child: Container(
            height: 58.sp,
            width: 58.sp,
            margin: EdgeInsets.all(10.sp),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.textColor,
            ),
            child: Obx(() {
              if (controller.recording.value) {
                return Center(
                  child: Icon(
                    Icons.pause,
                    size: 24.0.sp,
                    color: Colors.white,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ),
        ),
        Gap(10.0.sp),
      ],
    );
  }

  Widget _bottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: controller.isExtendOption.value
            ? null
            : BorderRadius.only(
                topRight: Radius.circular(16.0.sp),
                topLeft: Radius.circular(16.0.sp),
              ),
      ),
      padding: EdgeInsets.only(
        top: 16.0.sp,
        bottom: 8.0.sp,
        left: 4.sp,
        right: 4.sp,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.bottomCenter,
                child: _itemRowButton(
                  icPath: AppImage.icTool,
                  title: StringConstants.tools.tr,
                  onPressed: controller.onPressTool,
                  index: 1,
                ),
              ),
            ),
          ),
          Obx(
            () => controller.isTrace.value
                ? const SizedBox.shrink()
                : Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.bottomCenter,
                      child: _itemRowButton(
                        icPath: AppImage.icPhoto,
                        title: StringConstants.photo.tr,
                        onPressed: controller.onPressPhoto,
                        index: 2,
                      ),
                    ),
                  ),
          ),
          Obx(
            () => controller.isTrace.value
                ? const SizedBox.shrink()
                : Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.bottomCenter,
                      child: _itemRowButton(
                        icPath: AppImage.icVideo,
                        title: StringConstants.record.tr,
                        onPressed: controller.onPressRecord,
                        index: 3,
                      ),
                    ),
                  ),
          ),
          Obx(
            () => Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.bottomCenter,
                child: _itemRowButton(
                  icPath: AppImage.icPrinter,
                  title: StringConstants.print.tr,
                  onPressed: controller.onPressPrint,
                  index: 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildWidgets() {
    return AppContainer(
      havePadding: false,
      child: Stack(
        children: [
          Positioned.fill(
            child: Obx(
              () => !controller.isTrace.value
                  ? CameraScreen(
                      key: controller.globalKey,
                    )
                  : Container(
                      color: Colors.white,
                    ),
            ),
          ),
          Obx(
            () {
              if (controller.byteData.value.isNotEmpty) {
                return Container(
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: controller.opacity.value,
                    child: DragArea(
                      child: Image.memory(
                        controller.isStroke.value
                            ? controller.byteData.value
                            : controller.originByteData.value,
                        width: Get.width,
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          Positioned.fill(
            child: Obx(
              () => controller.isExpansion.value
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        _buildHeader(),
                        const Spacer(),
                        Gap(10.sp),
                        Obx(() => _option()),
                        Obx(() => _bottomNavigation()),
                        
                      ],
                    ),
            ),
          ),
          Obx(
            () => Positioned(
              right: 15.sp,
              bottom: MediaQuery.of(controller.context).padding.bottom +
                  280.sp / (!controller.isExpansion.value ? 1 : 2),
              child: controller.currentIndex.value == 1
                  ? AppTouchable(
                      onPressed: () => controller.isExpansion.value =
                          !controller.isExpansion.value,
                      child: SvgPicture.asset(
                        !controller.isExpansion.value
                            ? AppImage.icExpansion
                            : AppImage.icNoExpansion,
                        height: 24.sp,
                        width: 24.sp,
                        color: AppColor.primaryColor,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          )
        ],
      ),
    );
  }
}
