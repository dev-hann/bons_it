import 'package:flutter/material.dart';

class TodoDialog {
  static Future<T?> show<T>({
    required BuildContext context,
    required String message,
    required List<Widget> actions,
  }) {
    return showDialog<T>(
      context: context,
      builder: (_) {
        return Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
