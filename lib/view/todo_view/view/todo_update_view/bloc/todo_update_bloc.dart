import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bons_it/model/label.dart';
import 'package:bons_it/model/task_item.dart';
import 'package:bons_it/repository/task/task_repo.dart';
import 'package:bons_it/use_case/task.dart';
import 'package:bons_it/util/logger.dart';
import 'package:bons_it/util/toast.dart';

part 'todo_update_event.dart';
part 'todo_update_state.dart';

class TodoUpdateBloc extends Bloc<TodoUpdateEvent, TodoUpdateState> {
  TodoUpdateBloc(TaskRepo repo)
      : useCase = TaskUseCase(repo),
        super(
          TodoUpdateState(
            taskItem: TaskItem(),
            titleController: TextEditingController(),
          ),
        ) {
    on<TodoUpdateStarted>(_onStarted);
    on<TodoUpdateCompleted>(onCompleted);
    on<TodoUpdateChangedTask>(_onChangedTask);
    on<TodoUpdateLeftView>(_onLeftView);
  }
  final TaskUseCase useCase;

  Future<FutureOr<void>> _onStarted(
      TodoUpdateStarted event, Emitter<TodoUpdateState> emit) async {
    final taskItem = event.taskItem ?? state.taskItem;
    final labelListData = await useCase.requestLabelList();
    labelListData.fold(
      (e) {
        TodoLogger.error(e);
        TodoToast.showError(e);
      },
      (list) {
        emit(
          state.copyWith(
            status: TodoUpdateViewStatus.success,
            taskItem: taskItem,
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
      TodoUpdateCompleted event, Emitter<TodoUpdateState> emit) async {
    final option = await useCase.updateTaskItem(state.taskItem);
    option.fold(
      () {
        emit(
          state.copyWith(
            status: TodoUpdateViewStatus.completed,
          ),
        );
      },
      (e) {
        TodoToast.showError(e);
      },
    );
  }

  FutureOr<void> _onChangedTask(
      TodoUpdateChangedTask event, Emitter<TodoUpdateState> emit) async {
    final taskItem = event.taskItem;
    emit(
      state.copyWith(
        taskItem: taskItem,
        isChanged: true,
      ),
    );
  }

  FutureOr<void> _onLeftView(
      TodoUpdateLeftView event, Emitter<TodoUpdateState> emit) {
    emit(
      state.copyWith(
        status: TodoUpdateViewStatus.leave,
      ),
    );
    emit(
      state.copyWith(
        status: TodoUpdateViewStatus.success,
      ),
    );
  }
}
