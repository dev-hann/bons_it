import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:bons_it/util/number.dart';

enum TaskItemStatus {
  none,
  completed,
}

class TodoItem extends Equatable {
  TodoItem({
    String? index,
    this.title = "",
    DateTime? dateTime,
    this.labelIndexList = const [],
    this.status = TaskItemStatus.none,
  })  : index = index ?? TodoNumber.index(),
        dateTime = dateTime ?? DateTime.now();
  final String index;
  final String title;
  final DateTime dateTime;
  final List<String> labelIndexList;
  final TaskItemStatus status;

  bool get isCompleted => status == TaskItemStatus.completed;

  @override
  List<Object?> get props => [
        index,
        title,
        dateTime,
        labelIndexList,
        status,
      ];

  TodoItem copyWith({
    String? index,
    String? title,
    DateTime? dateTime,
    List<String>? labelIndexList,
    TaskItemStatus? status,
  }) {
    return TodoItem(
      index: index ?? this.index,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      labelIndexList: labelIndexList ?? this.labelIndexList,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'index': index,
      'title': title,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'labelIndexList': labelIndexList,
      'status': status.index,
    };
  }

  factory TodoItem.fromMap(Map<String, dynamic> map) {
    return TodoItem(
      index: map['index'] as String,
      title: map['title'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      labelIndexList: List<String>.from(map['labelIndexList']),
      status: TaskItemStatus.values[map['status']],
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoItem.fromJson(String source) =>
      TodoItem.fromMap(json.decode(source) as Map<String, dynamic>);
}