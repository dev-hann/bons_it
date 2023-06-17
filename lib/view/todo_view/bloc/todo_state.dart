// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

enum TodoViewStatus {
  init,
  loading,
  success,
  failure,
}

class TodoState extends Equatable {
  const TodoState({
    this.status = TodoViewStatus.init,
    this.itemList = const [],
  });

  final TodoViewStatus status;
  final List<TaskItem> itemList;

  @override
  List<Object> get props => [
        status,
        itemList.hashCode,
      ];

  TodoState copyWith({
    TodoViewStatus? status,
    List<TaskItem>? itemList,
  }) {
    return TodoState(
      status: status ?? this.status,
      itemList: itemList ?? this.itemList,
    );
  }
}
