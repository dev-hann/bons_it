part of 'label_select_bloc.dart';

abstract class LabelSelectEvent extends Equatable {
  const LabelSelectEvent();
}

class LabelSelectEventStarted extends LabelSelectEvent {
  const LabelSelectEventStarted(this.labelIndexList);
  final List<String> labelIndexList;

  @override
  List<Object?> get props => [labelIndexList];
}

class LabelSelectEventOnTapSelected extends LabelSelectEvent {
  const LabelSelectEventOnTapSelected(this.index);
  final String index;

  @override
  List<Object?> get props => [
        index,
      ];
}
