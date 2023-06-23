import 'package:bons_it/view/runner_view/runner_view.dart';
import 'package:flutter/material.dart';

class CircleTrack extends StatelessWidget {
  const CircleTrack({
    super.key,
    required this.currentDuration,
    required this.totalDuration,
  });
  final Duration totalDuration;
  final Duration currentDuration;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox.square(
          dimension: constraints.maxHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: currentDuration.inSeconds / totalDuration.inSeconds,
                backgroundColor: Colors.grey.withOpacity(0.2),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const RunnerView(),
                    Text(currentDuration.toString().split(".").first),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
