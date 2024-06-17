import 'dart:math';

import 'package:ar_drawing/src/domain/models/image_item.dart';
import 'package:ar_drawing/src/resource/string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../theme/app_color.dart';
import '../../../widget/app_network_image.dart';
import '../../../widget/app_touchable.dart';
import '../../category_screen.dart';
import '../home_controller.dart';

class _Item extends StatelessWidget {
  final Function() onPressed;
  final String imageUrl;

  const _Item({
    Key? key,
    required this.onPressed,
    required this.imageUrl,
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
          height: 180.0.sp,
          width: 180.sp - 16.sp,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

class HomeLineCategory extends StatefulWidget {
  final List<ImageItem> data;

  const HomeLineCategory({
    super.key,
    required this.data,
  });

  @override
  State<HomeLineCategory> createState() => _HomeLineCategoryState();
}

class _HomeLineCategoryState extends State<HomeLineCategory>
    with AutomaticKeepAliveClientMixin {
  final HomeController _homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(12.0.sp),
        Row(
          children: [
            Text(
              widget.data[0].name?.capitalizeFirst ?? '',
              style: _homeController.context.textTheme.bodySmall?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16.0.sp,
              ),
            ),
            const Spacer(),
            AppTouchable(
              onPressed: () async {
                Get.to(()=>CategoryScreen(
                  title: widget.data[0].name ?? '',
                  listData: widget.data,
                ));
              },
              radius: 8.0.sp,
              padding: EdgeInsets.all(6.0.sp),
              child: Row(
                children: [
                  Text(
                    StringConstants.seeAll.tr,
                    style:
                        _homeController.context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0.sp,
                    ),
                  ),
                  Gap(4.0.sp),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12.0.sp,
                    color: AppColor.primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        Gap(8.0.sp),
        SizedBox(
          height: 180.0.sp,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: min(3, widget.data.length),
            itemBuilder: (context, index) {
              ImageItem? itemImage = widget.data[index];
              if (itemImage.id == -1) {
                return const SizedBox.shrink();
              }
              return _Item(
                onPressed: () {
                  ImageItem? itemImage = widget.data[index];
                  _homeController.onPressItem(
                    itemImage.image ?? '',
                    itemImage.id ?? 0,
                  );
                },
                imageUrl: widget.data[index].image ?? '',
              );
            },
          ),
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: _Item(
        //         onPressed: () {
        //           ImageItem? itemImage = widget.data[0];
        //           _homeController.onPressItem(
        //             itemImage.image ?? '',
        //             itemImage.id ?? 0,
        //           );
        //         },
        //         imageUrl: widget.data[0].image ?? '',
        //       ),
        //     ),
        //     Expanded(
        //       child: _Item(
        //         onPressed: () {
        //           ImageItem? itemImage = widget.data[1];
        //           _homeController.onPressItem(
        //             itemImage.image ?? '',
        //             itemImage.id ?? 0,
        //           );
        //         },
        //         imageUrl: widget.data[1].image ?? '',
        //       ),
        //     ),
        //     Expanded(
        //       child: _Item(
        //         onPressed: () {
        //           ImageItem? itemImage = widget.data[2];
        //           _homeController.onPressItem(
        //             itemImage.image ?? '',
        //             itemImage.id ?? 0,
        //           );
        //         },
        //         imageUrl: widget.data[2].image ?? '',
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
