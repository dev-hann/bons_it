import 'package:bons_it/model/error.dart';
import 'package:logger/logger.dart';

class TodoLogger {
  static final Logger _logger = Logger();

  static void debug(dynamic message) {
    _logger.d(message);
  }

  static void error(BSError error) {
    _logger.e(error.message, error.runtimeType, error.stackTrace);
  }
}
