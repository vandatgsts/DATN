import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColor.primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primaryColor,
      outlineVariant: AppColor.borderColor,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.textTheme(AppColor.primaryColor),
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.black,
    dividerColor: AppColor.borderColor,
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white),
      fillColor: MaterialStateProperty.all(Colors.white),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColor.primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primaryColor,
      outlineVariant: AppColor.borderColor.withOpacity(0.4),
    ),
    scaffoldBackgroundColor: AppColor.scaffoldColorDark,
    textTheme: AppTextTheme.textTheme(AppColor.primaryColor),
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.black,
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white),
      fillColor: MaterialStateProperty.all(Colors.white),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
