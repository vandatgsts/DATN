import 'package:shared_preferences/shared_preferences.dart';

import 'app_log.dart';

class PreferenceUtils {
  static final PreferenceUtils _instance = PreferenceUtils._internal();

  factory PreferenceUtils() => _instance;

  PreferenceUtils._internal();

  static late final SharedPreferences _sharedPreferences;

  // call this method from iniState() function of mainApp().
  static Future<void> init() async {
    AppLog.info("Share preference init");

    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// sets
  static Future<bool> setBool(String key, bool value) async {
    final answer = await _sharedPreferences.setBool(key, value);

    if (answer) {
      AppLog.debug(
        "set bool success: [$value] -> [$key]",
        tag: "Set $key",
      );
    } else {
      AppLog.debug(
        "set bool fail",
        tag: "Set $key",
      );
    }

    return answer;
  }

  static Future<bool> setDouble(String key, double value) async {
    final answer = await _sharedPreferences.setDouble(key, value);

    if (answer) {
      AppLog.debug(
        "set double success: [$value] -> [$key]",
        tag: "Set $key",
      );
    } else {
      AppLog.debug(
        "set double fail",
        tag: "Set $key",
      );
    }

    return answer;
  }

  static Future<bool> setInt(String key, int value) async {
    final answer = await _sharedPreferences.setInt(key, value);

    if (answer) {
      AppLog.debug(
        "set int success: [$value] -> [$key]",
        tag: "Set $key",
      );
    } else {
      AppLog.debug(
        "set int fail",
        tag: "Set $key",
      );
    }

    return answer;
  }

  static Future<bool> setString(String key, String value) async {
    final answer = await _sharedPreferences.setString(key, value);

    if (answer) {
      AppLog.debug(
        "set string success: [$value] -> [$key]",
        tag: "Set $key",
      );
    } else {
      AppLog.debug(
        "[$key] -> [$value] fail",
        tag: "Set $key",
      );
    }

    return answer;
  }

  static Future<bool> setStringList(String key, List<String> value) async =>
      await _sharedPreferences.setStringList(key, value);

  /// gets
  static bool? getBool(String key) {
    if (_sharedPreferences.containsKey(key)) {
      bool? answer = _sharedPreferences.getBool(key);

      if (answer == null) {
        AppLog.debug("Get bool fails", tag: "Get $key");
      } else {
        AppLog.debug("Get bool: $answer", tag: "Get $key");
      }

      return answer;
    } else {
      AppLog.debug("Not contain key", tag: "Get $key");

      return null;
    }
  }

  static double? getDouble(String key) {
    if (_sharedPreferences.containsKey(key)) {
      double? answer = _sharedPreferences.getDouble(key);

      if (answer == null) {
        AppLog.debug("Get double fails", tag: "Get $key");
      } else {
        AppLog.debug("Get double: $answer", tag: "Get $key");
      }

      return answer;
    } else {
      AppLog.debug("Not contain key", tag: "Get $key");

      return null;
    }
  }

  static int? getInt(String key) {
    if (_sharedPreferences.containsKey(key)) {
      int? answer = _sharedPreferences.getInt(key);

      if (answer == null) {
        AppLog.debug("Get int fails", tag: "Get $key");
      } else {
        AppLog.debug("Get int: $answer", tag: "Get $key");
      }

      return answer;
    } else {
      AppLog.debug("Not contain key", tag: "Get $key");

      return null;
    }
  }

  static String? getString(String key) {
    if (_sharedPreferences.containsKey(key)) {
      String? answer = _sharedPreferences.getString(key);

      if (answer == null) {
        AppLog.debug("Get string fails", tag: "Get $key");
      } else {
        AppLog.debug("Get string: $answer", tag: "Get $key");
      }

      return answer;
    } else {
      AppLog.debug("Not contain key", tag: "Get $key");

      return null;
    }
  }

  static List<String>? getStringList(String key) {
    if (_sharedPreferences.containsKey(key)) {
      List<String>? answer = _sharedPreferences.getStringList(key);

      if (answer == null) {
        AppLog.debug("Get string fails", tag: "Get $key");
      } else {
        AppLog.debug("Get string: $answer", tag: "Get $key");
      }

      return answer;
    } else {
      AppLog.debug("Not contain key", tag: "Get $key");

      return null;
    }
  }

  /// delete
  static Future<bool> remove(String key) async =>
      await _sharedPreferences.remove(key);

  static Future<bool> clear() async => await _sharedPreferences.clear();
}
