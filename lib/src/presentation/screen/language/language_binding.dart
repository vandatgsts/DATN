import 'package:ar_drawing/src/presentation/screen/language/language_controller.dart';
import 'package:get/get.dart';

class LanguageBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(LanguageController());
  }
}