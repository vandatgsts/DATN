import 'package:ar_drawing/src/resource/string/spanish_strings.dart';
import 'package:get/get.dart';

import 'english_strings.dart';
import 'french_strings.dart';
import 'germany_strings.dart';
import 'hindi_strings.dart';
import 'indo_strings.dart';
import 'japan_strings.dart';
import 'portuguese_strings.dart';

class AppString extends Translations {
  static const String localeCodeEn = 'en_US';
  static const String localeCodeHi = 'hi_IN';
  static const String localeCodeEs = 'es_ES';
  static const String localeCodeFr = 'fr_FR';
  static const String localeCodePt = 'pt_PT';
  static const String localeCodeJa = 'ja_JP';
  static const String localeCodeId = 'id_ID';
  static const String localeCodeDe = 'de_DE';

  @override
  Map<String, Map<String, String>> get keys => {
        localeCodeEn: englishString,
        localeCodeHi: hindiString,
        localeCodeEs: spanishString,
        localeCodeFr: frenchString,
        localeCodePt: portugueseString,
        localeCodeJa: japaneseString,
        localeCodeId: indonesiaString,
        localeCodeDe: germanyString,
      };

  static String getString(String key) {
    Map<String, String> selectedLanguage = _getMapString();
    String text = key;
    if (selectedLanguage.containsKey(key) && selectedLanguage[key] != null) {
      text = selectedLanguage[key] ?? key;
    }

    return text;
  }

  static Map<String, String> _getMapString() {
    switch (Get.locale.toString()) {
      case localeCodeHi:
        return hindiString;

      case localeCodeEs:
        return spanishString;

      case localeCodeFr:
        return frenchString;

      case localeCodePt:
        return portugueseString;

      case localeCodeJa:
        return japaneseString;

      case localeCodeId:
        return indonesiaString;

      case localeCodeDe:
        return germanyString;

      default:
        return englishString;
    }
  }
}

class StringConstants {
  static const String unknownError = "unknown_error";
  static const String noInternet = "no_internet";
  static const String notAvailable = "not_available";
  static const String canNotConnectStore = "can_not_connect_store";
  static const String purchaseFail = "purchase_fail";
  static const String setting = "setting";
  static const String more = "more";
  static const String moreApp = "more_app";
  static const String privacyPolicy = "privacy_policy";
  static const String termOfCondition = "term_of_condition";
  static const String termsOfService = "term_of_service";
  static const String contactUs = "contact_us";
  static const String restore = "restore";
  static const String close = "close";
  static const String notice = "notice";
  static const String continues = "continues";
  static String rate = "rate";
  static String subRate = 'sub_rate';
  static const String loadingAd = "loading_ad";
  static const String loading = "loading";
  static const String continue1 = "continue1";
  static const String language = "language";
  static const String english = "english";
  static const String cancel = "cancel";
  static const String ok = "OK";
  static const String no = "no";
  static const String yes = "yes";
  static const String wantExit = "want_exit";
  static const String draw = "draw";
  static const String preview = "preview";
  static const String print = "print";

  static const String intro1_1 = "intro1_1";
  static const String intro1_2 = "intro1_2";
  static const String intro1_3 = "intro1_3";
  static const String intro2_1 = "intro2_1";
  static const String intro2_2 = "intro2_2";
  static const String intro2_3 = "intro2_3";
  static const String intro3_1 = "intro3_1";
  static const String intro3_2 = "intro3_2";
  static const String intro3_3 = "intro3_3";
  static const String intro4_1 = "intro4_1";
  static const String intro4_2 = "intro4_2";
  static const String intro4_3 = "intro4_3";

  static const String goPremium = "goPremium";

  static const String term = "term";
  static const String privacy = "privacy";
  static const String contact = "contact";
  static const String arDraw = "arDraw";
  static const String pro = "pro";
  static const String trace = "trace";
  static const String sketch = "sketch";
  static const String subContent1 = "subContent1";
  static const String subContent2 = "subContent2";
  static const String subContent3 = "subContent3";
  static const String subContent4 = "subContent4";
  static const String lifeTime = "lifeTime";
  static const String yearly = "yearly";
  static const String monthly = "monthly";
  static const String weekly = "weekly";
  static const String week = "week";
  static const String only = "only";
  static const String lifeTimeContent = "lifeTimeContent";
  static const String bestSeller = "bestSeller";
  static const String save = "save";
  static const String share = "share";
  static const String txtContinue = "txtContinue";
  static const String security = "security";
  static const String txtReturn = "return";
  static const String connect = "connect";
  static const String album = "album";
  static const String noData = "no_data";
  static const String denyCamera = "deny_camera";
  static const String openSettings = "open_settings";
  static const String pleaseWait = "please_wait";
  static const String videoNotSupport = "video_not_support";
  static const String style = "style";
  static const String stroke = "stroke";
  static const String original = "original";
  static const String opacity = "opacity";
  static const String edgeLevel = "edge_level";
  static const String noise = "noise";
  static const String tools = "tools";
  static const String photo = "photo";
  static const String record = "record";
  static const String level = "level";
  static const String beginner = "beginner";
  static const String intermediate = "intermediate";
  static const String advanced = "advanced";
  static const String seeAll = "see_all";
  static const String letStart = "let_start";
  static const String subBanner1 = "sub_banner_1";
  static const String subBanner2 = "sub_banner_2";
  static const String subBanner3 = "sub_banner_3";
  static const String subBanner4 = "sub_banner_4";
  static const String subBanner5 = "sub_banner_5";
  static const String uploadIllus = "upload_illus";
  static const String myAlbum = "my_album";
  static const String howToUse = "how_to_use";
  static const String next = "next";
  static const String saveSuccess = "save_success";
  static const String saveFail = "save_fail";
  static const String shareSuccess = "share_success";
  static const String shareFail = "share_fail";
  static const String contentLoadingAds = "content_loading_ads";
  static const String camera = "camera";
  static const String subRate12 = "sub_rate_12";
  static const String subRate3 = "sub_rate_3";
  static const String subRate4 = "sub_rate_4";
  static const String subRate5 = "sub_rate_5";

  static const String error = "error";
  static const String checkInternetConnection = "check_internet_connection";
  static const String retry = "retry";
  static const String choosePhoto = "choose_photo";
  static const String choosePhotoWarning = "choose_photo_warning";
  static const String exitApp = "exit_app";
  static const String exitAppContent = "exit_app_content";
  static const String exit = "exit";
  static const String printContent = "print_content";
  static const String denyStorage = "deny_storage";
  static const String permission = "permission";
  static const String contentPermission = "contentPermission";
  static const String micro = "micro";
  static const String storage = "storage";
}
