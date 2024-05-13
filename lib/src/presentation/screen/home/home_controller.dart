import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:ar_drawing/src/resource/string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../domain/models/image_item.dart';
import '../../../utils/app_image.dart';
import '../../../utils/app_log.dart';
import '../../../utils/firebase_analytics.dart';
import '../../../utils/share_preference_utils.dart';
import '../../app/app_controller.dart';
import '../../base/base_controller.dart';
import '../../dialog/camera_dialog.dart';
import '../../dialog/dialog_let_Start.dart';
import '../../dialog/show_app_dialog.dart';
import '../../router/app_router.dart';
import '../category_screen.dart';
import '../deny_permission_camera/deny_camera_screen.dart';
import '../how_to_use/how_to_use_screen.dart';

class HomeController extends BaseController {
  final AppController _appController = Get.find<AppController>();
  final ImagePicker _picker = ImagePicker();

  List<Map<String, String>> listImagePath = [
    {
      "img_path": AppImage.banner1,
      "title": StringConstants.subBanner1.tr,
    },
    {
      "title": "ads",
    },
    {
      "img_path": AppImage.banner2,
      "title": StringConstants.subBanner2.tr,
    },
    {
      "title": "ads",
    },
    {
      "img_path": AppImage.banner3,
      "title": StringConstants.subBanner3.tr,
    },
    {
      "title": "ads",
    },
    {
      "img_path": AppImage.banner4,
      "title": StringConstants.subBanner4.tr,
    },
    {
      "title": "ads",
    },
    {
      "img_path": AppImage.banner5,
      "title": StringConstants.subBanner5.tr,
    },
  ];
  RxInt page = 0.obs;
  RxInt itemDialogSelected = 1.obs;
  RxMap<int, List<ImageItem>> listImage = <int, List<ImageItem>>{}.obs;
  RxList<Map<String, List<ImageItem>>> listImageAndAds = RxList();
  RxList<ImageItem> listEasy = <ImageItem>[].obs;
  RxList<ImageItem> listMedium = <ImageItem>[].obs;
  RxList<ImageItem> listHard = <ImageItem>[].obs;
  Rx<Color> buttonColor = const Color(0xFF7431E2).obs;
  Rx<Color> buttonTextColor = Colors.white.obs;
  Rx<Color> textColor = Colors.black.obs;

  @override
  void onInit() {
    listImage.value = _appController.listImage;
    if (!_appController.isPremium.value) {
      for (int i = 0; i < listImage.length; i++) {
        if (i % 2 == 0) {
          listImageAndAds.add({
            "data": [],
          });
          listImageAndAds.add({
            "data": listImage[i] ?? [],
          });
        } else {
          listImageAndAds.add({
            "data": listImage[i] ?? [],
          });
        }
      }
    } else {
      for (int i = 0; i < listImage.length; i++) {
        listImageAndAds.add({
          "data": listImage[i] ?? [],
        });
      }
      listImagePath.removeWhere((element) => element["title"] == "ads");
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    _getDataLevel();
  }

  setListImagePath() {
    listImagePath = [
      {
        "img_path": AppImage.banner1,
        "title": StringConstants.subBanner1.tr,
      },
      {
        "title": "ads",
      },
      {
        "img_path": AppImage.banner2,
        "title": StringConstants.subBanner2.tr,
      },
      {
        "title": "ads",
      },
      {
        "img_path": AppImage.banner3,
        "title": StringConstants.subBanner3.tr,
      },
      {
        "title": "ads",
      },
      {
        "img_path": AppImage.banner4,
        "title": StringConstants.subBanner4.tr,
      },
      {
        "title": "ads",
      },
      {
        "img_path": AppImage.banner5,
        "title": StringConstants.subBanner5.tr,
      },
    ];
    if (_appController.isPremium.value) {
      listImagePath.removeWhere((element) => element["title"] == "ads");
    }
  }

  void setContext(BuildContext context) {
    this.context = context;
  }

  void onPressPhoto() async {
    AppFirebaseAnalytics.instance.logEvent(name: "home_photo");

    // showLoading();

    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
    );
    Uint8List? byteData = await image?.readAsBytes();

    if (byteData == null) {
      // hideLoading();
      return;
    }

    Get.toNamed(AppRouter.previewImage, arguments: {
      "byteData": byteData,
    });

    // hideLoading();
  }

  void onPressCamera() async {
    AppFirebaseAnalytics.instance.logEvent(name: "home_camera");

    showLoading();

    var status = await Permission.camera.status;
    if (status.isDenied) {
      var statusAfterRequest = await Permission.camera.request();
      if (!statusAfterRequest.isGranted) {
        await Get.to(() => const DenyCameraScreen());
        hideLoading();
        return;
      }
    } else if (!status.isGranted) {
      await Get.to(() => const DenyCameraScreen());
      hideLoading();
      return;
    }

    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1080,
    );

    Uint8List? byteData = await image?.readAsBytes();

    if (byteData == null) {
      hideLoading();
      return;
    }

    Get.toNamed(AppRouter.previewImage, arguments: {
      "byteData": byteData,
    });

