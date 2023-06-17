part of 'todo_update_bloc.dart';

enum TodoUpdateViewStatus {
  init,
  loading,
  success,
  faiure,
  completed,
  leave,
}

class TodoUpdateState extends Equatable {
  const TodoUpdateState({
    this.status = TodoUpdateViewStatus.init,
    required this.taskItem,
    required this.titleController,
    this.isChanged = false,
    this.labelList = const [],
  });

  final TodoUpdateViewStatus status;
  final TaskItem taskItem;
  final TextEditingController titleController;
  final bool isChanged;
  final List<Label> labelList;

  @override
  List<Object?> get props => [
        status,
        taskItem,
        titleController,
        isChanged,
        labelList,
      ];

  TodoUpdateState copyWith({
    TodoUpdateViewStatus? status,
    TaskItem? taskItem,
    TextEditingController? titleController,
    bool? isChanged,
    List<Label>? labelList,
  }) {
    return TodoUpdateState(
      status: status ?? this.status,
      taskItem: taskItem ?? this.taskItem,
      titleController: titleController ?? this.titleController,
      isChanged: isChanged ?? this.isChanged,
      labelList: labelList ?? this.labelList,
    );
  }
}
