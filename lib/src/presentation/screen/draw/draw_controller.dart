import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:ar_drawing/src/resource/string/app_string.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wakelock_plus/wakelock_plus.dart';


import '../../../data/model/favorite_item.dart';
import '../../../data/service/database_helper.dart';
import '../../../native_bridge/open_cv/opencv.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/app_log.dart';
import '../../../utils/firebase_analytics.dart';
import '../../../utils/share_preference_utils.dart';
import '../../app/app_controller.dart';
import '../../base/base_controller.dart';
import '../../router/app_router.dart';
import '../album/album_controller.dart';
import '../camera_screen.dart';
import '../how_to_use/how_to_use_screen.dart';
import '../preview_after_draw_camera/preview_after_draw_camera.dart';
import '../preview_print/preview_print.dart';

class DrawController extends BaseController {
  Rx<Uint8List> byteData = Uint8List(0).obs;
  Rx<Uint8List> originByteData = Uint8List(0).obs;
  Rx<Uint8List> byteDataResize = Uint8List(0).obs;
  CameraController? _cameraController;
  RxInt currentIndex = 1.obs;
  RxDouble opacity = 1.0.obs;
  RxDouble edgeLV = (AppConstant.defaultEdgeLv.toDouble() /
          AppConstant.defaultMaxEdgeLv.toDouble())
      .obs;
  RxDouble noise = (AppConstant.defaultNoise.toDouble() /
          AppConstant.defaultMaxNoise.toDouble())
      .obs;
  RxBool isStroke = true.obs;
  RxBool isTrace = false.obs;
  RxBool isExtendOption = true.obs;
  RxBool isFavorite = false.obs;
  RxBool isExpansion = false.obs;
  RxBool recording = false.obs;
  Timer? timer;
  RxInt start = 0.obs;
  RxBool onFlash = false.obs;
  String imageId = "";

  CameraController? get cameraController => _cameraController;

  int edgeLvValue = AppConstant.defaultEdgeLv;
  double noiseValue = AppConstant.defaultNoise;

  RxBool showBanner = true.obs;

  GlobalKey<CameraScreenState> globalKey = GlobalKey();

  @override
  void onInit() {
    byteData.value = Get.arguments["byte_data"];
    originByteData.value = Get.arguments["origin_byte_data"];
    byteDataResize.value = Get.arguments["byte_data_resize"];
    imageId = Get.arguments["image_id"] ?? '';

    super.onInit();
    WakelockPlus.enable();
  }

  @override
  void onReady() async {
    super.onReady();

    recording.value = _cameraController?.value.isRecordingVideo ?? false;
    isFavorite.value = await DatabaseHelper.instance.isFavorite(imageId);
  }

  void setCameraController(CameraController? cameraController) {
    _cameraController = cameraController;
  }

  void onPressFlash() {
    AppFirebaseAnalytics.instance.logEvent(name: "draw_flash");

    if (_cameraController == null) {
      showToast(StringConstants.pleaseWait.tr);
    }

    try {
      if (_cameraController?.value.flashMode == FlashMode.off) {
        _cameraController?.setFlashMode(FlashMode.torch);
        onFlash.value = true;
      } else {
        _cameraController?.setFlashMode(FlashMode.off);
        onFlash.value = false;
      }
    } on CameraException catch (e) {
      AppLog.error(e.description, tag: "CameraException DrawController");
    }
  }

  void _onPressTrace() {
    if (recording.value) {
      showToast(StringConstants.videoNotSupport.tr);
      return;
    }

    onFlash.value = false;

    isTrace.value = true;
    if (currentIndex.value > 1 && currentIndex.value < 4) {
      currentIndex.value = 1;
    }
    // _cameraController?.stopImageStream();
  }

  void onPressTrace() {
    AppFirebaseAnalytics.instance.logEvent(name: "draw_trace");

    _onPressTrace.call();
  }

  void onPressSketch() {
    AppFirebaseAnalytics.instance.logEvent(name: "draw_sketch");

    isTrace.value = false;
  }

  void onPressTool() {
    AppFirebaseAnalytics.instance.logEvent(name: "draw_tool");

    showBanner.value = true;

    currentIndex.value = 1;
  }

