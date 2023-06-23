import 'package:equatable/equatable.dart';

class BSError extends Equatable {
  const BSError(
    this.message,
    this.stackTrace,
  );
  final String message;
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [
        message,
        stackTrace,
      ];
}
