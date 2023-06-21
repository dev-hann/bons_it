import 'package:flutter/material.dart';

class BSDateTimeRange extends DateTimeRange {
  BSDateTimeRange({
    required super.start,
    required super.end,
  });

  factory BSDateTimeRange.now() {
    final now = DateTime.now();
    return BSDateTimeRange(start: now, end: now);
  }
}
