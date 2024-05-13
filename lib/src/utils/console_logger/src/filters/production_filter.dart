part of console_logger;

/// Prints all logs with `level >= Logger.level` even in production.
class ProductionFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return event.level.value >= level!.value;
  }
}
