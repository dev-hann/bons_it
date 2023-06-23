import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bons_it/model/runner.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'runner_event.dart';
part 'runner_state.dart';

class RunnerBloc extends Bloc<RunnerEvent, RunnerState> {
  RunnerBloc() : super(const RunnerState()) {
    on<RunnerEventStarted>(_onStarted);
    on<RunnerEventUpdated>(_onUpdated);
    on<RunnerEventRan>(_onRan);
    on<RunnerEventRested>(_onRested);
    on<RunnerEventUpdatedIndex>(_onUpdatedIndex);
  }

  FutureOr<void> _onStarted(
      RunnerEventStarted event, Emitter<RunnerState> emit) {
    emit(
      state.copyWith(
        status: RunnerViewStatus.resting,
      ),
    );
  }

  FutureOr<void> _onUpdated(
      RunnerEventUpdated event, Emitter<RunnerState> emit) {
    final runner = event.runner;
    final context = event.context;
    emit(
      state.copyWith(
        runner: runner,
      ),
    );
    for (final image in runner.assetList) {
      precacheImage(AssetImage(image), context);
    }
  }

  FutureOr<void> _onRan(RunnerEventRan event, Emitter<RunnerState> emit) async {
    if (state.status == RunnerViewStatus.running) {
      return;
    }
    final timer = Timer.periodic(
      const Duration(milliseconds: 200),
      (timer) {
        add(RunnerEventUpdatedIndex());
      },
    );
    emit(
      state.copyWith(
        status: RunnerViewStatus.running,
        timer: timer,
      ),
    );
  }

  FutureOr<void> _onRested(RunnerEventRested event, Emitter<RunnerState> emit) {
    state.timer?.cancel();
    emit(
      state.copyWith(
        status: RunnerViewStatus.resting,
        runnerIndex: 0,
      ),
    );
  }

  FutureOr<void> _onUpdatedIndex(
      RunnerEventUpdatedIndex event, Emitter<RunnerState> emit) {
    emit(
      state.copyWith(
        runnerIndex: state.runnerIndex + 1,
      ),
    );
  }
}
