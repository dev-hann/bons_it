part of 'home_bloc.dart';

enum HomeViewStatus {
  init,
  loading,
  running,
  sucess,
  failure,
}

enum ClockType {
  stopWatch,
  timer,
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeViewStatus.init,
    this.clockType = ClockType.timer,
    this.currentDuration = Duration.zero,
    this.totalDuration = const Duration(hours: 1),
    this.timer,
  });

  final HomeViewStatus status;
  final ClockType clockType;
  final Duration currentDuration;
  final Duration totalDuration;
  final Timer? timer;

  @override
  List<Object?> get props => [
        status,
        clockType,
        currentDuration,
        totalDuration,
        timer,
      ];

  HomeState copyWith({
    HomeViewStatus? status,
    ClockType? clockType,
    Duration? currentDuration,
    Duration? totalDuration,
    Timer? timer,
  }) {
    return HomeState(
      status: status ?? this.status,
      clockType: clockType ?? this.clockType,
      currentDuration: currentDuration ?? this.currentDuration,
      totalDuration: totalDuration ?? this.totalDuration,
      timer: timer ?? this.timer,
    );
  }
}
