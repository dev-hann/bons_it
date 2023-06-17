import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bons_it/model/task_item.dart';
import 'package:bons_it/repository/task/task_repo.dart';
import 'package:bons_it/use_case/task.dart';
import 'package:bons_it/util/logger.dart';
import 'package:bons_it/util/toast.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(TaskRepo repo)
      : useCase = TaskUseCase(repo),
        super(const TodoState()) {
    on<TodoEventStarted>(_onStarted);
    on<TodoEventUpdatedTaskItem>(_onUpdatedTaskItem);
    on<TodoEventRemovedTaskItem>(_onRemovedTaskItem);
  }

  final TaskUseCase useCase;

  FutureOr<void> _onStarted(
      TodoEventStarted event, Emitter<TodoState> emit) async {
    final listData = await useCase.requestTaskItemList();
    listData.fold(
      (e) {
        TodoLogger.error(e);
        TodoToast.showError(e);
      },
      (list) {
        emit(
          state.copyWith(
            status: TodoViewStatus.success,
            itemList: list,
          ),
        );
      },
    );
    await emit.onEach(
      useCase.taskStream(),
      onData: (index) async {
        final list = [...state.itemList];
        final either = await useCase.requestTaskItem(index);
        either.fold(
          (e) {
            TodoLogger.error(e);
            TodoToast.showError(e);
          },
          (item) {
            if (item == null) {
              list.removeWhere((element) => element.index == index);
            } else {
              final indexWhere =
                  list.indexWhere((element) => element.index == index);
              if (indexWhere == -1) {
                list.add(item);
              } else {
                list[indexWhere] = item;
              }
            }
            emit(
              state.copyWith(
                itemList: list,
              ),
            );
          },
        );
      },
    );
  }

  FutureOr<void> _onUpdatedTaskItem(
      TodoEventUpdatedTaskItem event, Emitter<TodoState> emit) async {
    final item = event.item;
    final option = await useCase.updateTaskItem(item);
    option.fold(
      () => null,
      (e) {
        TodoLogger.error(e);
        TodoToast.showError(e);
      },
    );
  }

  FutureOr<void> _onRemovedTaskItem(
      TodoEventRemovedTaskItem event, Emitter<TodoState> emit) async {
    final index = event.index;
    final option = await useCase.removeTaskItem(index);
    option.fold(
      () => null,
      (e) {
        TodoLogger.error(e);
        TodoToast.showError(e);
      },
    );
  }
}
