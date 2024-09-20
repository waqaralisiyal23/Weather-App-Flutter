import 'package:equatable/equatable.dart';

class ErrorEntity extends Equatable {
  final int statusCode;
  final String message;

  const ErrorEntity({
    this.statusCode = kUnknown,
    this.message = '',
  });

  @override
  List<Object?> get props => [statusCode, message];

  static const int kUnknown = -1;
}
