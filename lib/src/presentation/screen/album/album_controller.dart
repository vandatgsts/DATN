import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../data/model/favorite_item.dart';
import '../../../data/service/database_helper.dart';
import '../../../utils/app_log.dart';
import '../../../utils/firebase_analytics.dart';
import '../../app/app_controller.dart';
import '../../base/base_controller.dart';
import '../../router/app_router.dart';
import '../how_to_use/how_to_use_screen.dart';

class AlbumController extends BaseController with WidgetsBindingObserver {
  RxList<FavoriteItem> listAlbum = RxList();


  @override
  Future<bool> didPopRoute() {
    AppLog.debug("didPopRoute", tag: "AlbumController");

    return super.didPopRoute();
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    AppLog.debug("didPushRouteInformation", tag: "AlbumController");
    AppLog.debug(routeInformation.uri.path, tag: "AlbumController");

    return super.didPushRouteInformation(routeInformation);
  }

  @override
  void onReady() async {
    super.onReady();

    showLoading();

    listAlbum.value = await DatabaseHelper.instance.fetchFavoriteItems();

    hideLoading();
  }

  void onPressItem(FavoriteItem favoriteItem) async {
    showLoading();

    AppFirebaseAnalytics.instance.logEvent(name: "album_image");

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
    AppFirebaseAnalytics.instance.logEvent(name: "album_how_to_use");

    Get.to(() => const HowToUseScreen());
  }
}
