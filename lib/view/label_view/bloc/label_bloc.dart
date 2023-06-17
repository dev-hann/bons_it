import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bons_it/model/label.dart';
import 'package:bons_it/repository/task/task_repo.dart';
import 'package:bons_it/use_case/task.dart';
import 'package:bons_it/util/logger.dart';
import 'package:bons_it/util/toast.dart';

part 'label_event.dart';
part 'label_state.dart';

class LabelBloc extends Bloc<LabelEvent, LabelState> {
  LabelBloc(TaskRepo repo)
      : useCase = TaskUseCase(repo),
        super(const LabelState()) {
    on<LabelEventStarted>(_onStarted);
    on<LabelEventUpdatedLabel>(_onUpdated);
    on<LabelEventRemovedLabel>(_onRemoved);
  }

  final TaskUseCase useCase;

  FutureOr<void> _onStarted(
      LabelEventStarted event, Emitter<LabelState> emit) async {
    final either = await useCase.requestLabelList();
    either.fold(
      (e) {
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

  FutureOr<void> _onUpdated(
      LabelEventUpdatedLabel event, Emitter<LabelState> emit) async {
    final label = event.label;
    final option = await useCase.updateLabel(label);
    option.fold(
      () => null,
      (e) {
        TodoLogger.error(e);
        TodoToast.showError(e);
      },
    );
  }

  FutureOr<void> _onRemoved(
      LabelEventRemovedLabel event, Emitter<LabelState> emit) async {
    final index = event.index;
    final option = await useCase.removeLabel(index);
    option.fold(
      () => null,
      (e) {
        TodoLogger.error(e);
        TodoToast.showError(e);
      },
    );
  }
}
