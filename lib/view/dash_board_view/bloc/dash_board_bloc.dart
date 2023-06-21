import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bons_it/model/todo_folder.dart';
import 'package:bons_it/repository/task/task_repo.dart';
import 'package:bons_it/use_case/task.dart';
import 'package:equatable/equatable.dart';

part 'dash_board_event.dart';
part 'dash_board_state.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  DashBoardBloc(TaskRepo repo)
      : useCase = TaskUseCase(repo),
        super(const DashBoardState()) {
    on<DashBoardEventStarted>(_onStarted);
  }

  final TaskUseCase useCase;

  FutureOr<void> _onStarted(
      DashBoardEventStarted event, Emitter<DashBoardState> emit) async {
    final folderListData = await useCase.requestTodoFolderList();
    folderListData.fold(
      (l) => null,
      (list) {
        emit(
          state.copyWith(
            todoFolderList: list,
          ),
        );
      },
    );
  }
}
