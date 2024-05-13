import 'package:ar_drawing/src/presentation/app/app_controller.dart';
import 'package:ar_drawing/src/presentation/base/base_controller.dart';
import 'package:ar_drawing/src/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../utils/remote_config.dart';
import '../../../utils/share_preference_utils.dart';

class LanguageController extends BaseController {
  List<Map> listLanguage = Get.find<AppController>().listLanguage;
  RxInt oldIndex = 0.obs;
  RxInt selectIndex = 0.obs;
  RxBool isShowBack = true.obs;
  AppController appController = Get.find<AppController>();


  @override
  void onInit() {
    isShowBack.value = Get.arguments["is_show_back"] ?? true;
    oldIndex.value = PreferenceUtils.getInt("index_language") ?? 0;
    selectIndex.value = oldIndex.value;
    super.onInit();
  }

  void selectLanguage(int index) async {
    selectIndex.value = index;
    await Get.find<AppController>().updateLocale(listLanguage[index]["locale"]);
  }

  Future<void> onPressConfirm() async {
    Get.find<AppController>().languageName.value =
        listLanguage[selectIndex.value]["name"];

    await PreferenceUtils.setInt("index_language", selectIndex.value);

    if (!isShowBack.value) {
      Get.offAndToNamed(AppRouter.introScreen);
    } else {
      Get.back();
    }
  }

  void onPressBack() async {
    Get.find<AppController>().languageName.value =
        listLanguage[oldIndex.value]["name"];
    await Get.find<AppController>()
        .updateLocale(listLanguage[oldIndex.value]["locale"]);
    Get.back();
  }
}
