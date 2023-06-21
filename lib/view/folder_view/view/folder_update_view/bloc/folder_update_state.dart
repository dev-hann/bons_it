part of 'folder_update_bloc.dart';

enum FolderUpdateViewStatus {
  init,
  loading,
  success,
  faiure,
  completed,
  leave,
}

class FolderUpdateState extends Equatable {
  const FolderUpdateState({
    this.status = FolderUpdateViewStatus.init,
    required this.folder,
    required this.titleController,
    this.isChanged = false,
    this.labelList = const [],
  });

  final FolderUpdateViewStatus status;
  final TodoFolder folder;
  final TextEditingController titleController;
  final bool isChanged;
  final List<Label> labelList;

  @override
  List<Object?> get props => [
        status,
        folder,
        titleController,
        isChanged,
        labelList,
      ];

  FolderUpdateState copyWith({
    FolderUpdateViewStatus? status,
    TodoFolder? folder,
    TextEditingController? titleController,
    bool? isChanged,
    List<Label>? labelList,
  }) {
    return FolderUpdateState(
      status: status ?? this.status,
      folder: folder ?? this.folder,
      titleController: titleController ?? this.titleController,
      isChanged: isChanged ?? this.isChanged,
      labelList: labelList ?? this.labelList,
    );
  }
}
