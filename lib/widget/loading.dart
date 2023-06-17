import 'package:flutter/material.dart';

class TodoLoading extends StatelessWidget {
  const TodoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
