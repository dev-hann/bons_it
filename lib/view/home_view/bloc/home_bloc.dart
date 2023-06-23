import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeEventStarted>(_onStarted);
    on<HomeEventClockStarted>(_onClockStarted);
    on<HomeEventClockStopped>(_onClockStopped);
    on<HomeEventClockUpdated>(_onClockedUpdated);
  }

  FutureOr<void> _onStarted(HomeEventStarted event, Emitter<HomeState> emit) {}

  FutureOr<void> _onClockStarted(
      HomeEventClockStarted event, Emitter<HomeState> emit) {
    state.timer?.cancel();
    final timer = Timer.periodic(
      const Duration(seconds: 1),
      (tick) {
        final current = state.currentDuration + const Duration(seconds: 1);
        final total = state.totalDuration;
        if (current == total) {
          add(HomeEventClockStopped());
        }
        add(
          HomeEventClockUpdated(
            currentDuration: current,
            totalDuration: total,
          ),
        );
      },
    );
    emit(
      state.copyWith(
        status: HomeViewStatus.running,
        timer: timer,
        currentDuration: Duration.zero,
        totalDuration: const Duration(hours: 1),
      ),
    );
  }

  FutureOr<void> _onClockStopped(
      HomeEventClockStopped event, Emitter<HomeState> emit) async {
    state.timer?.cancel();
    emit(
      state.copyWith(
        status: HomeViewStatus.sucess,
        currentDuration: Duration.zero,
      ),
    );
  }

  FutureOr<void> _onClockedUpdated(
      HomeEventClockUpdated event, Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        currentDuration: event.currentDuration,
        totalDuration: event.totalDuration,
      ),
    );
  }
}
