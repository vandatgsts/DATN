import 'dart:async';
import 'dart:io';

import 'package:ar_drawing/src/native_bridge/meta_sdk/meta_sdk.dart';
import 'package:ar_drawing/src/presentation/screen/home/home_controller.dart';
import 'package:ar_drawing/src/resource/string/app_string.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/models/image_item.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_image.dart';
import '../../utils/app_log.dart';
import '../../utils/app_utils.dart';
import '../../utils/firebase_analytics.dart';
import '../../utils/remote_config.dart';
import '../router/app_router.dart';
import '../screen/draw/draw_controller.dart';

class _ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
    SKPaymentTransactionWrapper transaction,
    SKStorefrontWrapper storefront,
  ) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}

class AppController extends SuperController {
  bool avoidShowOpenApp = false;

  RxBool isPremium = true.obs;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<dynamic>? _subscriptionIAP;
  final List<ProductDetails> _listProductDetails = [];
  RxList<ProductDetails> listProductDetailsSub = RxList();
  RxBool pendingPurchase = false.obs;
  RxBool errorPurchase = false.obs;
  RxString queryProductErrorMessage = "".obs;
  RxBool queryProductError = false.obs;

  RxBool showBannerSub = true.obs;
  RxBool showBanner = true.obs;
  RxBool showInter = true.obs;
  Map<int, List<ImageItem>> listImage = {};
  int cntImage = 0;

  bool isShowOpenAdSuccess = false;

  RxString languageName = "".obs;
  bool isFirstRate = false;

  List<Map> listLanguage = [
    {
      "type": "",
      "name": "English",
      "image": AppImage.icEnglish,
      "locale": const Locale('en'),
    },
    {
      "type": "",
      "name": "हिंदी",
      "image": AppImage.icHindi,
      "locale": const Locale('hi'),
    },
    {
      "type": "",
      "name": "Española",
      "image": AppImage.icSpanish,
      "locale": const Locale('es'),
    },
    {
      "type": "",
      "name": "Português",
      "image": AppImage.icPortuguese,
      "locale": const Locale('pt'),
    },
    {
      "type": "",
      "name": "Français",
      "image": AppImage.icFrench,
      "locale": const Locale('fr'),
    },
    {
      "type": "",
      "name": "Deutsch",
      "image": AppImage.icGermany,
      "locale": const Locale('de'),
    },
    {
      "name": "Indonesia",
      "image": AppImage.icIndonesia,
      "locale": const Locale('id'),
    },
    {
      "name": "日本語",
      "image": AppImage.icJapan,
      "locale": const Locale('ja'),
    },
  ];

  Map mapNativeIntro = {};

  @override
  void onInit() {

    super.onInit();
  }




  @override
  void onDetached() {
    AppLog.debug("onDetached");
  }

  @override
  void onHidden() {
    AppLog.debug("onHidden");
  }

  @override
  void onInactive() {
    AppLog.debug("onInactive");

    if (Get.currentRoute == AppRouter.drawScreen) {
      var controller = Get.find<DrawController>();
      AppLog.debug("123");
      controller.cameraController?.stopVideoRecording();
      controller.recording.value = false;
      controller.start.value = 0;
      controller.timer?.cancel();
    }
  }

  @override
  void onPaused() {
    AppLog.debug("onPaused");
  }

  @override
  void onResumed() {
    avoidShowOpenApp = false;

    if (Get.currentRoute == AppRouter.drawScreen) {
      var controller = Get.find<DrawController>();
      if (controller.cameraController?.value.isInitialized == false) {
        controller.globalKey.currentState?.initCamera();
      }

      controller.onFlash.value = false;

      AppLog.info(
          "check cam: ${controller.cameraController?.value.isInitialized}");
    }
  }

