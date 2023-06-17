part of 'label_bloc.dart';

abstract class LabelEvent extends Equatable {
  const LabelEvent();
}

class LabelEventStarted extends LabelEvent {
  @override
  List<Object?> get props => [];
}

class LabelEventUpdatedLabel extends LabelEvent {
  const LabelEventUpdatedLabel(this.label);
  final Label label;

  @override
  List<Object?> get props => [label];
}

class LabelEventRemovedLabel extends LabelEvent {
  const LabelEventRemovedLabel(this.index);
  final String index;

  @override
  List<Object?> get props => [index];
}
