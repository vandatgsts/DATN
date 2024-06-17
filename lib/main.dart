import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'src/presentation/app/app_binding.dart';
import 'src/presentation/router/app_page.dart';
import 'src/presentation/router/app_router.dart';
import 'src/presentation/theme/app_theme.dart';
import 'src/resource/string/app_string.dart';
import 'src/utils/app_constant.dart';
import 'src/utils/app_log.dart';
import 'src/utils/share_preference_utils.dart';

bool isConsent = false;
RxString currentRoute = "".obs;




void mainDelegate() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );



  // AppLovinMAX.showMediationDebugger();

  await WakelockPlus.enable();
  await PreferenceUtils.init();


  runApp(
    ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);

        return MediaQuery(
          data: data.copyWith(
            textScaleFactor: 1,
          ),
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialBinding: AppBinding(),
            initialRoute: AppRouter.splashScreen,
            defaultTransition: Transition.fade,
            getPages: AppPage.pages,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.dark,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            navigatorObservers: [
              GetObserver((Routing? routing) {
                if (routing != null) {
                  AppLog.debug(routing.current.toString(), tag: "Routing");
                  currentRoute.value = routing.current;
                }
              }),
            ],
            translations: AppString(),
            supportedLocales: AppConstant.availableLocales,
            locale: AppConstant.availableLocales[0],
            fallbackLocale: AppConstant.availableLocales[0],
          ),
        );
      },
    ),
  );
}
