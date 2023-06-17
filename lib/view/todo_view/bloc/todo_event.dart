part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class TodoEventStarted extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class TodoEventUpdatedTaskItem extends TodoEvent {
  const TodoEventUpdatedTaskItem(this.item);
  final TaskItem item;

  @override
  List<Object?> get props => [item];
}

class TodoEventRemovedTaskItem extends TodoEvent {
  const TodoEventRemovedTaskItem(this.index);
  final String index;

  @override
  List<Object?> get props => [index];
}
