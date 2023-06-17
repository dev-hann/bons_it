part of 'todo_update_bloc.dart';

abstract class TodoUpdateEvent extends Equatable {
  const TodoUpdateEvent();
}

class TodoUpdateStarted extends TodoUpdateEvent {
  const TodoUpdateStarted(this.taskItem);
  final TaskItem? taskItem;

  @override
  List<Object?> get props => [taskItem];
}

class TodoUpdateCompleted extends TodoUpdateEvent {
  @override
  List<Object?> get props => [];
}

class TodoUpdateChangedTask extends TodoUpdateEvent {
  const TodoUpdateChangedTask(this.taskItem);
  final TaskItem taskItem;
  @override
  List<Object?> get props => [taskItem];
}

class TodoUpdateLeftView extends TodoUpdateEvent {
  @override
  List<Object?> get props => [];
}
