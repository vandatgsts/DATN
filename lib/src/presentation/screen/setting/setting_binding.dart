import 'package:ar_drawing/src/presentation/screen/setting/setting_controller.dart';
import 'package:get/get.dart';

class SettingBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SettingController());
  }
}