import 'package:ar_drawing/src/presentation/widget/app_image_widget.dart';
import 'package:ar_drawing/src/resource/string/app_string.dart';
import 'package:ar_drawing/src/utils/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../widget/app_touchable.dart';
import '../home_controller.dart';

class _LevelItem extends StatelessWidget {
  final Function() onPressed;
  final String imgUrl, level;
  final BuildContext context;

  const _LevelItem({
    Key? key,
    required this.context,
    required this.onPressed,
    required this.imgUrl,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTouchable(
          width: Get.width / 3,
          onPressed: onPressed,
          margin: EdgeInsets.symmetric(
            horizontal: 4.0.sp,
          ),
          padding: EdgeInsets.all(8.0.sp),
          radius: 12.0.sp,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0.sp),
            shape: BoxShape.rectangle,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.1),
            //     offset: const Offset(0, 4),
            //     blurRadius: 6,
            //   )
            // ],
          ),
          child: Column(
            children: [
              AppImageWidget.asset(
                path: imgUrl,
                height: 120.0.sp,
                width: Get.width / 5,
              ),
            ],
          ),
        ),
        Gap(8.0.sp),
        Text(
          level,
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16.0.sp,
          ),
        ),
      ],
    );
  }
}

class HomeLevel extends StatefulWidget {
  const HomeLevel({super.key});

  @override
  State<HomeLevel> createState() => _HomeLevelState();
}

class _HomeLevelState extends State<HomeLevel>
    with AutomaticKeepAliveClientMixin {
  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(16.sp),
            Row(
              children: [
                Text(
                  StringConstants.level.tr,
                  style: _homeController.context.textTheme.bodySmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0.sp,
                  ),
                ),
              ],
            ),
            Gap(8.0.sp),
            Row(
              children: [
                _homeController.listEasy.isEmpty
                    ? const SizedBox.shrink()
                    : Expanded(
                        child: _LevelItem(
                          context: _homeController.context,
                          onPressed: _homeController.onPressLevelEasy,
                          imgUrl: AppImage.imgEasy,
                          level: StringConstants.beginner.tr,
                        ),
                      ),
                _homeController.listMedium.isEmpty
                    ? const SizedBox.shrink()
                    : Expanded(
                        child: _LevelItem(
                          context: _homeController.context,
                          onPressed: _homeController.onPressLevelMedium,
                          imgUrl: AppImage.imgMedium,
                          level: StringConstants.intermediate.tr,
                        ),
                      ),
                _homeController.listHard.isEmpty
                    ? const SizedBox.shrink()
                    : Expanded(
                        child: _LevelItem(
                          context: _homeController.context,
                          onPressed: _homeController.onPressLevelHard,
                          imgUrl: AppImage.imgDifficult,
                          level: StringConstants.advanced.tr,
                        ),
                      ),
              ],
            ),
            Gap(16.sp),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
