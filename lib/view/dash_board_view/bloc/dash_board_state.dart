// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dash_board_bloc.dart';

enum DashBoardViewStatus {
  init,
  loading,
  success,
}

class DashBoardState extends Equatable {
  const DashBoardState({
    this.status = DashBoardViewStatus.init,
    this.todoFolderList = const [],
  });
  final DashBoardViewStatus status;
  final List<TodoFolder> todoFolderList;

  @override
  List<Object?> get props => [
        status,
        todoFolderList,
      ];

  DashBoardState copyWith({
    DashBoardViewStatus? status,
    List<TodoFolder>? todoFolderList,
  }) {
    return DashBoardState(
      status: status ?? this.status,
      todoFolderList: todoFolderList ?? this.todoFolderList,
    );
  }
}
