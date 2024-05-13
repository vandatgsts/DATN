import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/more_app_item.dart';
import 'app_image.dart';

const String urlPrivacy = "https://sites.google.com/view/vietapps/policy-privacy";
const String urlTerm = "https://sites.google.com/view/vietapps/terms-condition";
const String urlContact = "https://sites.google.com/view/vietapps/contact";

const List<String> listNotificationContent = [
  "Check out the cute pups and get ready for a day of sunshine! 🐾",
  "Open to discover a fluffy friend and stay informed about the weather. 🐶",
  "A furry friend ready to brighten up your rainy day! 🌧️🐾",
  "Your furry forecast is just a tap away. 😺❄️",
  "🌞🐕 Dive into our app to find today's sunny companion and get the latest weather updates.",
  "Adorable puppies are waiting for your visit with today weather forecast!",
  "Check out now before taking your puppies out for a run🐕",
  "Discover a playful puppy on our app and get the scoop on the weather.",
];

class AppConstant {
  AppConstant._();

  static final availableLocales = [
    const Locale('en'),
  ];

  static final dateTimeFormatCommon = DateFormat('HH:mm dd/MM/yyyy');

  static const double defaultLatitude = 21.028511;
  static const double defaultLongitude = 105.804817;
  static const int defaultEdgeLv = 3;
  static const double defaultNoise = 3.5;
  static const double defaultMaxNoise = 5;
  static const double defaultMaxEdgeLv = 11;

  static const String keySubWeek = "com.ar.draw.sketch.paint.trace.week";
  static const String keySubMonth = "com.ar.draw.sketch.paint.trace.month";
  static const String keySubYear = "com.ar.draw.sketch.paint.trace.year";
  // static const String keySubLifetime =
  //     "com.temperature.thermometer.pet.lifetime";
  static const String keySubTemp = "com.ar.draw.sketch.paint.trace.temp";

