import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../build_constants.dart';

class RemoteConfig {
  static final RemoteConfig _instance = RemoteConfig._internal();

  factory RemoteConfig() => _instance;

  RemoteConfig._internal();

  static late final FirebaseRemoteConfig remoteConfig;

  static const String _keyCollapseAdsGAMOB = "collapse_ads_gamob";
  static const String _keyCollapseAdsHigh = "collapse_ads_admob";
  static const String _keyCollapseAll = "collapse_all";
  static const String _keyIntersAds = "inters_max_ads";
  static const String _keyNativeAds = "native_max_ads";
  static const String _keyOpenAds = "open_max_ads";
  static const String _keyRewardsAds = "rewards_max_ads";

  static const String _keyIntersAdmobAds = "inters_admob_ads";
  static const String _keyNativeAdmobAds = "native_admob_ads";
  static const String _keyOpenAdmobAds = "open_admob_ads";
  static const String _keyRewardsAdmobAds = "rewards_admob_ads";

  static const String _keyShowInter = "show_inter";
  static const String _keyShowBanner = "show_banner";
  static const String _keyShowNative = "show_native";

  static Future<void> init() async {
    remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(minutes: 1),
      ),
    );

    await remoteConfig.setDefaults(
      <String, dynamic>{
        'inters_capping': 20,
        _keyShowInter: true,
        _keyShowBanner: true,
        _keyShowNative: true,
        _keyCollapseAdsGAMOB: BuildConstants.idGoogleManagerBannerAd,
        _keyCollapseAdsHigh: BuildConstants.idGoogleBannerHighAd,
        _keyCollapseAll: BuildConstants.idGoogleBannerAd,
        _keyIntersAdmobAds: BuildConstants.idGoogleInterstitialAd,
        _keyNativeAdmobAds: BuildConstants.idGoogleNativeAd,
        _keyOpenAdmobAds: BuildConstants.idGoogleOpenAppAd,
      },
    );

    // RemoteConfigValue(null, ValueSource.valueDefault);
     remoteConfig.fetchAndActivate();
  }

  static int getIntersCapping() {
    return remoteConfig.getInt("inters_capping");
  }

  static String getCollapseAdsGAMOBKey() {
    return remoteConfig.getString(_keyCollapseAdsGAMOB);
  }

  static String getCollapseAdsHighKey() {
    return remoteConfig.getString(_keyCollapseAdsHigh);
  }

  static String getCollapseAllKey() {
    return remoteConfig.getString(_keyCollapseAll);
  }

  static String getIntersAdsKey() {
    return remoteConfig.getString(_keyIntersAds);
  }

  static String getNativeAdsKey() {
    return remoteConfig.getString(_keyNativeAds);
  }

  static String getOpenAdsKey() {
    return remoteConfig.getString(_keyOpenAds);
  }

  static String getRewardsAdsKey() {
    return remoteConfig.getString(_keyRewardsAds);
  }

  static String getIntersAdmobAds() {
    return remoteConfig.getString(_keyIntersAdmobAds);
  }

  static String getNativeAdmobAds() {
    return remoteConfig.getString(_keyNativeAdmobAds);
  }

  static String getOpenAdmobAds() {
    return remoteConfig.getString(_keyOpenAdmobAds);
  }

  static String getRewardAdmobAds() {
    return remoteConfig.getString(_keyRewardsAdmobAds);
  }

  static bool getShowInter() {
    return remoteConfig.getBool(_keyShowInter);
  }

  static bool getShowBanner() {
    return remoteConfig.getBool(_keyShowBanner);
  }
  static bool getShowNative() {
    return remoteConfig.getBool(_keyShowNative);
  }
}
