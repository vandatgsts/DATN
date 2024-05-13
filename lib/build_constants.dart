import 'dart:io';

enum Environment { dev, prod }

class BuildConstants {
  static Map<String, dynamic> _config = _Config.devConstants;
  static var currentEnvironment = Environment.dev;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.prod:
        _config = _Config.prodConstants;
        currentEnvironment = Environment.prod;
        break;

      case Environment.dev:
        _config = _Config.devConstants;
        currentEnvironment = Environment.dev;
        break;
    }
  }

  static get serverAPI {
    return _config[_Config.serverApi];
  }

  static get serverTYPE {
    return _config[_Config.serverType];
  }

  static get keyGoogleMap {
    return _config[_Config.keyGoogleMap];
  }

  static get idGoogleBannerAd {
    return Platform.isAndroid
        ? _config[_Config.idGoogleBannerAdAndroidKey]
        : _config[_Config.idGoogleBannerAdIosKey];
  }

  static get idGoogleBannerHighAd {
    return Platform.isAndroid
        ? _config[_Config.idGoogleBannerHighAdAndroidKey]
        : _config[_Config.idGoogleBannerHighAdIosKey];
  }

  static get idGoogleManagerBannerAd {
    return Platform.isAndroid
        ? _config[_Config.idGoogleManagerBannerAdAndroidKey]
        : _config[_Config.idGoogleManagerBannerAdIosKey];
  }

  static get idGoogleInterstitialAd {
    return Platform.isAndroid
        ? _config[_Config.idGoogleInterstitialAdAndroidKey]
        : _config[_Config.idGoogleInterstitialAdIosKey];
  }

  static get idGoogleOpenAppAd {
    return Platform.isAndroid
        ? _config[_Config.idGoogleOpenAppAdAndroidKey]
        : _config[_Config.idGoogleOpenAppAdIosKey];
  }

  static get idGoogleNativeAd {
    return Platform.isAndroid
        ? _config[_Config.idGoogleNativeAdAndroidKey]
        : _config[_Config.idGoogleNativeAdIosKey];
  }

  static get idInterstitialAdMax {
    return _config[_Config.idInterstitialAdMax];
  }

  static get idNativeAdMax {
    return _config[_Config.idNativeAdMax];
  }

  static get appLovinToken {
    return _config[_Config.appLovinTokenKey];
  }
}

class _Config {
  static const serverApi = "SERVER_API";
  static const serverType = "SERVER_TYPE";
  static const keyGoogleMap = "googleMap";

  static const idGoogleBannerAdAndroidKey = "idGoogleBannerAdAndroidKey";
  static const idGoogleBannerAdIosKey = "idGoogleBannerAdIosKey";
  static const idGoogleBannerHighAdAndroidKey =
      "idGoogleBannerHighAdAndroidKey";
  static const idGoogleBannerHighAdIosKey = "idGoogleBannerHighAdIosKey";
  static const idGoogleManagerBannerAdAndroidKey =
      "idGoogleManagerBannerAdAndroidKey";
  static const idGoogleManagerBannerAdIosKey = "idGoogleManagerBannerAdIosKey";

  static const idGoogleInterstitialAdAndroidKey =
      "idGoogleInterstitialAdAndroidKey";
  static const idGoogleInterstitialAdIosKey = "idGoogleInterstitialAdIosKey";

  static const idGoogleOpenAppAdAndroidKey = "idGoogleOpenAppAdAndroidKey";
  static const idGoogleOpenAppAdIosKey = "idGoogleOpenAppAdIosKey";

  static const idGoogleNativeAdAndroidKey = "idGoogleNativeAdAndroidKey";
  static const idGoogleNativeAdIosKey = "idGoogleNativeAdIosKey";

  static const idInterstitialAdMax = "idInterstitialAdMax";
  static const idNativeAdMax = "idNativeAdMax";

  static const appLovinTokenKey = "appLovinTokenKey";

  static Map<String, dynamic> prodConstants = {
    serverApi: "http://8.9.31.66:9015",
    serverType: "Prod",
    keyGoogleMap: "AIzaSyC8CEwmuFyCgRbZEJjNNaLJ0CyTPhZN9wk",
    idGoogleBannerAdAndroidKey: "ca-app-pub-5294836995166944/1114671850",
    idGoogleBannerAdIosKey: "ca-app-pub-5294836995166944/2093462636",
    idGoogleBannerHighAdAndroidKey: "ca-app-pub-5294836995166944/1114671850",
    idGoogleBannerHighAdIosKey: "ca-app-pub-5294836995166944/3622962882",
    idGoogleManagerBannerAdAndroidKey: "",
    idGoogleManagerBannerAdIosKey: "",
    idGoogleInterstitialAdAndroidKey: "ca-app-pub-5294836995166944/7955751684",
    idGoogleInterstitialAdIosKey: "ca-app-pub-5294836995166944/4894134760",
    idGoogleOpenAppAdAndroidKey: "ca-app-pub-5294836995166944/8202824382",
    idGoogleOpenAppAdIosKey: "ca-app-pub-5294836995166944/4670773480",
    idGoogleNativeAdAndroidKey: "ca-app-pub-5294836995166944/7660717144",
    idGoogleNativeAdIosKey: "ca-app-pub-5294836995166944/9077261669",
    idInterstitialAdMax: "65fb311e2ce59420",
    idNativeAdMax: "27a582fe0e8d0d2b",
    appLovinTokenKey:
        "bHNo9I54UFEXQysIBS4ouIwd-5ztx_Cmc5NFCgT5CnTRzABi5RemvpybCuW1ViIlFBGoFpXdR42dm6qA3g8tCz",
  };

  static Map<String, dynamic> devConstants = {
    serverApi: "http://8.9.31.66:9015",
    serverType: "Dev",
    keyGoogleMap: "AIzaSyC8CEwmuFyCgRbZEJjNNaLJ0CyTPhZN9wk",
    idGoogleBannerAdAndroidKey: "ca-app-pub-3940256099942544/9214589741",
    idGoogleBannerHighAdAndroidKey: "ca-app-pub-3940256099942544/9214589741",
    idGoogleBannerAdIosKey: "ca-app-pub-3940256099942544/2934735716",
    idGoogleBannerHighAdIosKey: "ca-app-pub-3940256099942544/2934735716",
    idGoogleOpenAppAdAndroidKey: "ca-app-pub-3940256099942544/9257395921",
    idGoogleOpenAppAdIosKey: "ca-app-pub-3940256099942544/5575463023",
    idGoogleInterstitialAdAndroidKey: "ca-app-pub-3940256099942544/1033173712",
    idGoogleInterstitialAdIosKey: "ca-app-pub-3940256099942544/4411468910",
    idGoogleNativeAdAndroidKey: "ca-app-pub-3940256099942544/2247696110",
    idGoogleNativeAdIosKey: "ca-app-pub-3940256099942544/3986624511",
    idGoogleManagerBannerAdAndroidKey: "/6499/example/banner",
    idGoogleManagerBannerAdIosKey: "/112517806,23029659100/1171701332955",
    idInterstitialAdMax: "65fb311e2ce59420",
    idNativeAdMax: "27a582fe0e8d0d2b",
    appLovinTokenKey:
        "bHNo9I54UFEXQysIBS4ouIwd-5ztx_Cmc5NFCgT5CnTRzABi5RemvpybCuW1ViIlFBGoFpXdR42dm6qA3g8tCz",
  };
}
