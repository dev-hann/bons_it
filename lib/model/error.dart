import 'package:equatable/equatable.dart';

class BSError extends Equatable {
  const BSError(
    this.message, [
    this.stackTrace,
  ]);
  final String message;
  final StackTrace? stackTrace;

  factory BSError.fromException(dynamic object) {
    if (object is Error) {
      return BSError(object.toString(), object.stackTrace);
    }
    return BSError(object.toString());
  }

  @override
  List<Object?> get props => [
        message,
        stackTrace,
      ];
}
