
import 'package:ar_drawing/src/utils/remote_config.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';


import '../../../domain/models/image_item.dart';
import '../../../domain/service/api_service.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/share_preference_utils.dart';
import '../../app/app_controller.dart';
import '../../base/base_controller.dart';
import '../../dialog/connectivity_dialog.dart';
import '../../router/app_router.dart';

class SplashController extends BaseController {
  final AppController _appController = Get.find<AppController>();

  RxString version = ''.obs;
  int cntAds = 1;

  @override
  void onReady() async {
    super.onReady();



    int indexLanguage = PreferenceUtils.getInt("index_language") ?? 0;

    await _appController
        .updateLocale(_appController.listLanguage[indexLanguage]["locale"]);

    _appController.languageName.value =
        _appController.listLanguage[indexLanguage]["name"];

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;

    _appController.showBanner.value = RemoteConfig.getShowBanner();
    _appController.showInter.value = RemoteConfig.getShowInter();



    await _processedData();

  }

  Future<void> _nextScreen() async {
    await Future.delayed(const Duration(milliseconds: 500));


    Get.offAllNamed(AppRouter.homeScreen);


  }


  Future<void> _processedData() async {
    bool haveInternet = await checkInternet();

    if (!haveInternet) {
      if (context.mounted) {
        await showConnectivityDialog(
          context: context,
          firstButtonCall: _processedData,
        );
      }

      return;
    }

    List<ImageItem> data = await ApiService.getAllImage();
    data.sort(
      (a, b) => a.categoryId!.compareTo(b.categoryId!),
    );
    // data.sort(
    //       (a, b) => a.!.compareTo(b.like!),
    // );
    int count = 0;

    _appController.listImage[count] = [];
    for (int index = 0; index < data.length - 1; index++) {
      if (data[index].categoryId == data[index + 1].categoryId) {
        _appController.listImage[count]?.add(data[index]);
      } else {
        _appController.listImage[count]?.add(data[index]);
        _appController.listImage[count]?.sort(
          (a, b) => a.id!.compareTo(b.id!),
        );
        count += 1;
        _appController.listImage[count] = [];
      }
    }

    _appController.listImage[count]?.add(data.last);
    

    // AppLog.debug(_appController.listImage);

    _nextScreen();
  }
}
