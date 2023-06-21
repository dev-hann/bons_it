// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bons_it/util/number.dart';
import 'package:equatable/equatable.dart';

import 'package:bons_it/model/todo_item.dart';

class TodoFolder extends Equatable {
  TodoFolder({
    String? index,
    this.title = "",
    this.itemList = const [],
  }) : index = index ?? TodoNumber.index();
  final String index;
  final String title;
  final List<TodoItem> itemList;

  @override
  List<Object?> get props => [
        index,
        title,
        itemList,
      ];

  TodoFolder copyWith({
    String? index,
    String? title,
    List<TodoItem>? itemList,
  }) {
    return TodoFolder(
      index: index ?? this.index,
      title: title ?? this.title,
      itemList: itemList ?? this.itemList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'index': index,
      'title': title,
      'itemList': itemList.map((x) => x.toMap()).toList(),
    };
  }

  factory TodoFolder.fromMap(Map<String, dynamic> map) {
    return TodoFolder(
      index: map['index'] as String,
      title: map['title'] as String,
      itemList:
          List.from(map['itemList']).map((e) => TodoItem.fromMap(e)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoFolder.fromJson(String source) =>
      TodoFolder.fromMap(json.decode(source) as Map<String, dynamic>);
}
