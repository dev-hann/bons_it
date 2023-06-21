import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bons_it/model/todo_folder.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bons_it/model/label.dart';
import 'package:bons_it/repository/task/task_repo.dart';
import 'package:bons_it/use_case/task.dart';
import 'package:bons_it/util/logger.dart';
import 'package:bons_it/util/toast.dart';

part 'folder_update_event.dart';
part 'folder_update_state.dart';

class FolderUpdateBloc extends Bloc<FolderUpdateEvent, FolderUpdateState> {
  FolderUpdateBloc(TaskRepo repo)
      : useCase = TaskUseCase(repo),
        super(
          FolderUpdateState(
            folder: TodoFolder(),
            titleController: TextEditingController(),
          ),
        ) {
    on<FolderUpdateStarted>(_onStarted);
    on<FolderUpdateCompleted>(onCompleted);
    on<FolderUpdateChangedFolder>(_onChangedTask);
    on<FolderUpdateLeftView>(_onLeftView);
  }
  final TaskUseCase useCase;

  Future<FutureOr<void>> _onStarted(
      FolderUpdateStarted event, Emitter<FolderUpdateState> emit) async {
    final taskItem = event.folder ?? state.folder;
    final labelListData = await useCase.requestLabelList();
    labelListData.fold(
      (e) {
        TodoLogger.error(e);
        TodoToast.showError(e);
      },
      (list) {
        emit(
          state.copyWith(
            status: FolderUpdateViewStatus.success,
            folder: taskItem,
            titleController: TextEditingController(text: taskItem.title),
            labelList: list,
          ),
        );
      },
    );

    await emit.onEach(
      useCase.labelStream(),
      onData: (index) async {
        final labeListData = await useCase.requestLabelList();
        labeListData.fold(
          (e) {
            TodoLogger.error(e);
            TodoToast.showError(e);
          },
          (list) {
            emit(
              state.copyWith(
                labelList: list,
              ),
            );
          },
        );
      },
    );
  }

  FutureOr<void> onCompleted(
      FolderUpdateCompleted event, Emitter<FolderUpdateState> emit) async {
    // final option = await useCase.updateTaskItem(state.taskItem);
    // option.fold(
    //   () {
    //     emit(
    //       state.copyWith(
    //         status: TodoUpdateViewStatus.completed,
    //       ),
    //     );
    //   },
    //   (e) {
    //     TodoToast.showError(e);
    //   },
    // );
  }

  FutureOr<void> _onChangedTask(
      FolderUpdateChangedFolder event, Emitter<FolderUpdateState> emit) async {
    final taskItem = event.folder;
    emit(
      state.copyWith(
        folder: taskItem,
        isChanged: true,
      ),
    );
  }

  FutureOr<void> _onLeftView(
      FolderUpdateLeftView event, Emitter<FolderUpdateState> emit) {
    emit(
      state.copyWith(
        status: FolderUpdateViewStatus.leave,
      ),
    );
    emit(
      state.copyWith(
        status: FolderUpdateViewStatus.success,
      ),
    );
  }
}
