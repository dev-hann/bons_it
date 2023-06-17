import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bons_it/model/label.dart';
import 'package:bons_it/repository/task/task_repo.dart';
import 'package:bons_it/use_case/task.dart';
import 'package:bons_it/util/logger.dart';
import 'package:bons_it/util/toast.dart';

part 'label_select_event.dart';
part 'label_select_state.dart';

class LabelSelectBloc extends Bloc<LabelSelectEvent, LabelSelectState> {
  LabelSelectBloc(TaskRepo repo)
      : useCase = TaskUseCase(repo),
        super(const LabelSelectState()) {
    on<LabelSelectEventStarted>(_onStarted);
    on<LabelSelectEventOnTapSelected>(_onTapSelected);
  }

  final TaskUseCase useCase;

  FutureOr<void> _onStarted(
      LabelSelectEventStarted event, Emitter<LabelSelectState> emit) async {
    final either = await useCase.requestLabelList();
    either.fold(
      (e) {
        TodoLogger.error(e);
        TodoToast.showError(e);
      },
      (list) {
        emit(
          state.copyWith(
            labelList: list,
            selectedList: event.labelIndexList,
          ),
        );
      },
    );

    await emit.onEach(
      useCase.labelStream(),
      onData: (index) async {
        final listEither = await useCase.requestLabelList();
        listEither.fold(
          (e) {
            TodoLogger.error(e);
            TodoToast.showError(e);
          },
          (list) {
            emit(
              state.copyWith(labelList: list),
            );
          },
        );
      },
    );
  }

  FutureOr<void> _onTapSelected(
      LabelSelectEventOnTapSelected event, Emitter<LabelSelectState> emit) {
    final selectedList = [...state.selectedList];
    final labelIndex = event.index;
    if (selectedList.contains(labelIndex)) {
      selectedList.remove(labelIndex);
    } else {
      selectedList.add(labelIndex);
    }
    emit(
      state.copyWith(
        selectedList: selectedList,
      ),
    );
  }
}
