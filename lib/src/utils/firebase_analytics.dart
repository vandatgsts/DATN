import 'package:firebase_analytics/firebase_analytics.dart';

import 'app_log.dart';

class AppFirebaseAnalytics {
  static final AppFirebaseAnalytics instance = AppFirebaseAnalytics._init();

  static FirebaseAnalytics? _firebaseAnalytics;

  AppFirebaseAnalytics._init();

  FirebaseAnalytics get firebaseAnalytics {
    if (_firebaseAnalytics != null) return _firebaseAnalytics!;
    return FirebaseAnalytics.instance;
  }

  void logEvent({
    required String name,
    Map<String, dynamic>? parameters,
  }) {
    AppLog.debug('FirebaseAnalytics: $name, $parameters');

    instance.firebaseAnalytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }
}
