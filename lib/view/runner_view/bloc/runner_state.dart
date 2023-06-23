part of 'runner_bloc.dart';

enum RunnerViewStatus {
  init,
  loading,
  running,
  resting,
  failure,
}

class RunnerState extends Equatable {
  const RunnerState({
    this.status = RunnerViewStatus.init,
    this.runnerIndex = 0,
    this.runner = Runner.cat,
    this.timer,
  });
  final RunnerViewStatus status;
  final int runnerIndex;
  final Runner runner;
  final Timer? timer;

  String get runnerImage {
    if (status == RunnerViewStatus.resting) {
      return runner.restImage;
    }
    return runner.image(runnerIndex);
  }

  @override
  List<Object?> get props => [
        status,
        runnerIndex,
        runner,
        timer,
      ];

  RunnerState copyWith({
    RunnerViewStatus? status,
    int? runnerIndex,
    Runner? runner,
    Timer? timer,
  }) {
    return RunnerState(
      status: status ?? this.status,
      runnerIndex: runnerIndex ?? this.runnerIndex,
      runner: runner ?? this.runner,
      timer: timer ?? this.timer,
    );
  }
}
