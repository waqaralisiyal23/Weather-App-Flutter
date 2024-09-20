import '../entities/error_entity.dart';

class Result<T> {
  final T? _data;
  final ErrorEntity? _error;

  const Result._(this._data, this._error);

  factory Result.success(T data) => Result._(data, null);

  factory Result.failed(ErrorEntity error) => Result._(null, error);

  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(ErrorEntity error) failed,
  }) {
    final data = _data;
    final error = _error;

    if (error != null) {
      return failed.call(error);
    } else if (data != null) {
      return success.call(data);
    }

    return failed.call(const ErrorEntity(message: 'Unknown Error'));
  }

  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T? data)? success,
    TResult Function(ErrorEntity error)? failed,
  }) {
    final data = _data;
    final error = _error;

    if (error != null) {
      return failed?.call(error);
    } else {
      return success?.call(data);
    }
  }

  bool isSuccess() => _data != null && _error == null;
}
