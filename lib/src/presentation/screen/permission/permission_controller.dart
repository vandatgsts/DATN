import 'package:ar_drawing/src/presentation/base/base_controller.dart';
import 'package:device_info/device_info.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/app_controller.dart';

class PermissionController extends BaseController {
  AppController appController = Get.find<AppController>();

  RxBool statusRecordAudio = true.obs;
  RxBool statusStorage = true.obs;
  RxBool statusCamera = true.obs;

  List<Permission> permissions = [];

  @override
  void onReady() {
    Future.delayed(
      Duration.zero,
      () async {
        AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
        permissions = [
          Permission.storage,
        ];

        if (androidInfo.version.sdkInt >= 33) {
          permissions.add(Permission.photos);
        }
      },
    );
    super.onReady();
  }

  onPressContinue() async{
    if (statusCamera.value){
      await Permission.camera.request();
    }
    if (statusRecordAudio.value){
      await Permission.microphone.request();
    }
    if (statusStorage.value){
      await permissions.last.request();
    }
    Get.back();
  }

}
