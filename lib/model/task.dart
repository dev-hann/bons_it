import 'package:equatable/equatable.dart';
import 'package:bons_it/model/task_item.dart';

class Task extends Equatable {
  const Task({
    required this.index,
    required this.title,
    required this.itemList,
  });
  final String index;
  final String title;
  final List<TaskItem> itemList;

  @override
  List<Object?> get props => [
        index,
        title,
        itemList,
      ];
}
