part of 'runner_bloc.dart';

abstract class RunnerEvent extends Equatable {
  const RunnerEvent();
}

class RunnerEventStarted extends RunnerEvent {
  @override
  List<Object?> get props => [];
}

class RunnerEventUpdated extends RunnerEvent {
  const RunnerEventUpdated(
    this.runner,
    this.context,
  );
  final Runner runner;
  final BuildContext context;

  @override
  List<Object?> get props => [
        runner,
        context,
      ];
}

class RunnerEventRan extends RunnerEvent {
  @override
  List<Object?> get props => [];
}

class RunnerEventRested extends RunnerEvent {
  @override
  List<Object?> get props => [];
}

class RunnerEventUpdatedIndex extends RunnerEvent {
  @override
  List<Object?> get props => [];
}
