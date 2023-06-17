part of 'label_update_bloc.dart';

abstract class LabelUpdateEvent extends Equatable {
  const LabelUpdateEvent();
}

class LabelUpdateStarted extends LabelUpdateEvent {
  const LabelUpdateStarted(this.label);
  final Label? label;

  @override
  List<Object?> get props => [label];
}

class LabelUpdateCompleted extends LabelUpdateEvent {
  @override
  List<Object?> get props => [];
}
