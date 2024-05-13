part of console_logger;

abstract class LogOutput {
  Future<void> init() async {}

  void output(OutputEvent event);

  Future<void> destroy() async {}
}
