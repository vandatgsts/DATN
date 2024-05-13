import 'package:ar_drawing/src/resource/string/app_string.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';


import '../../base/base_screen.dart';
import '../../theme/app_color.dart';
import '../../widget/app_container.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/dots_indicator/dots_indicator.dart';
import 'intro_controller.dart';

class IntroScreen extends BaseScreen<IntroController> {
  const IntroScreen({super.key});

  @override
  Widget buildWidgets() {
    return AppContainer(
      havePadding: false,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: CarouselSlider(
              items: controller.listContent.map((e) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: AppImageWidget.asset(
                        path: e['bg_image'] ?? '',
                        width: Get.width,
                        height: Get.height,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned.fill(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(
                              right: 16.sp,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Gap(MediaQuery.of(controller.context)
                                    .padding
                                    .top),
                                TextButton(
                                  onPressed: controller.onPressButtonNext,
                                  child: Text(
                                    StringConstants.next.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "ShortStack",
                                      fontSize: 18.0.sp,
                                      color: AppColor.white,
                                    ),
                                  ),
                                ),
                                Gap(280.0.sp),
                                Obx(
                                  () => DotsIndicator(
                                    dotsCount: controller.listContent.length,
                                    position: controller.currentIndex.value,
                                    decorator: DotsDecorator(
                                      size: Size(6.0.sp, 6.0.sp),
                                      activeSize: Size(16.0.sp, 6.0.sp),
                                      color: const Color(0xFF787878),
                                      spacing: EdgeInsets.symmetric(
                                        horizontal: 2.0.sp,
                                      ),
                                      activeShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.sp),
                                      ),
                                      activeColor: const Color(0xFF3A3A3A),
                                    ),
                                  ),
                                ),
                                Gap(24.0.sp),
                                Text(
                                  "${e['text_content1']} ${e['text_content2']}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0.sp,
                                    color: AppColor.textColor,
                                    fontFamily: "ShortStack",
                                  ),
                                ),
                                Text(
                                  e['text_content3'] ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0.sp,
                                    color: AppColor.textColor,
                                    fontFamily: "ShortStack",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
              carouselController: controller.carouselController,
              options: CarouselOptions(
                height: Get.height,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: false,
                enlargeCenterPage: false,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                pageSnapping: true,
                onPageChanged: (index, reason) {
                  controller.currentIndex.value = index;
                  controller.setColor();
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Obx(
            () => Positioned(
                top: Get.width * 1.05,
                left: 0.sp,
                right: 0.sp,
                child:
                    controller.mapNative["widget"] ?? const SizedBox.shrink()),
          ),
        ],
      ),
    );
  }
}
