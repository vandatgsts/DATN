part of console_logger;

enum WellKnownTitles {
  error,
  exception,
  httpError,
  httpRequest,
  httpResponse,
  blocEvent,
  blocTransition,
  blocCreate,
  blocClose,
  route,
}

extension WellKnownTitlesExt on WellKnownTitles {
  String get title {
    switch (this) {
      case WellKnownTitles.error:
        return 'ERROR';
      case WellKnownTitles.exception:
        return 'EXCEPTION';
      case WellKnownTitles.httpError:
        return 'http-error';
      case WellKnownTitles.httpRequest:
        return 'http-request';
      case WellKnownTitles.httpResponse:
        return 'http-response';
      case WellKnownTitles.blocEvent:
        return 'bloc-event';
      case WellKnownTitles.blocTransition:
        return 'bloc-transition';
      case WellKnownTitles.blocCreate:
        return 'bloc-create';
      case WellKnownTitles.blocClose:
        return 'bloc-close';
      case WellKnownTitles.route:
        return 'ROUTE';
    }
  }
}
