import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resource/string/app_string.dart';
import '../widget/app_loading.dart';
import 'base_controller.dart';

abstract class BaseScreen<T extends BaseController> extends GetView<T> {
  const BaseScreen({Key? key}) : super(key: key);

  Widget buildWidgets();

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    return Stack(
      children: [
        buildWidgets(),
        baseShowLoading(),
      ],
    );
  }

  Widget baseShowLoading() {
    return Obx(
      () => controller.isShowLoading.value
          ? Scaffold(
              backgroundColor: Colors.black.withOpacity(0.8),
              body: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppLoading(),
                    Text(
                      StringConstants.loading.tr,
                      style: controller.context.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
