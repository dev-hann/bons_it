import 'dart:convert';

import 'package:equatable/equatable.dart';

class Label extends Equatable {
  const Label({
    required this.index,
    required this.name,
    required this.colorValue,
  });
  final String index;
  final String name;
  final int colorValue;

  @override
  List<Object?> get props => [
        index,
        name,
        colorValue,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'index': index,
      'name': name,
      'colorValue': colorValue,
    };
  }

  factory Label.fromMap(Map<String, dynamic> map) {
    return Label(
      index: map['index'] as String,
      name: map['name'] as String,
      colorValue: map['colorValue'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Label.fromJson(String source) =>
      Label.fromMap(json.decode(source) as Map<String, dynamic>);

  Label copyWith({
    String? index,
    String? name,
    int? colorValue,
  }) {
    return Label(
      index: index ?? this.index,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
    );
  }
}
