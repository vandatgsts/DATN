import 'package:ar_drawing/src/native_bridge/meta_sdk/meta_sdk.dart';
import 'package:ar_drawing/src/resource/string/app_string.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../utils/app_constant.dart';
import '../../../utils/firebase_analytics.dart';
import '../../app/app_controller.dart';
import '../../base/base_controller.dart';
import '../web_view_screen.dart';

class SubscriptionController extends BaseController {
  final AppController _appController = Get.find<AppController>();

  RxString rxSelectedIdentifier = AppConstant.keySubYear.obs;
  RxBool yearSelected = true.obs;
  RxBool monthSelected = false.obs;
  RxBool weekSelected = false.obs;

  RxInt saveValue = 0.obs;
  RxDouble onlyWeek = 0.0.obs;
  RxBool showClose = false.obs;

  late ProductDetails productDetailsWeek;
  late ProductDetails productDetailsMonth;
  late ProductDetails productDetailsYear;
  late ProductDetails productDetailsTemp;

  @override
  void onInit() {
    super.onInit();

    _appController.showBannerSub.value = false;

    productDetailsWeek = _appController.listProductDetailsSub.firstWhere(
      (element) => element.id == AppConstant.keySubWeek,
      orElse: () => ProductDetails(
        title: 'Weekly',
        id: '',
        currencyCode: '',
        description: '',
        price: '\$3.99',
        rawPrice: 3.99,
      ),
    );

    productDetailsMonth = _appController.listProductDetailsSub.firstWhere(
      (element) => element.id == AppConstant.keySubMonth,
      orElse: () => ProductDetails(
        title: 'Monthly',
        id: '',
        currencyCode: '',
        description: '',
        price: '\$7.99',
        rawPrice: 7.99,
      ),
    );

    productDetailsYear = _appController.listProductDetailsSub.firstWhere(
      (element) => element.id == AppConstant.keySubYear,
      orElse: () => ProductDetails(
        title: 'Yearly',
        id: '',
        currencyCode: '',
        description: '',
        price: '\$19.99',
        rawPrice: 19.99,
      ),
    );

    productDetailsTemp = _appController.listProductDetailsSub.firstWhere(
      (element) => element.id == AppConstant.keySubTemp,
      orElse: () => ProductDetails(
        title: 'Temp',
        id: '',
        currencyCode: '',
        description: '',
        price: '\$29.99',
        rawPrice: 29.99,
      ),
    );

    saveValue.value = 100 -
        (((productDetailsYear.rawPrice / 12) / productDetailsMonth.rawPrice) *
                100)
            .round();
    onlyWeek.value = productDetailsYear.rawPrice / 48;
  }

  @override
  void onReady() {
    super.onReady();

    Future.delayed(const Duration(seconds: 5), () {
      showClose.value = true;
    });
  }

  @override
  void onClose() {
    _appController.showBannerSub.value = true;

    super.onClose();
  }

  void onPressYearly() {
    AppFirebaseAnalytics.instance.logEvent(name: "sub_yearly");
    weekSelected.value = false;
    monthSelected.value = false;
    yearSelected.value = true;
    rxSelectedIdentifier.value = AppConstant.keySubYear;
  }

  void onPressMonthly() {
    AppFirebaseAnalytics.instance.logEvent(name: "sub_monthly");

    weekSelected.value = false;
    monthSelected.value = true;
    yearSelected.value = false;
    rxSelectedIdentifier.value = AppConstant.keySubMonth;
  }

  void onPressWeekly() {
    AppFirebaseAnalytics.instance.logEvent(name: "sub_weekly");

    weekSelected.value = true;
    monthSelected.value = false;
    yearSelected.value = false;
    rxSelectedIdentifier.value = AppConstant.keySubWeek;
  }

  void onPressBuy() {
    String subText = "";
    if (weekSelected.value){
      subText = "week";
    } else if (monthSelected.value){
      subText = "month";
    } else{
      subText = "year";
    }
    AppFirebaseAnalytics.instance.logEvent(name: "sub_click");
    MetaSdk.logEvent(name: "sub_click_$subText");
    _appController.onPressPremiumByProduct(rxSelectedIdentifier.value);
  }

  void onPressPrivacy() {
    Get.to(
      () => WebViewScreen(
        url: urlPrivacy,
        title: StringConstants.privacyPolicy.tr,
      ),
    );
  }

  void onPressTerm() {
    Get.to(
      () => WebViewScreen(
        url: urlTerm,
        title: StringConstants.termOfCondition.tr,
      ),
    );
  }
}
