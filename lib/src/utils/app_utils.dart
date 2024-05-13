import 'dart:io';

import 'package:ar_drawing/src/presentation/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../presentation/theme/app_color.dart';
import '../presentation/widget/rate/rating_dialog.dart';

bool hasMatch(String? s, String p) {
  return (s == null) ? false : RegExp(p).hasMatch(s);
}

void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: AppColor.black.withOpacity(0.9),
    textColor: AppColor.white,
    fontSize: 16.0,
  );
}

Color getColorFromHex(String hexColor, {Color? defaultColor}) {
  if (hexColor.isEmpty) {
    if (defaultColor != null) {
      return defaultColor;
    } else {
      throw ArgumentError('Can not parse provided hex $hexColor');
    }
  }

  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}

bool isNullEmpty(Object? o) => o == null || "" == o || o == "null";

String getTime() {
  int hour = DateTime.now().hour;
  int minute = DateTime.now().minute;

  return "${hour >= 10 ? hour : '0$hour'}:${minute >= 10 ? minute : '0$minute'}";
}

// String chooseContentByLanguage(String enContent, String viContent) {
//   if (Get.find<AppController>().currentLocale.toLanguageTag() == 'vi-VN' && viContent.isNotEmpty) return viContent;
//   return enContent.isNotEmpty ? enContent : viContent;
// }

String degreesToDirection(int num) {
  if (num == -1) {
    return '';
  }

  return [
    "N",
    "NNE",
    "NE",
    "ENE",
    "E",
    "ESE",
    "SE",
    "SSE",
    "S",
    "SSW",
    "SW",
    "WSW",
    "W",
    "WNW",
    "NW",
    "NNW"
  ][(((num / 22.5) + 0.5).floor() % 16)];
}

int calculateAIQ(double c) {
  int il = 0;
  int ih = 50;
  int cl = 0;
  int ch = 12;

  if (c <= 12) {
    il = 0;
    ih = 50;
    cl = 0;
    ch = 12;
  } else if (c > 12 && c <= 35) {
    il = 51;
    ih = 100;
    cl = 13;
    ch = 35;
  } else if (c > 35 && c <= 55) {
    il = 101;
    ih = 150;
    cl = 36;
    ch = 55;
  } else if (c > 55 && c <= 150) {
    il = 151;
    ih = 200;
    cl = 56;
    ch = 150;
  } else if (c > 150 && c <= 250) {
    il = 201;
    ih = 300;
    cl = 151;
    ch = 250;
  } else if (c > 250 && c <= 350) {
    il = 301;
    ih = 400;
    cl = 251;
    ch = 350;
  } else if (c > 350) {
    il = 351;
    ih = 500;
    cl = 401;
    ch = 500;
  }

  return (((ih - il) / (ch - cl)) * (c - cl) + il).round();
}

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

Future<void> showRateDialog(BuildContext context) async {
  if (Platform.isIOS) {
    return Future.value();
  }

  if (!Get.find<AppController>().isFirstRate) {
    return Future.value();
  }

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return const RatingDialog();
    },
  );
}
