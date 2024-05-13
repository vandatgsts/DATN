import 'package:ar_drawing/src/presentation/screen/permission/permission_binding.dart';
import 'package:ar_drawing/src/presentation/screen/permission/permission_screen.dart';
import 'package:get/get.dart';

import '../screen/album/album_binding.dart';
import '../screen/album/album_screen.dart';
import '../screen/draw/draw_binding.dart';
import '../screen/draw/draw_screen.dart';
import '../screen/home/home_binding.dart';
import '../screen/home/home_screen.dart';
import '../screen/intro/intro_binding.dart';
import '../screen/intro/intro_screen.dart';
import '../screen/language/language_binding.dart';
import '../screen/language/language_screen.dart';
import '../screen/preview_image/preview_image_binding.dart';
import '../screen/preview_image/preview_image_screen.dart';
import '../screen/setting/setting_binding.dart';
import '../screen/setting/setting_screen.dart';
import '../screen/splash/splash_binding.dart';
import '../screen/splash/splash_screen.dart';
import '../screen/subscription/subscription_binding.dart';
import '../screen/subscription/subscription_screen.dart';
import 'app_router.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: AppRouter.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: AppRouter.subscriptionScreen,
      page: () => const SubscriptionScreen(),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: AppRouter.introScreen,
      page: () => const IntroScreen(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: AppRouter.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRouter.drawScreen,
      page: () => const DrawScreen(),
      binding: DrawBinding(),
    ),
    GetPage(
      name: AppRouter.albumScreen,
      page: () => const AlbumScreen(),
      binding: AlbumBinding(),
    ),
    GetPage(
      name: AppRouter.settingScreen,
      page: () => const SettingScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: AppRouter.previewImage,
      page: () => const PreviewImageScreen(),
      binding: PreviewImageBinding(),
    ),
    GetPage(
      name: AppRouter.languageScreen,
      page: () => const LanguageScreen(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: AppRouter.permissionScreen,
      page: () => const PermissionScreen(),
      binding: PermissionBinding(),
    ),
  ];
}
