// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'label_select_bloc.dart';

class LabelSelectState extends Equatable {
  const LabelSelectState({
    this.labelList = const [],
    this.selectedList = const [],
  });

  final List<Label> labelList;
  final List<String> selectedList;

  @override
  List<Object> get props => [
        labelList,
        selectedList,
      ];

  LabelSelectState copyWith({
    List<Label>? labelList,
    List<String>? selectedList,
  }) {
    return LabelSelectState(
      labelList: labelList ?? this.labelList,
      selectedList: selectedList ?? this.selectedList,
    );
  }
}