  void onPressTakeAPhoto() async {
    AppFirebaseAnalytics.instance.logEvent(name: "draw_take_a_photo");

    showLoading();
    XFile? image = await _cameraController?.takePicture();

    try {
      if (_cameraController?.value.flashMode == FlashMode.torch) {
        _cameraController?.setFlashMode(FlashMode.off);
        onFlash.value = false;
      }
    } on CameraException catch (e) {
      AppLog.error(e.description, tag: "CameraException DrawController");
    }

    Get.to(() => PreviewAfterDrawCamera(
      isImage: true,
      xFile: image ?? XFile(""),
    ));
    hideLoading();
  }

  void onPressStartRecord() async {
    AppFirebaseAnalytics.instance.logEvent(name: "draw_start_record");

    int cntRecord =
        PreferenceUtils.getInt(AppKeyPreference.keyCountRecord) ?? 0;

    if (!Get.find<AppController>().isPremium.value) {
      if (cntRecord >= 3) {
        Get.toNamed(AppRouter.subscriptionScreen);
        return;
      }
    }

    if (recording.value) {
      timer?.cancel();
      start.value = 0;
      showLoading();
      try {
        if (_cameraController?.value.flashMode == FlashMode.torch) {
          _cameraController?.setFlashMode(FlashMode.off);
          onFlash.value = false;
        }
      } on CameraException catch (e) {
        AppLog.error(e.description, tag: "CameraException DrawController");
      }

      XFile? video = await _cameraController?.stopVideoRecording();
      recording.value = false;

      Get.to(() => PreviewAfterDrawCamera(
        isImage: false,
        xFile: video ?? XFile(""),
      ));

      hideLoading();
    } else {
      if (Platform.isAndroid) {
        await _cameraController?.prepareForVideoRecording();
      }
      await _cameraController?.startVideoRecording();
      startTimer();
      recording.value = true;
    }
  }

  void startTimer() {
    // Hủy Timer cũ nếu có
    timer?.cancel();
    // Khởi tạo một Timer mới
    start.value = 0;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      start.value++;
    });
  }

  String formatTime(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void onPressPhoto() {
    AppFirebaseAnalytics.instance.logEvent(name: "draw_photo");

    showBanner.value = true;
    currentIndex.value = 2;
  }

  void onPressRecord() {
    AppFirebaseAnalytics.instance.logEvent(name: "draw_record");

    showBanner.value = false;

    currentIndex.value = 3;
  }

  void onPressPrint() {
    AppFirebaseAnalytics.instance.logEvent(name: "draw_print");

    try {
      if (_cameraController?.value.flashMode == FlashMode.torch) {
        _cameraController?.setFlashMode(FlashMode.off);
        onFlash.value = false;
      }
    } on CameraException catch (e) {
      AppLog.error(e.description, tag: "CameraException DrawController");
    }

    if (isStroke.value) {
      Get.to((() => PreviewPrint(byteData: byteData.value)));
    } else {
      Get.to((() => PreviewPrint(byteData: originByteData.value)));
    }
  }

  void onChangeEdgeLevel() async {
    edgeLvValue = (10 * edgeLV.value).round() + 1;

    byteData.value = await OpenCV.processImg(
          byteData: byteDataResize.value,
          edgeLevel: edgeLvValue,
          noise: noiseValue,
        ) ??
        Uint8List(0);
  }

  void onChangeNoise() async {
    noiseValue = 5 * noise.value;

    byteData.value = await OpenCV.processImg(
          byteData: byteDataResize.value,
          edgeLevel: edgeLvValue,
          noise: noiseValue,
        ) ??
        Uint8List(0);

    hideLoading();
  }

  void onPressFavorite() async {
    AppFirebaseAnalytics.instance.logEvent(name: "draw_favorite");

    isFavorite.value = !isFavorite.value;
    if (isFavorite.value) {
      await DatabaseHelper.instance.insertOrUpdateFavoriteItem(
        FavoriteItem(
          id: imageId,
          isFavorite: isFavorite.value,
          image: originByteData.value,
        ),
      );
    } else {
      await DatabaseHelper.instance.deleteFavoriteItem(imageId);
    }

    if (!Get.isRegistered<AlbumController>()) {
      Get.put(AlbumController());
    }

    Get.find<AlbumController>().listAlbum.value =
        await DatabaseHelper.instance.fetchFavoriteItems();
  }

  void onPressHowToUse() {
    AppFirebaseAnalytics.instance.logEvent(name: "draw_how_to_use");

    _cameraController?.setFlashMode(FlashMode.off);
    onFlash.value = false;
    Get.to(() => const HowToUseScreen());
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }
}
