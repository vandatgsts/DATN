import 'dart:typed_data';

import 'package:ar_drawing/src/data/model/favorite_item.dart';
import 'package:ar_drawing/src/data/service/database_helper.dart';
import 'package:ar_drawing/src/resource/string/app_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/app_image.dart';
import '../../base/base_screen.dart';
import '../../theme/app_color.dart';
import '../../theme/short_stack_text_theme.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_touchable.dart';
import 'album_controller.dart';

class AlbumScreen extends BaseScreen<AlbumController> {
  const AlbumScreen({super.key});

  void _showDialogApply(String id) {
    showDialog(
      context: controller.context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            "Delete?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () async {
                Navigator.of(context).pop();
                await DatabaseHelper.instance.deleteFavoriteItem(id);
                controller.listAlbum.value =
                    await DatabaseHelper.instance.fetchAllFavoriteItems();
              },
              isDefaultAction: true,
              child: Text('Confirm'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showDialogUpdateFavorite(FavoriteItem item) {
    showDialog(
      context: controller.context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            "Delete?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () async {
                item.isFavorite = false;
                Navigator.of(context).pop();
                await DatabaseHelper.instance.updateFavoriteItem(item);
                controller.listFavorite.value =
                    await DatabaseHelper.instance.fetchFavoriteItems();
              },
              isDefaultAction: true,
              child: Text('Confirm'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildWidgets() {
    return AppContainer(
      havePadding: false,
      child: Column(
        children: [
          AppHeader(
            title: StringConstants.album.tr,
            titleTextStyle: ShortStackTextTheme.titleMedium(
              AppColor.black,
            ),
            onPressBack: controller.onPressBack,
            rightWidget: AppTouchable(
              onPressed: controller.onPressHowToUse,
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
          TabBar(
            controller: controller.tabController,
            tabs: [
              Tab(text: "Favorite".tr),
              Tab(text: "Your Image".tr),
            ],
            indicatorColor: AppColor.primaryColor,
            labelColor: AppColor.primaryColor,
            unselectedLabelColor: Colors.grey,
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                _buildFavoriteTab(),
                _buildYourImageTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteTab() {
    return Obx(
      () => controller.listFavorite.isEmpty
          ? _buildNoDataWidget()
          : _buildGridView(controller.listFavorite, 1),
    );
  }

  Widget _buildYourImageTab() {
    return Obx(
      () => controller.listAlbum.isEmpty
          ? _buildNoDataWidget()
          : _buildGridView(controller.listAlbum, 2),
    );
  }

  Widget _buildNoDataWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppImageWidget.asset(
          path: AppImage.noData,
          width: 240.0.sp,
          height: 240.0.sp,
        ),
        Text(
          StringConstants.noData.tr,
          style: controller.context.textTheme.headlineMedium?.copyWith(
            color: const Color(0xFFACACAC),
            fontWeight: FontWeight.w500,
            fontSize: 20.0.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildGridView(List<FavoriteItem> list, int type) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12.0.sp,
        crossAxisSpacing: 8.0.sp,
      ),
      itemCount: list.length,
      padding: EdgeInsets.only(
        bottom: 12.0.sp,
        left: 12.0.sp,
        right: 12.0.sp,
      ),
      itemBuilder: (context, index) {
        return AppTouchable(
          onPressed: () {
            controller.onPressItem(list[index]);
          },
          onLongPressed: () {
            if (type == 1) {
              _showDialogUpdateFavorite(list[index]);
              return;
            }
            _showDialogApply(list[index].id);
          },
          rippleColor: AppColor.transparent,
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
          child: Image.memory(
            Uint8List.fromList(list[index].image),
          ),
        );
      },
    );
  }
}
