part of 'folder_update_bloc.dart';

abstract class FolderUpdateEvent extends Equatable {
  const FolderUpdateEvent();
}

class FolderUpdateStarted extends FolderUpdateEvent {
  const FolderUpdateStarted(this.folder);
  final TodoFolder? folder;

  @override
  List<Object?> get props => [folder];
}

class FolderUpdateCompleted extends FolderUpdateEvent {
  @override
  List<Object?> get props => [];
}

class FolderUpdateChangedFolder extends FolderUpdateEvent {
  const FolderUpdateChangedFolder(this.folder);
  final TodoFolder folder;
  @override
  List<Object?> get props => [folder];
}

class FolderUpdateLeftView extends FolderUpdateEvent {
  @override
  List<Object?> get props => [];
}
