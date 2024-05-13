import 'dart:math';

import 'package:ar_drawing/src/utils/app_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../domain/models/image_item.dart';
import '../../utils/app_image.dart';
import '../../utils/share_preference_utils.dart';
import '../app/app_controller.dart';
import '../router/app_router.dart';
import '../theme/app_color.dart';
import '../widget/app_container.dart';
import '../widget/app_header.dart';
import '../widget/app_network_image.dart';
import '../widget/app_touchable.dart';
import 'how_to_use/how_to_use_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String title;
  final List<ImageItem>? listData;

  const CategoryScreen({
    super.key,
    required this.title,
    required this.listData,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = false;
  late List<ImageItem> listImage;

  Future<void> _onPressItem(ImageItem imageItem, int index) async {
    if (!Get.find<AppController>().isPremium.value) {
      int cntClickItemCategory =
          PreferenceUtils.getInt("cnt_click_item_category") ?? 0;
      cntClickItemCategory++;
      AppLog.debug("cntClickItemCategory: $cntClickItemCategory");
      if (cntClickItemCategory % 5 == 0 && cntClickItemCategory != 0) {
        await Get.toNamed(AppRouter.subscriptionScreen);
      }
      PreferenceUtils.setInt("cnt_click_item_category", cntClickItemCategory);
    }

    _showLoading();

    // XFile? file = await downloadImageToXFile(imageUrl);
    //
    // Uint8List byteData = await file.readAsBytes();

    Get.toNamed(AppRouter.previewImage, arguments: {
      'image': imageItem.image,
      'byteData': null,
      'id': 'Data_${imageItem.id}',
    });

    _hideLoading();
  }

  void _showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  void _hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    listImage = (widget.listData?.toList() ?? []);
    listImage.removeWhere((element) => element.id == -1);
    List<ImageItem> listImageTemp = [];

    if (!Get.find<AppController>().isPremium.value) {
      for (int index = 0; index < (listImage ?? []).length; index++) {
        listImageTemp.add(listImage[index]);

        if (index % 4 == 3) {
          listImageTemp.add(ImageItem(id: -1));
        }
      }
      listImage = listImageTemp;
    }
  }

  @override
  void dispose() {
    listImage.removeWhere((element) => element.id == -1);
    super.dispose();
  }

  Widget _buildGridViewPremium() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.0.sp,
          crossAxisSpacing: 8.0.sp,
          childAspectRatio: 0.9,
        ),
        itemCount: min(5,listImage.length),
        padding: EdgeInsets.only(
          bottom: 12.0.sp,
        ),
        itemBuilder: (context, index) {
          return AppTouchable(
            onPressed: () async => _onPressItem(
              listImage[index],
              index,
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
                imageUrl: listImage[index].image,
                height: 140.0.sp,
                width: Get.width / 3,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGridViewNoPremium() {
    return Expanded(
      child: GridView.custom(
        shrinkWrap: true,
        padding: EdgeInsets.only(
          bottom: 12.0.sp,
        ),
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 2,
          mainAxisSpacing: 12.0.sp,
          crossAxisSpacing: 8.0.sp,
          repeatPattern: QuiltedGridRepeatPattern.same,
          pattern: [
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) {
            return AppTouchable(
              onPressed: () async => _onPressItem(
                listImage[index],
                index,
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
                  imageUrl: listImage[index].image,
                  height: 140.0.sp,
                  width: Get.width / 3,
                ),
              ),
            );
          },
          childCount: listImage.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AppContainer(
      havePadding: !_isLoading,
      child: Stack(
        children: [
          Column(
            children: [
              AppHeader(
                title: widget.title,
                rightWidget: AppTouchable(
                  onPressed: () {
                    Get.to(() => const HowToUseScreen());
                  },
                  width: 40.0.sp,
                  height: 40.0.sp,
                  padding: EdgeInsets.all(8.0.sp),
                  child: SvgPicture.asset(
                    AppImage.icTutorial,
                    width: 24.0.sp,
                    height: 24.0.sp,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
              _buildGridViewPremium(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
