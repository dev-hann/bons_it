part of 'label_update_bloc.dart';

enum LabelUpdateViewStatus {
  init,
  loading,
  success,
  failure,
  completed,
}

class LabelUpdateState extends Equatable {
  LabelUpdateState({
    this.status = LabelUpdateViewStatus.init,
    String? index,
    TextEditingController? nameController,
  })  : index = index ?? TodoNumber.index(),
        nameController = nameController ?? TextEditingController();
  final LabelUpdateViewStatus status;
  final String index;
  final TextEditingController nameController;
  @override
  List<Object> get props => [
        status,
        index,
        nameController,
      ];

  LabelUpdateState copyWith({
    LabelUpdateViewStatus? status,
    String? index,
    TextEditingController? nameController,
  }) {
    return LabelUpdateState(
      status: status ?? this.status,
      index: index ?? this.index,
      nameController: nameController ?? this.nameController,
    );
  }
}
