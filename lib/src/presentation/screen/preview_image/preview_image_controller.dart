import 'dart:io';
import 'dart:typed_data';

import 'package:ar_drawing/src/presentation/screen/deny_permission_camera/deny_camera_screen.dart';
import 'package:ar_drawing/src/utils/app_log.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../native_bridge/open_cv/opencv.dart';
import '../../../utils/app_constant.dart';
import '../../base/base_controller.dart';
import '../../router/app_router.dart';

class PreviewImageController extends BaseController {
  Uint8List? byteData;
  String? imageUrl;
  String? id;

  @override
  void onInit() {
    byteData = Get.arguments["byteData"];
    imageUrl = Get.arguments["image"];
    id = Get.arguments["id"];

    AppLog.debug("PreviewImageController: id: $id");
    AppLog.debug("PreviewImageController: imageUrl: $imageUrl");
    AppLog.debug("PreviewImageController: byteData: ${byteData?.length}");

    super.onInit();
  }

  Future<bool> _handlePermission() async {
    List<Permission> listPermission = [
      Permission.camera,
      Permission.microphone
    ];
    await listPermission.request();

    if (!(await checkPermissions(listPermission))) {
      Get.to(() => const DenyCameraScreen());
      return false;
    }
    return true;
  }

  Future<bool> checkPermissions(List<Permission> listPermission) async {
    for (var permission in listPermission) {
      if (!(await permission.isGranted)) {
        return false;
      }
    }
    return true;
  }

  void _onPressContinue() async {
    bool isGrant = await _handlePermission();
    if (!isGrant) {
      return;
    }
    showLoading();

    if (imageUrl == null) {
      AppLog.debug("PreviewImageController: byteData");

      if (id?.contains("Data_") == true) {
        Uint8List? processImageList = await OpenCV.processImg(
          byteData: byteData ?? Uint8List(0),
          edgeLevel: AppConstant.defaultEdgeLv,
          noise: AppConstant.defaultNoise,
        );

        Get.toNamed(AppRouter.drawScreen, arguments: {
          "byte_data": processImageList,
          "origin_byte_data": byteData,
          "byte_data_resize": byteData ?? Uint8List(0),
          "image_id": id,
        });
      } else {
        Uint8List? processImageList = await OpenCV.processImg(
          byteData: byteData ?? Uint8List(0),
          edgeLevel: AppConstant.defaultEdgeLv,
          noise: AppConstant.defaultNoise,
        );

        Get.toNamed(AppRouter.drawScreen, arguments: {
          "byte_data": processImageList,
          "origin_byte_data": byteData,
          "byte_data_resize": byteData ?? Uint8List(0),
          "image_id": id,
        });
      }
    } else {
      AppLog.debug("PreviewImageController: imageUrl");

      XFile? file = await downloadImageToXFile(imageUrl!);

      Uint8List byteData = await resizeImage(file, 1920) ?? Uint8List(0);

      Uint8List? processImageList = await OpenCV.processImg(
        byteData: byteData,
        edgeLevel: AppConstant.defaultEdgeLv,
        noise: AppConstant.defaultNoise,
        threshold2: 120.0,
      );

      // Uint8List? adaptiveThreshold = await OpenCV.adaptiveThreshold(
      //   byteData: byteData,
      //   blockSize: AppConstant.defaultEdgeLv,
      //   cValue: AppConstant.defaultNoise,
      // );

      Get.toNamed(AppRouter.drawScreen, arguments: {
        "byte_data": processImageList,
        "origin_byte_data": byteData,
        "byte_data_resize": byteData,
        "image_id": id,
      });
    }

    hideLoading();
  }

  void onPressContinue() {
    _onPressContinue.call();
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

  Future<Uint8List?> resizeImage(XFile? file, int newWidth) async {
    if (file == null) return null;

    // Đọc file ảnh
    Uint8List imageBytes = await file.readAsBytes();
    img.Image? image = img.decodeImage(imageBytes);

    if (image == null) return null;

    // Tính toán chiều cao mới để giữ nguyên tỷ lệ khung hình
    int newHeight = (image.height * newWidth) ~/ image.width;

    // Thay đổi kích thước ảnh
    img.Image resizedImage =
        img.copyResize(image, width: newWidth, height: newHeight);

    // Lưu ảnh đã thay đổi kích thước vào file tạm thời
    String tempPath = (await getTemporaryDirectory()).path;
    String newPath = '$tempPath/resized_image.jpg';
    File resizedFile = File(newPath)
      ..writeAsBytesSync(img.encodeJpg(resizedImage));

    return resizedFile.readAsBytes();
  }
}
