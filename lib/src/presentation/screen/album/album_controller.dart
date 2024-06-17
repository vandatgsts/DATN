import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/favorite_item.dart';
import '../../../data/service/database_helper.dart';
import '../../base/base_controller.dart';
import '../../router/app_router.dart';
import '../how_to_use/how_to_use_screen.dart';

class AlbumController extends BaseController with GetTickerProviderStateMixin {
  RxList<FavoriteItem> listAlbum = RxList();
  RxList<FavoriteItem> listFavorite = RxList();
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onReady() async {
    super.onReady();

    showLoading();

    listAlbum.value = await DatabaseHelper.instance.fetchAllFavoriteItems();
    listFavorite.value = await DatabaseHelper.instance.fetchFavoriteItems();
    hideLoading();
  }

  void onPressItem(FavoriteItem favoriteItem) async {
    showLoading();

    Get.toNamed(
      AppRouter.previewImage,
      arguments: {
        "byteData": favoriteItem.image,
        "id": favoriteItem.id,
        "image": null,
      },
    );

    hideLoading();
  }

  void onPressBack() {
    Get.back();
  }

  void onPressHowToUse() {
    Get.to(() => const HowToUseScreen());
  }
}