  static const Set<String> setKeyIAP = {
    keySubWeek,
    keySubMonth,
    keySubYear,
    keySubTemp,
  };

//
// static List<LanguageModel> listLanguage = [
//   LanguageModel(
//     icPath: AppImage.icEnglish,
//     locale: const Locale('en'),
//     name: "English",
//   ),
// ];
//
  static List<MoreAppItem> listAndroidMoreApp = [
    MoreAppItem(
      idAndroidApp: "com.vietapps.thermometer",
      idIosApp: "",
      title: "Smart thermometer for room",
      subText:
          "Check Indoor/ Outdoor Temperature by Thermometer for room, weather or humidity",
      icPath: AppImage.maa_thermometer,
    ),
    MoreAppItem(
      idAndroidApp: "com.vietapps.watchface",
      idIosApp: "",
      title: "Watch Faces Wallpaper Gallery",
      subText:
          "Style up your watch faces with many live wallpapers! Instant, Set up with 1 TAP!",
      icPath: AppImage.maa_watchface,
    ),
    MoreAppItem(
      idAndroidApp: "com.infinity.nfctools",
      idIosApp: "",
      title: "NFC writer- Read nfc & QR code",
      subText:
          "Read NFC, write and program all tasks on your NFC tag with +100 tasks available.",
      icPath: AppImage.maa_nfc,
    ),
    MoreAppItem(
      idAndroidApp: "com.temperature.weather.thermometer.pet",
      idIosApp: "",
      title: "Weather Dog: Check Temperature",
      subText:
          "Cute Cats, Puppies wallpaper will make you smile while checking weather forecast.",
      icPath: AppImage.maa_pet,
    ),
    MoreAppItem(
      idAndroidApp: "com.va.find.phone.clap.whistle",
      idIosApp: "",
      title: "Find My Phone By Clap- Whistle",
      subText:
          "Clap to trigger ringtone, vibration , flashlight or Whistle to find your phone.",
      icPath: AppImage.maa_find_phone,
    ),
    MoreAppItem(
      idAndroidApp: "com.vietapps.numerology.thansohoc",
      idIosApp: "",
      title: "Psychic: Numerology & Tarot",
      subText:
          "Predict your life path with number pattern, horoscope, zodiac and dream meanings.",
      icPath: AppImage.maa_numerology,
    ),
    MoreAppItem(
      idAndroidApp: "ccom.hiennguyen.unitconverter",
      idIosApp: "",
      title: "Unit Converter Tools- Exchange",
      subText:
          "Measurement converter, Currency converter, exchange rate, Metric conversion tool.",
      icPath: AppImage.maa_unit,
    ),
    MoreAppItem(
      idAndroidApp: "com.hiennguyen.hiddencamera",
      idIosApp: "",
      title: "AntiSpy Hidden camera detector",
      subText:
          "Pro Bug detector will help you detect hidden spy camera with spy camera detector.",
      icPath: AppImage.maa_hidden_camera,
    ),
    MoreAppItem(
      idAndroidApp: "com.weather.travel",
      idIosApp: "",
      title: "Roadtrip weather Route planner",
      subText:
          "Travel weather app with accuracy forecast to avoid severe weather conditions.",
      icPath: AppImage.maa_travel,
    ),
    MoreAppItem(
      idAndroidApp: "com.hiennguyen.ai.chatbot",
      idIosApp: "",
      title: "AskAI ChatBot: Smart Assistant",
      subText:
          "Instant Answers from Smart ChatBot AI Assistant & AI Character Famous Person.",
      icPath: AppImage.maa_chatbot,
    ),
    MoreAppItem(
      idAndroidApp: "com.vietapps.weatherlive",
      idIosApp: "",
      title: "Thermometer Check Temperature",
      subText:
          "Check Temperature by Smart Thermometer for room. Check room temperature and more.",
      icPath: AppImage.maa_weather2,
    ),
    MoreAppItem(
      idAndroidApp: "com.vietapps.airquality",
      idIosApp: "",
      title: "Breathe: Air quality & pollen",
      subText:
          "Accuracy Air pollution tracker, seasonal allergic management, UV index forecast.",
      icPath: AppImage.maa_air_quality,
    ),
    MoreAppItem(
      idAndroidApp: "com.hiennguyen.bible",
      idIosApp: "",
      title: "Daily Bible Trivia Challenge",
      subText:
          "Recall the word of God from the Holy Bible with over 1000+ quiz and 100+ levels.",
      icPath: AppImage.maa_bibble,
    ),
    MoreAppItem(
      idAndroidApp: "com.vietapps.motivation",
      idIosApp: "",
      title: "I am Motivation -Habit Tracker",
      subText:
          "Start self care with Gratitude Affirmations, Goal tracker, Inspirational quotes.",
      icPath: AppImage.maa_motivation,
    ),
    MoreAppItem(
      idAndroidApp: "com.vietapps.multiscanner",
      idIosApp: "",
      title: "QR Reader & MRZ, NFC Reader",
      subText:
          "Scan- decode all QR codes/ Barcodes & read data on MRZ, NFC tag by NFC reader.",
      icPath: AppImage.maa_qrcode,
    ),
    MoreAppItem(
      idAndroidApp: "com.vietapps.umeme",
      idIosApp: "",
      title: "uMeme - Troll Meme Creator",
      subText: "Meme Creator, Maker, Troll, Share And Be Fun.",
      icPath: AppImage.maa_meme,
    ),
  ];

