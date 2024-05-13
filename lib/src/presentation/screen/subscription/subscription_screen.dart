import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../resource/string/app_string.dart';
import '../../../utils/app_image.dart';
import '../../../utils/disable_glow_behavior.dart';
import '../../base/base_screen.dart';
import '../../theme/app_color.dart';
import '../../theme/short_stack_text_theme.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_touchable.dart';
import '../../widget/shake_animation.dart';
import 'subscription_controller.dart';

class SubscriptionScreen extends BaseScreen<SubscriptionController> {
  const SubscriptionScreen({super.key});

  Widget _rowSub(String text) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(5.sp),
              decoration: const BoxDecoration(
                color: Color(0xFFFFE8EA),
                shape: BoxShape.circle,
              ),
              child: AppImageWidget.asset(
                path: AppImage.icTick,
                height: 10.sp,
              ),
            ),
            Gap(8.sp),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  textAlign: TextAlign.start,
                  style: ShortStackTextTheme.bodyMedium(AppColor.textColor)?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            )
          ],
        ),
        Gap(12.sp),
      ],
    );
  }

  Widget _typeSubButton({
    required String title,
    required Function() onPressed,
    required bool isChoose,
    required ProductDetails productDetails,
    String? contentSave,
    String? contentBottomPrice,
    ProductDetails? productDetailsTemp,
  }) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        AppTouchable(
          onPressed: onPressed,
          padding: EdgeInsets.symmetric(
            vertical: 10.sp,
            horizontal: 28.sp,
          ),
          radius: 16.0.sp,
          margin: EdgeInsets.only(
            left: 24.sp,
            top: 12.sp,
            right: 24.sp,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: isChoose ? AppColor.secondaryColor : AppColor.transparent,
              width: 1.5.sp,
            ),
            borderRadius: BorderRadius.circular(16.sp),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Text(
                title,
                style: ShortStackTextTheme.bodyMedium(AppColor.textColor)?.copyWith(
                  color: AppColor.textSubColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      productDetailsTemp != null
                          ? Text(
                              productDetailsTemp.price,
                              style: TextStyle(
                                color: const Color(0xFF323232),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.black,
                                // Màu của đường gạch ngang, bạn có thể thay đổi nó
                                decorationThickness: 2,
                              ),
                            )
                          : const SizedBox.shrink(),
                      Gap(10.sp),
                      Text(
                        productDetails.price,
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: const Color(0xFF323232),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  contentBottomPrice != null
                      ? Text(
                          contentBottomPrice,
                          textAlign: TextAlign.center,
                          style: ShortStackTextTheme.bodyMedium(AppColor.textColor)?.copyWith(
                            fontSize: 10.sp,
                            color: const Color(0xFF323232),
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              )
            ],
          ),
        ),
        Positioned(
          left: 54.sp,
          top: 4.0.sp,
          child: contentSave != null
              ? Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.sp,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B00),
                    borderRadius: BorderRadius.circular(32.sp),
                  ),
                  child: Text(
                    contentSave,
                    style: ShortStackTextTheme.bodyMedium(AppColor.textColor)?.copyWith(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  @override
  Widget buildWidgets() {
    return AppContainer(
      child: Column(
        children: [
          Gap(16.sp),
          AppHeader(
            middleWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ar Draw",
                  style: ShortStackTextTheme.bodyMedium(AppColor.textColor)?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gap(4.sp),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.sp),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFF5064),
                        Color(0xFF753A88),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.sp,
                    vertical: 4.sp,
                  ),
                  child: Text(
                    StringConstants.pro.tr.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            leftWidget: Obx(
              () => controller.showClose.value
                  ? AppTouchable(
                      width: 40.0.sp,
                      height: 40.0.sp,
                      onPressed: Get.back,
                      child: const Icon(
                        Icons.close,
                        color: Color(0xFFB5B5B5),
                      ),
                    )
                  : SizedBox(
                      width: 40.0.sp,
                      height: 40.0.sp,
                    ),
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: DisableGlowBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppImageWidget.asset(path: AppImage.imgSetting),
                    Gap(20.sp),
                    Container(
                      margin: EdgeInsets.only(left: 16.sp),
                      child: Column(
                        children: [
                          _rowSub(StringConstants.subContent1.tr),
                          _rowSub(StringConstants.subContent2.tr),
                          _rowSub(StringConstants.subContent3.tr),
                          _rowSub(StringConstants.subContent4.tr),
                        ],
                      ),
                    ),
                    Obx(
                      () => _typeSubButton(
                        title: StringConstants.yearly.tr,
                        isChoose: controller.yearSelected.value,
                        contentBottomPrice:
                            "${StringConstants.only.tr} ${(controller.productDetailsYear.rawPrice / 48).toStringAsFixed(2)}/${StringConstants.week.tr}",
                        onPressed: controller.onPressYearly,
                        productDetails: controller.productDetailsYear,
                        contentSave: StringConstants.bestSeller.tr,
                        productDetailsTemp: controller.productDetailsTemp,
                      ),
                    ),
                    Gap(12.sp),
                    Obx(
                      () => _typeSubButton(
                        title: StringConstants.monthly.tr,
                        isChoose: controller.monthSelected.value,
                        contentBottomPrice:
                            "${StringConstants.only.tr} ${(controller.productDetailsMonth.rawPrice / 4).toStringAsFixed(2)}/${StringConstants.week.tr}",
                        onPressed: controller.onPressMonthly,
                        productDetails: controller.productDetailsMonth,
                        contentSave: " ${StringConstants.save.tr}  ${controller.saveValue.value}%",
                      ),
                    ),
                    Obx(
                      () => _typeSubButton(
                        title: StringConstants.weekly.tr,
                        isChoose: controller.weekSelected.value,
                        onPressed: controller.onPressWeekly,
                        productDetails: controller.productDetailsWeek,
                      ),
                    ),
                    Gap(8.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImage.icSecurity,
                          height: 16.sp,
                        ),
                        Gap(10.sp),
                        Text(
                          StringConstants.security.tr,
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    Gap(8.sp),
                    ShakeWidget(
                      shakeOffset: 10.0.sp,
                      child: AppTouchable(
                        onPressed: () async => controller.onPressBuy(),
                        child: Container(
                          width: Get.width * 0.8,
                          height: Get.height * 0.07,
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
                                  fontSize: 21.0.sp,
                                  fontFamily: "ShortStack",
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
                    //   child: Text(
                    //     "This subscription automatically renews for ${controller.productDetailsWeek.price}/week, ${controller.productDetailsMonth.price}/month and ${controller.productDetailsYear.price}/year"
                    //     ", you can cancel it anytime. "
                    //     "Payment will be charged to your Google Play account at the confirmation of purchase. "
                    //     "Subscription automatically renews unless it is canceled at least 24 hours before the end of "
                    //     "the current period. You can manage and cancel your subscriptions by going to your account "
                    //     "settings on the GooglePlay after purchase. Any unused part or time-span of a free trial "
                    //     "period will be forfeited, as soon as you purchase a subscriptions.",
                    //     textAlign: TextAlign.justify,
                    //     textScaleFactor: 1,
                    //     style: TextStyle(
                    //       fontSize: 10.0.sp,
                    //       fontWeight: FontWeight.w300,
                    //       color: AppColor.textColor,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 12.0.sp),
                    Row(
                      children: [
                        SizedBox(width: 12.0.sp),
                        AppTouchable(
                          onPressed: controller.onPressPrivacy,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0.sp,
                            vertical: 6.0.sp,
                          ),
                          child: Text(
                            StringConstants.privacyPolicy.tr,
                            style: TextStyle(
                              color: const Color(0xFF6D6D6D),
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const Spacer(),
                        AppTouchable(
                          onPressed: controller.onPressTerm,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0.sp,
                            vertical: 6.0.sp,
                          ),
                          child: Text(
                            StringConstants.termsOfService.tr,
                            style: TextStyle(
                                color: const Color(0xFF6D6D6D),
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        SizedBox(width: 12.0.sp),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.01),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
