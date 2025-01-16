// import 'dart:developer';
import 'package:logging/logging.dart';

class CustomLogger {
  final Logger _logger;

  CustomLogger(String name) : _logger = Logger(name);

  void debug(dynamic message) {
    _log(Level.FINE, message);
  }

  void info(dynamic message) {
    _log(Level.INFO, message);
  }

  void warning(dynamic message) {
    _log(Level.WARNING, message);
  }

  void error(dynamic message) {
    _log(Level.SEVERE, message);
  }

  void _log(Level level, dynamic message) {
    _logger.log(level, message.toString());
  }
}

void setupLogging(Level level) {
  Logger.root.level = level;
  Logger.root.onRecord.listen((record) {
    final logMessage =
        '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}';
    // log(logMessage, level: record.level.value);
    // ignore: avoid_print
    print(logMessage);
  });
}

final CustomLogger logger = CustomLogger("Rahgosha");