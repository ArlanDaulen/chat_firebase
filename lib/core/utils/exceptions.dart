import 'package:equatable/equatable.dart';

class BaseException extends Equatable implements Exception {
  const BaseException(
    this._message,
    this._prefix,
    this._statusCode,
    this._errorCode,
  );

  final String _message;
  final dynamic _errorCode;
  final dynamic _prefix;
  final dynamic _statusCode;

  @override
  String toString() => '$_prefix$_message';

  int getStatusCode() => _statusCode;

  int getErrorCode() => _errorCode;

  String getMessage() => _message;

  String getPrefix() => _prefix;

  @override
  List<Object?> get props => [_message, _errorCode, _prefix, _statusCode];
}

class FetchDataException extends BaseException {
  const FetchDataException(String message, statusCode, errorCode)
    : super(message, 'Error During Communication: ', statusCode, errorCode);
}

class NoInternetException extends FetchDataException {
  const NoInternetException() : super('No Internet connection', 0, 0);
}

class BadRequestException extends BaseException {
  const BadRequestException(String message, statusCode, errorCode)
    : super(message, 'Invalid Request: ', statusCode, errorCode);
}

class NotFoundException extends BaseException {
  const NotFoundException(String message, statusCode, errorCode)
    : super(message, 'Not found: ', statusCode, errorCode);
}

class UnauthorizedException extends BaseException {
  const UnauthorizedException(String message, statusCode, errorCode)
    : super(message, 'Unauthorized: ', statusCode, errorCode);
}

class ForbiddenException extends BaseException {
  const ForbiddenException(String message, statusCode, errorCode)
    : super(message, 'Forbidden: ', statusCode, errorCode);
}

class InvalidInputException extends BaseException {
  const InvalidInputException(String message, statusCode, errorCode)
    : super(message, 'Invalid Input: ', statusCode, errorCode);
}

class SystemException extends BaseException {
  const SystemException(String message, statusCode, errorCode)
    : super(message, 'System exception: ', statusCode, errorCode);
}

class BlockedUntilException extends BaseException {
  const BlockedUntilException(String message, statusCode, errorCode)
    : super(message, 'Blocked until exception: ', statusCode, errorCode);
}

class UnavailableCityException extends BaseException {
  const UnavailableCityException(String message, statusCode, errorCode)
    : super(message, 'Unavailable city exception: ', statusCode, errorCode);
}

class TooManyRequestsException extends BaseException {
  const TooManyRequestsException(String message, statusCode, errorCode)
    : super(message, 'Too many requests exception: ', statusCode, errorCode);
}

class ServerException extends BaseException {
  const ServerException(String message, statusCode, errorCode)
    : super(message, 'Server exception: ', statusCode, errorCode);
}