    hideLoading();
  }

  void onPressLetStart() {
    AppFirebaseAnalytics.instance.logEvent(name: "home_let_start");

    int indexList = Random().nextInt(listImage.length);
    var indices = <int>[]; // Danh sách để lưu trữ các chỉ số duy nhất

    while (indices.length < 4) {
      var index = Random().nextInt(
          listImage[indexList]?.length ?? 10); // Tạo một chỉ số ngẫu nhiên
      if (!indices.contains(index)) {
        // Kiểm tra nếu chỉ số chưa được thêm vào danh sách
        indices.add(index); // Thêm chỉ số vào danh sách nếu nó là duy nhất
      }
    }
    itemDialogSelected.value = indices[0];
    showAppDialog(
      context,
      "",
      "",
      hideGroupButton: true,
      widgetBody: DialogLetStart(
        indexList: indexList,
        values: indices,
      ),
    );
  }

  void onPressImage() async {
    AppFirebaseAnalytics.instance.logEvent(name: "home_image");

    if (context.mounted) {
      await showCameraDialog(
        context,
        onPressCamera: onPressCamera,
        onPressPhoto: onPressPhoto,
      );
    }
  }

  void onPressItem(String image, int id) async {
    AppFirebaseAnalytics.instance.logEvent(name: "home_image_item");

    if (Get.find<AppController>().isPremium.value) {
      Get.toNamed(
        AppRouter.previewImage,
        arguments: {
          "byteData": null,
          "image": image,
          "id": "Data_$id",
        },
      );
    } else {
      int cntClickItemCategory =
          PreferenceUtils.getInt("cnt_click_item_category") ?? 0;
      cntClickItemCategory++;
      AppLog.debug("cntClickItemCategory: $cntClickItemCategory");
      PreferenceUtils.setInt("cnt_click_item_category", cntClickItemCategory);

      Get.toNamed(
        AppRouter.previewImage,
        arguments: {
          "byteData": null,
          "image": image,
          "id": "Data_$id",
        },
      );
    }
  }

  void onPressSetting() {
    AppFirebaseAnalytics.instance.logEvent(name: "home_setting");
    Get.toNamed(AppRouter.settingScreen);
  }

  void onPressAlbum() {
    AppFirebaseAnalytics.instance.logEvent(name: "home_album");

    Get.toNamed(AppRouter.albumScreen);
  }

  void onPageChange(int index) {
    page.value = index;
    if (_appController.isPremium.value) {
      if (index == 0) {
        buttonColor.value = const Color(0xFF7431E2);
      } else if (index == 1) {
        buttonColor.value = const Color(0xFF5352ED);
      } else if (index >= 2) {
        buttonColor.value = Colors.white;
      }

      if (index <= 1) {
        buttonTextColor.value = Colors.white;
      } else if (index == 2 || index == 4) {
        buttonTextColor.value = const Color(0xFF7431E2);
      } else {
        buttonTextColor.value = const Color(0xFF5352ED);
      }

      if (index <= 1) {
        textColor.value = Colors.black;
      } else {
        textColor.value = Colors.white;
      }
    } else {
      if (index == 0) {
        buttonColor.value = const Color(0xFF7431E2);
      } else if (index == 2) {
        buttonColor.value = const Color(0xFF5352ED);
      } else if (index >= 4) {
        buttonColor.value = Colors.white;
      }

      if (index <= 2) {
        buttonTextColor.value = Colors.white;
      } else if (index == 4 || index == 8) {
        buttonTextColor.value = const Color(0xFF7431E2);
      } else {
        buttonTextColor.value = const Color(0xFF5352ED);
      }

      if (index <= 2) {
        textColor.value = Colors.black;
      } else {
        textColor.value = Colors.white;
      }
    }
  }

  void onPressPremium() {
    AppFirebaseAnalytics.instance.logEvent(name: "home_premium");

    Get.toNamed(AppRouter.subscriptionScreen);
  }

  void _getDataLevel() {
    for (int i = 0; i < listImage.length; i++) {
      for (int j = 0; j < listImage[i]!.length; j++) {
        if (listImage[i]![j].like == 1) {
          listEasy.add(listImage.value[i]?[j] ?? ImageItem());
        }
        if (listImage[i]![j].like == 2) {
          listMedium.add(listImage.value[i]?[j] ?? ImageItem());
        }
        if (listImage[i]![j].like == 3) {
          listHard.add(listImage.value[i]?[j] ?? ImageItem());
        }
      }
    }
  }

  void onPressLevelEasy() {
    AppFirebaseAnalytics.instance.logEvent(name: "home_level_easy");

    Get.to(
      () => CategoryScreen(
        title: StringConstants.beginner.tr,
        listData: listEasy.value,
      ),
    );
  }

  void onPressLevelHard() {
    AppFirebaseAnalytics.instance.logEvent(name: "home_level_hard");

    Get.to(
      () => CategoryScreen(
        title: StringConstants.advanced.tr,
        listData: listHard.value,
      ),
    );
  }

  void onPressLevelMedium() {
    AppFirebaseAnalytics.instance.logEvent(name: "home_level_medium");
    Get.to(
      () => CategoryScreen(
        title: StringConstants.intermediate.tr,
        listData: listMedium.value,
      ),
    );
  }

  void onPressHowToUse() {
    AppFirebaseAnalytics.instance.logEvent(name: "home_how_to_use");

    Get.to(() => const HowToUseScreen());
  }
}

Future<XFile> downloadImageToXFile(String imageUrl) async {
  // Tải ảnh từ URL
  final response = await http.get(Uri.parse(imageUrl));
  if (response.statusCode == 200) {
    // Tìm đường dẫn đến thư mục tạm thời
    final documentDirectory = await getTemporaryDirectory();

    // Tạo một tệp mới trong thư mục tạm thời với tên duy nhất
    final file = File(path.join(documentDirectory.path, 'tempImage.png'));

    // Ghi dữ liệu ảnh vào tệp
    file.writeAsBytesSync(response.bodyBytes);

    // Tạo XFile từ tệp đã lưu
    return XFile(file.path);
  } else {
    throw Exception('Failed to download image');
  }
}
