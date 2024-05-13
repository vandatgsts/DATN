import 'package:ar_drawing/src/presentation/screen/preview_image/preview_image_controller.dart';
import 'package:get/get.dart';

class PreviewImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PreviewImageController());
  }
}
