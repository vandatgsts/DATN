import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../resource/string/app_string.dart';
import '../../../utils/app_image.dart';
import '../../base/base_screen.dart';
import '../../theme/app_color.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_touchable.dart';
import '../how_to_use/how_to_use_screen.dart';
import 'preview_image_controller.dart';

class PreviewImageScreen extends BaseScreen<PreviewImageController> {
  const PreviewImageScreen({super.key});

  @override
  Widget buildWidgets() {
    return AppContainer(
      havePadding: false,
      child: Column(
        children: [
          AppHeader(
            title: "Ar Draw",
            rightWidget: AppTouchable(
              onPressed: () {
                Get.to(() => const HowToUseScreen());
              },
              padding: EdgeInsets.all(8.0.sp),
              child: SvgPicture.asset(
                AppImage.icTutorial,
                color: AppColor.primaryColor,
              ),
            ),
            shadowHeader: [
              BoxShadow(
                offset: const Offset(0, 0),
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6,
              )
            ],
          ),
          Expanded(
            child: Column(
              children: [
                const Spacer(),
                Center(
                  child: controller.imageUrl != null
                      ? AppImageWidget.network(
                          width: Get.width * 0.8,
                          height: Get.width * 0.8,
                          path: controller.imageUrl!,
                        )
                      : Image.memory(
                          controller.byteData!,
                          width: Get.width,
                          height: Get.height * 0.5,
                        ),
                ),
                const Spacer(),
                AppTouchable(
                  onPressed: controller.onPressContinue,
                  child: Container(
                    width: Get.width * 0.8,
                    height: Get.height * 0.08,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(16.0.sp),
                      color: AppColor.primaryColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringConstants.txtContinue.tr,
                          style: TextStyle(
                            fontFamily: "ShortStack",
                            fontSize: 20.0.sp,
                            color: AppColor.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
