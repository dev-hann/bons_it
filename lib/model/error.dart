import 'package:equatable/equatable.dart';

class TodoError extends Equatable {
  const TodoError(
    this.message, [
    this.stackTrace,
  ]);
  final String message;
  final StackTrace? stackTrace;

  factory TodoError.fromException(dynamic object) {
    if (object is Error) {
      return TodoError(object.toString(), object.stackTrace);
    }
    return TodoError(object.toString());
  }

  @override
  List<Object?> get props => [
        message,
        stackTrace,
      ];
}