  @override
  void onReady() {
    _onInitIAPListener();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        showToast(StringConstants.noInternet.tr);
      }
    });


    super.onReady();
  }

  /// In app purchase
  void _onInitIAPListener() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;

    _subscriptionIAP = purchaseUpdated.listen((purchaseDetailsList) async {
      for (var purchaseDetails in purchaseDetailsList) {
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }

      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      AppLog.debug('---IAP--- done IAP stream');
      _subscriptionIAP?.cancel();
    }, onError: (error) {
      AppLog.error('---IAP--- error IAP stream: $error');
    });
  }

  Future<void> onPressPremiumByProduct(String productId) async {
    ProductDetails? productDetails = _listProductDetails
        .firstWhereOrNull((element) => element.id == productId);
    productDetails ??= listProductDetailsSub.value
        .firstWhereOrNull((element) => element.id == productId);

    if (productDetails == null || productDetails.id.isEmpty) {
      showToast(StringConstants.notAvailable.tr);
    } else {
      AppLog.debug(
          '---IAP---: response.productDetails ${productDetails.title}');
      final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: productDetails,
      );

      _inAppPurchase.buyNonConsumable(
        purchaseParam: purchaseParam,
      );
    }
  }

  Future<void> getIAPProductDetails() async {
    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      showToast(StringConstants.canNotConnectStore.tr);
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(_ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(AppConstant.setKeyIAP);

    if (productDetailResponse.error != null) {
      queryProductError.value = true;
      queryProductErrorMessage.value = productDetailResponse.error!.message;

      AppLog.error(productDetailResponse.error!.message,
          tag: "AppController::getIAPProductDetails()");
      return;
    }

    listProductDetailsSub.value = productDetailResponse.productDetails;
    for (ProductDetails productDetails
        in productDetailResponse.productDetails) {
      AppLog.debug("${productDetails.title} - ${productDetails.rawPrice}",
          tag: "AppController::getIAPProductDetails()");
    }

    await _inAppPurchase.restorePurchases();
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    /// IMPORTANT!! Always verify purchase details before delivering the product.
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      AppLog.debug(
          'productID: ${purchaseDetails.productID}\nstatus: ${purchaseDetails.status}',
          tag: "---IAP---");

      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          pendingPurchase.value = true;
          //  showToast("Purchase is pending");
          break;

        case PurchaseStatus.canceled:
          pendingPurchase.value = false;
          errorPurchase.value = false;
          //  showToast("Purchase is canceled");
          break;

        case PurchaseStatus.error:
          errorPurchase.value = true;
          pendingPurchase.value = false;
          showToast(StringConstants.purchaseFail.tr);
          break;

        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          //   showToast("Purchase is purchased");
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            unawaited(deliverProduct(purchaseDetails));

            // if (Platform.isAndroid) {
            //   // if (!_kAutoConsume &&
            //   //     purchaseDetails.productID == _kConsumableId) {
            //   //   final InAppPurchaseAndroidPlatformAddition androidAddition =
            //   //   _inAppPurchase.getPlatformAddition<
            //   //       InAppPurchaseAndroidPlatformAddition>();
            //   //   await androidAddition.consumePurchase(purchaseDetails);
            //   // }
            // }

            if (purchaseDetails.pendingCompletePurchase) {
              await _inAppPurchase.completePurchase(purchaseDetails);
              AppLog.debug("Complete purchase", tag: "---IAP---");

              if (purchaseDetails.status == PurchaseStatus.purchased) {

              }

              if (purchaseDetails.status == PurchaseStatus.purchased) {
                ProductDetails? productDetails =
                    _listProductDetails.firstWhereOrNull(
                        (element) => element.id == purchaseDetails.productID);

                metaPurchaseEvent(productDetails);
              }

              isPremium.value = true;
              pendingPurchase.value = false;
              Get.back();
            }
          } else {
            _handleInvalidPurchase(purchaseDetails);
            AppLog.debug("Invalid purchase", tag: "---IAP---");
          }
          break;
      }
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  Future<void> updateLocale(Locale locale) async {
    Get.updateLocale(locale);
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().setListImagePath();
    }
  }

  void metaPurchaseEvent(ProductDetails? productDetails) async {
    if (productDetails == null) {
      return;
    }

    double amount = productDetails.rawPrice * 0.63;
    String currency = productDetails.currencyCode;
    Map<String, String> eventValue = <String, String>{};
    eventValue["product_id"] = productDetails.id;

    await MetaSdk.logPurchase(
        amount: amount, currency: currency, parameters: eventValue);
  }
}
