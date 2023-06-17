import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bons_it/model/label.dart';
import 'package:bons_it/repository/task/task_repo.dart';
import 'package:bons_it/use_case/task.dart';
import 'package:bons_it/util/number.dart';

part 'label_update_event.dart';
part 'label_update_state.dart';

class LabelUpdateBloc extends Bloc<LabelUpdateEvent, LabelUpdateState> {
  LabelUpdateBloc(TaskRepo repo)
      : useCase = TaskUseCase(repo),
        super(LabelUpdateState()) {
    on<LabelUpdateStarted>(_onStarted);
    on<LabelUpdateCompleted>(_onCompleted);
  }
  final TaskUseCase useCase;

  FutureOr<void> _onStarted(
      LabelUpdateStarted event, Emitter<LabelUpdateState> emit) {
    final label = event.label;
    emit(
      state.copyWith(
        index: label?.index,
        nameController: TextEditingController(text: label?.name),
      ),
    );
  }

  Future<FutureOr<void>> _onCompleted(
      LabelUpdateCompleted event, Emitter<LabelUpdateState> emit) async {
    final label = Label(
      index: state.index,
      name: state.nameController.text,
      colorValue: 0,
    );
    await useCase.updateLabel(label);
    emit(
      state.copyWith(
        status: LabelUpdateViewStatus.completed,
      ),
    );
  }
}
