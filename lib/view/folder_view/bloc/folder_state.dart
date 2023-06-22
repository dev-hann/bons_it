part of 'folder_bloc.dart';

class FolderState extends Equatable {
  const FolderState({
    this.itemList = const [],
  });

  final List<TodoItem> itemList;

  @override
  List<Object> get props => [
        itemList,
      ];
}
