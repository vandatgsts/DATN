import 'package:ar_drawing/src/presentation/screen/permission/permission_controller.dart';
import 'package:get/get.dart';

class PermissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PermissionController());
  }
}