  static List<MoreAppItem> listIosMoreApp = [
    MoreAppItem(
      idAndroidApp: "",
      idIosApp: "id6449184873",
      title: "Luxury Watch Faces Gallery Pro",
      subText:
          "100,000 Live wallpapers & ultra watch faces albums compatible with all apple watch series updated every week to custom.",
      icPath: AppImage.mai_watchface,
    ),
    MoreAppItem(
      idAndroidApp: "",
      idIosApp: "id1670239220",
      title: "Thermometer- Check temperature",
      subText:
          "Track current weather condition with the new live NOAA Weather Radar features with weather forecast for temperature, hurricane, storm tracker. Indoor thermometer included.",
      icPath: AppImage.mai_thermometer,
    ),
    MoreAppItem(
      idAndroidApp: "",
      idIosApp: "id6449696184",
      title: "Hidden Camera Finder for room",
      subText:
          "Protect your Privacy from Hidden camera at your home and hotels while traveling with this Hidden Camera Finder for room.",
      icPath: AppImage.mai_spycam,
    ),
    MoreAppItem(
      idAndroidApp: "",
      idIosApp: "id6446508641",
      title: "Smart NFC tools - RFID scanner",
      subText:
          "Start automating daily boring repetitive tasks with Smart NFC tools - RFID scanner. Easy for new users to write and read NFC card, chip & Stickers with unlimited storage.",
      icPath: AppImage.mai_nfc,
    ),
    MoreAppItem(
      idAndroidApp: "",
      idIosApp: "id6473981989",
      title: "Smart Ask AI Chatbot Assistant",
      subText:
          "Make your daily life easier with the power of artificial intelligence from ChatGPT to write email, essays, do math, etc.",
      icPath: AppImage.mai_chatbot,
    ),
    MoreAppItem(
      idAndroidApp: "",
      idIosApp: "id6472239908",
      title: "Speedometer: HUD Speed Tracker",
      subText:
          "Avoid speed ticket with real-time GPS Speedometer, Windshield HUD speedometer, journey statistic with mph kmh speedometer, accelerometer, top speed & average speed option.",
      icPath: AppImage.mai_speedometer,
    ),
    MoreAppItem(
      idAndroidApp: "",
      idIosApp: "id6448509515",
      title: "Heart Rate Monitor: Pulse & BP",
      subText:
          "Protect your health and track your health vitality, blood pressure, blood glucose and heartbeat (pulse) with daily journal, blood pressure diary and heart rate monitor.",
      icPath: AppImage.mai_heart,
    ),
    MoreAppItem(
      idAndroidApp: "",
      idIosApp: "id6446268145",
      title: "Ways - A better RoutePlanner",
      subText:
          "Embark on a seamless journey with AI ChatBot Assistant to plan your trip. The AI ChatBot Assistant is powered by ChatGPT & designed to elevate your travel experience.",
      icPath: AppImage.mai_travel,
    ),
    MoreAppItem(
      idAndroidApp: "",
      idIosApp: "id6458101940",
      title: "Units Plus- Currency Converter",
      subText:
          "All-in-one Unit converter with currency converter including all measurement converter to convert units like length, speed.",
      icPath: AppImage.mai_unit,
    ),
    MoreAppItem(
      idAndroidApp: "",
      idIosApp: "id6450589828",
      title: "Daily Bible Trivia Bible Quiz",
      subText:
          "Daily Bible Verse to Study the KJV Bible King James Version with Over 1000+ Bible quiz & Daily Bible Trivia for believer.",
      icPath: AppImage.mai_bibble,
    ),
    MoreAppItem(
      idAndroidApp: "",
      idIosApp: "id1671558516",
      title: " Dynamics Pixel Pets for 14 pro",
      subText:
          "Customize your dynamic island with 9 exclusive Pixel Pets. Put them on the lock screen widget to Feed & play with your virtual friends anytime you want! Only for iOS 16.",
      icPath: AppImage.mai_pet,
    ),
  ];
}

class AppExternalUrl {
  AppExternalUrl._();

  static const String privacy = 'https://appvillage.com.vn/privacy.txt';
  static const String termsAndConditions =
      'https://appvillage.com.vn/privacy.txt';
  static const String contactUs =
      "https://sites.google.com/view/spy-hidden-cameras-detector/contact";
}

class AppKeyPreference {
  AppKeyPreference._();

  static const String keyFirstOpenApp = "first_open_app";

  // static const String keyListFavorite = "list_favorite";
  static const String keyCountRecord = "cnt_record";
  static const String keyCountPrint = "cnt_print";
  static const String keyCntUserAddImage = "cnt_user_add_image";
}
