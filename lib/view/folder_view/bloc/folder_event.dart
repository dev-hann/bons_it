part of 'folder_bloc.dart';

abstract class FolderEvent extends Equatable {
  const FolderEvent();
}

class FolderEventStarted extends FolderEvent {
  @override
  List<Object?> get props => [];
}

class FolderEventRemovedTaskItem extends FolderEvent {
  const FolderEventRemovedTaskItem(this.index);
  final String index;

  @override
  List<Object?> get props => [index];
}

class FolderEventUpdatedTaskItem extends FolderEvent {
  const FolderEventUpdatedTaskItem(this.todoItem);
  final TodoItem todoItem;

  @override
  List<Object?> get props => [
        todoItem,
      ];
}
