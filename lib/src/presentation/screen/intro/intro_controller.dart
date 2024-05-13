import 'package:ar_drawing/src/presentation/app/app_controller.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';



import '../../../resource/string/app_string.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_image.dart';
import '../../../utils/firebase_analytics.dart';
import '../../../utils/remote_config.dart';
import '../../../utils/share_preference_utils.dart';
import '../../base/base_controller.dart';
import '../../router/app_router.dart';
import '../../theme/app_color.dart';

class IntroController extends BaseController {
  RxInt currentIndex = 0.obs;
  CarouselController carouselController = CarouselController();

  List<Map<String, String>> listContent = [
    {
      'bg_image': AppImage.bgIntro1,
      'text_content1': StringConstants.intro1_1.tr,
      'text_content2': StringConstants.intro1_2.tr,
      'text_content3': StringConstants.intro1_3.tr,
    },
    {
      'bg_image': AppImage.bgIntro2,
      'text_content1': StringConstants.intro2_1.tr,
      'text_content2': StringConstants.intro2_2.tr,
      'text_content3': StringConstants.intro2_3.tr,
    },
    {
      'bg_image': AppImage.bgIntro3,
      'text_content1': StringConstants.intro3_1.tr,
      'text_content2': StringConstants.intro3_2.tr,
      'text_content3': StringConstants.intro3_3.tr,
    },
    {
      'bg_image': AppImage.bgIntro4,
      'text_content1': StringConstants.intro4_1.tr,
      'text_content2': StringConstants.intro4_2.tr,
      'text_content3': StringConstants.intro4_3.tr,
    },
  ];

  Rx<Color> currentColor = AppColor.primaryColor.obs;

  AppController appController = Get.find<AppController>();

  RxMap mapNative = {}.obs;

  @override
  void onInit() {

    super.onInit();
  }



  void onPressButtonNext() async {
    AppFirebaseAnalytics.instance.logEvent(name: "intro_${currentIndex + 1}");

    if (currentIndex.value < 4) {
      carouselController.nextPage();
      setColor();
    } else {
      await PreferenceUtils.setBool(AppKeyPreference.keyFirstOpenApp, false);
      Get.toNamed(AppRouter.permissionScreen)?.then(
            (value) => Get.offAndToNamed(AppRouter.subscriptionScreen)?.then(
              (value) => Get.offAndToNamed(AppRouter.homeScreen),
        ),
      );
    }
  }

  void onPressButtonBack() async {
    if (currentIndex.value == 0) {
      return;
    }

    currentIndex.value--;
    carouselController.animateToPage(currentIndex.value);
    setColor();
  }

  void setColor() {
    switch (currentIndex.value) {
      case 0:
        currentColor.value = AppColor.primaryColor;
        break;
      case 2:
        currentColor.value = AppColor.secondaryColor;
        break;
      case 1:
        currentColor.value = AppColor.white;
        break;
      default:
        currentColor.value = AppColor.primaryColor;
        break;
    }
  }
}
