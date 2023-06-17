// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'label_bloc.dart';

enum LabelViewStatus {
  init,
  loading,
  success,
  failure,
}

class LabelState extends Equatable {
  const LabelState({
    this.status = LabelViewStatus.init,
    this.labelList = const [],
  });
  final LabelViewStatus status;
  final List<Label> labelList;

  @override
  List<Object> get props => [
        status,
        labelList,
      ];

  LabelState copyWith({
    LabelViewStatus? status,
    List<Label>? labelList,
  }) {
    return LabelState(
      status: status ?? this.status,
      labelList: labelList ?? this.labelList,
    );
  }
}
