import 'package:ar_drawing/src/presentation/screen/home/home_controller.dart';
import 'package:ar_drawing/src/presentation/widget/app_touchable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../domain/models/image_item.dart';
import '../../resource/string/app_string.dart';
import '../theme/app_color.dart';
import '../widget/app_network_image.dart';

class _Item extends StatelessWidget {
  final Function() onPressed;
  final String imageUrl;
  final bool isSelected;

  const _Item({
    Key? key,
    required this.onPressed,
    required this.imageUrl,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      onPressed: onPressed,
      margin: EdgeInsets.symmetric(
        horizontal: 4.0.sp,
      ),
      radius: 12.0.sp,
      padding: EdgeInsets.all(8.0.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0.sp),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: isSelected ? AppColor.primaryColor : Colors.white,
          width: 1.5.sp,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 6,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0.sp),
        child: AppNetworkImage(
          imageUrl: imageUrl,
          height: 140.0.sp,
          width: Get.width / 3,
        ),
      ),
    );
  }
}

class DialogLetStart extends GetView<HomeController> {
  final List<int> values;
  final int indexList;

  const DialogLetStart({
    super.key,
    required this.values,
    required this.indexList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppTouchable(
              onPressed: Get.back,
              child: Icon(
                Icons.close,
                color: const Color(0xFFB5B5B5),
                size: 24.sp,
              ),
            )
          ],
        ),
        Text(
          StringConstants.choosePhoto.tr,
          style: TextStyle(
            color: AppColor.textColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            fontFamily: 'ShortStack',
          ),
        ),
        Text(
          StringConstants.choosePhotoWarning.tr,
          textAlign: TextAlign.center,
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 14.sp,
            color: AppColor.textColor,
          ),
        ),
        Gap(10.sp),
        Row(
          children: [
            Obx(
              () => _Item(
                onPressed: () =>
                    controller.itemDialogSelected.value = values[0],
                imageUrl:
                    controller.listImage[indexList]?[values[0]].image ?? " ",
                isSelected: controller.itemDialogSelected.value == values[0],
              ),
            ),
            Obx(
              () => _Item(
                onPressed: () =>
                    controller.itemDialogSelected.value = values[1],
                imageUrl:
                    controller.listImage[indexList]?[values[1]].image ?? " ",
                isSelected: controller.itemDialogSelected.value == values[1],
              ),
            ),
          ],
        ),
        Gap(10.sp),
        Row(
          children: [
            Obx(
              () => _Item(
                onPressed: () =>
                    controller.itemDialogSelected.value = values[2],
                imageUrl:
                    controller.listImage[indexList]?[values[2]].image ?? " ",
                isSelected: controller.itemDialogSelected.value == values[2],
              ),
            ),
            Obx(
              () => _Item(
                onPressed: () =>
                    controller.itemDialogSelected.value = values[3],
                imageUrl:
                    controller.listImage[indexList]?[values[3]].image ?? " ",
                isSelected: controller.itemDialogSelected.value == values[3],
              ),
            ),
          ],
        ),
        Gap(36.sp),
        AppTouchable(
          onPressed: () {
            ImageItem itemImage = controller
                .listImage[indexList]![controller.itemDialogSelected.value];
            Get.back();
            controller.onPressItem(itemImage.image ?? '', itemImage.id ?? 0);
          },
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
                    fontSize: 20.0.sp,
                    color: AppColor.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(5.sp),
      ],
    );
  }
}
