import 'package:get/get.dart';

import 'draw_controller.dart';

class DrawBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DrawController>(() => DrawController());
  }
}