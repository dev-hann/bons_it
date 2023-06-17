import 'package:logger/logger.dart';
import 'package:bons_it/model/error.dart';

class TodoLogger {
  static final Logger _logger = Logger();

  static void debug(dynamic message) {
    _logger.d(message);
  }

  static void error(TodoError error) {
    _logger.e(error.message, error.runtimeType, error.stackTrace);
  }
}
