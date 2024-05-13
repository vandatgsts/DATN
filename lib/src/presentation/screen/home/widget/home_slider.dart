
import 'package:ar_drawing/src/resource/string/app_string.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_image.dart';
import '../../../theme/app_color.dart';
import '../../../theme/short_stack_text_theme.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/app_touchable.dart';
import '../home_controller.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider>
    with AutomaticKeepAliveClientMixin {
  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              _homeController.onPageChange(index);
            },
            aspectRatio: 390.5 / 182,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayInterval: const Duration(milliseconds: 4500),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
          ),
          items: _homeController.listImagePath.map(
            (item) {

              return Stack(
                children: [
                  AppImageWidget.asset(
                    path: item['img_path'] ?? AppImage.banner1,
                  ),
                  Obx(
                    () => Positioned(
                      left: 8.0.sp,
                      top: 28.0.sp,
                      child: Text(
                        item['title'] ?? '',
                        style: ShortStackTextTheme.bodyMedium(
                          _homeController.textColor.value,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12.0.sp,
                    bottom: 32.0.sp,
                    child: Obx(
                      () => AppTouchable(
                        onPressed: _homeController.onPressLetStart,
                        backgroundColor: _homeController.buttonColor.value,
                        radius: 8.0.sp,
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0.sp,
                          vertical: 10.0.sp,
                        ),
                        child: Text(
                          StringConstants.letStart.tr,
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            fontFamily: "ShortStack",
                            color: _homeController.buttonTextColor.value,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ).toList(),
        ),
        Obx(
          () => DotsIndicator(
            position: _homeController.page.value,
            dotsCount: _homeController.listImagePath.length,
            mainAxisAlignment: MainAxisAlignment.center,
            decorator: DotsDecorator(
              color: AppColor.gray9D9,
              size: const Size.square(8.0),
              activeSize: const Size(24.0, 8.0),
              activeColor: AppColor.primaryColor,
              spacing: EdgeInsets.only(
                right: 6.0.sp,
              ),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
