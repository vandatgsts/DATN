import 'dart:io';

import 'package:ar_drawing/src/presentation/base/base_controller.dart';
import 'package:ar_drawing/src/presentation/router/app_router.dart';
import 'package:ar_drawing/src/presentation/screen/web_view_screen.dart';
import 'package:get/get.dart';

import '../../../data/more_app_item.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_utils.dart';

class SettingController extends BaseController {
  List<MoreAppItem> listMoreApp = <MoreAppItem>[];

  @override
  void onInit() {
    super.onInit();

    if (Platform.isAndroid) {
      listMoreApp.addAll(AppConstant.listAndroidMoreApp);
    } else {
      listMoreApp.addAll(AppConstant.listIosMoreApp);
    }
  }

  void onPressToPremium() {
    Get.toNamed(AppRouter.subscriptionScreen);
  }

  void onPressRate() async {
    await showRateDialog(context);
  }

  void onPressTermOfCondition() {
    Get.to(() => const WebViewScreen(url: urlTerm));
  }

  void onPressPrivacy() {
    Get.to(() => const WebViewScreen(url: urlPrivacy));
  }

  void onPressContact() {
    Get.to(() => const WebViewScreen(url: urlContact));
  }
  void onPressLanguage(){
    Get.toNamed(AppRouter.languageScreen, arguments: {
      "is_show_back": true,
    });
  }
}
