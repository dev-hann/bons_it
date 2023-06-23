part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeEventStarted extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeEventClockStarted extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeEventClockStopped extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeEventClockUpdated extends HomeEvent {
  const HomeEventClockUpdated({
    required this.currentDuration,
    required this.totalDuration,
  });
  final Duration currentDuration;
  final Duration totalDuration;

  @override
  List<Object?> get props => [
        currentDuration,
        totalDuration,
      ];
}
