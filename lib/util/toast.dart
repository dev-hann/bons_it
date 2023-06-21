import 'package:fluttertoast/fluttertoast.dart';
import 'package:bons_it/model/error.dart';

class TodoToast {
  static showMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
    );
  }

  static showError(
    BSError error,
  ) {
    Fluttertoast.showToast(
      msg: error.message,
    );
  }
}
