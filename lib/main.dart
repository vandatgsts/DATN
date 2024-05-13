import 'dart:developer';

import 'package:applovin_max/applovin_max.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'build_constants.dart';
import 'src/presentation/app/app_binding.dart';
import 'src/presentation/router/app_page.dart';
import 'src/presentation/router/app_router.dart';
import 'src/presentation/theme/app_theme.dart';
import 'src/resource/string/app_string.dart';
import 'src/utils/app_constant.dart';
import 'src/utils/app_log.dart';
import 'src/utils/remote_config.dart';
import 'src/utils/share_preference_utils.dart';

bool isConsent = false;
RxString currentRoute = "".obs;

void initMobileAds() {
  isConsent = true;
  MobileAds.instance.initialize();
  if (BuildConstants.currentEnvironment == Environment.dev) {
    MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(
        testDeviceIds: [
          '7B7C627E3DE55970E7914303C2E80C3F',
          '1D7D18F00DFC0E2B661500A1103C9D6F',
          'C3930ECE57262F8BD4126E821DBF8816',
          '0FD601F89035818170EC66E7728A95B2',
        ],
      ),
    );
  }
}

void loadForm() {
  ConsentForm.loadConsentForm(
    (ConsentForm consentForm) async {
      var status = await ConsentInformation.instance.getConsentStatus();
      if (status == ConsentStatus.required) {
        consentForm.show(
          (FormError? formError) {
            // Handle dismissal by reloading form
            loadForm();
          },
        );
      } else if (status == ConsentStatus.obtained) {
        initMobileAds();
      }
    },
    (formError) {
      // Handle the error
      log("Form error: ${formError.message}");
    },
  );
}

Future<void> requestConsent() async {
  if (await ConsentInformation.instance.getConsentStatus() !=
      ConsentStatus.required) {
    initMobileAds();
  }

  // await ConsentInformation.instance.reset();

  ConsentInformation.instance.requestConsentInfoUpdate(
    ConsentRequestParameters(
        consentDebugSettings: ConsentDebugSettings(
      testIdentifiers: [
        "7B7C627E3DE55970E7914303C2E80C3F",
        "C3930ECE57262F8BD4126E821DBF8816",
      ],
    )),
    () async {
      bool available =
          await ConsentInformation.instance.isConsentFormAvailable();
      if (available) {
        loadForm();
      }
    },
    (error) {
      AppLog.debug(error.message, tag: "ConsentInformation Error");
    },
  );
}

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
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //   apiKey: "AIzaSyA5UTS_7SBeQf7xSnWwoWBT6m-55-PteFw",
      //   appId: "1:424647934230:android:8c6b43366d0d591c369037",
      //   messagingSenderId: "",
      //   projectId: "watch-w-and-b-gallery",
      // ),
      );
  await RemoteConfig.init();

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
