import 'package:dio/dio.dart';
import 'package:themeandpagination/core/errors/error_model.dart';

//!ServerException
class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException(this.errorModel);
}

//!CacheExeption
class CacheExeption implements Exception {
  final String errorMessage;
  CacheExeption({required this.errorMessage});
}

class BadCertificateException extends ServerException {
  BadCertificateException(super.errorModel);
}

class ConnectionTimeoutException extends ServerException {
  ConnectionTimeoutException(super.errorModel);
}

class BadResponseException extends ServerException {
  BadResponseException(super.errorModel);
}

class ReceiveTimeoutException extends ServerException {
  ReceiveTimeoutException(super.errorModel);
}

class ConnectionErrorException extends ServerException {
  ConnectionErrorException(super.errorModel);
}

class SendTimeoutException extends ServerException {
  SendTimeoutException(super.errorModel);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException(super.errorModel);
}

class ForbiddenException extends ServerException {
  ForbiddenException(super.errorModel);
}

class NotFoundException extends ServerException {
  NotFoundException(super.errorModel);
}

class CofficientException extends ServerException {
  CofficientException(super.errorModel);
}

class CancelException extends ServerException {
  CancelException(super.errorModel);
}

class UnknownException extends ServerException {
  UnknownException(super.errorModel);
}

class EmailAlreadyInUseException extends ServerException {
  EmailAlreadyInUseException(super.errorModel);
}

class InvalidCredentialsException extends ServerException {
  InvalidCredentialsException(super.errorModel);
}

class InvalidOtpException extends ServerException {
  InvalidOtpException(super.errorModel);
}

ErrorModel _createErrorModel(dynamic data, int? statusCode) {
  // print('data type: ${data.runtimeType}');
  // print('data: $data');
  if (data is String) {
    return ErrorModel(errorMessage: data, status: statusCode);
  } else if (data is Map) {
    final Map<String, dynamic> jsonData = Map<String, dynamic>.from(data);
    return ErrorModel.fromJson(jsonData);
  } else {
    return ErrorModel(errorMessage: 'Unknown error format', status: statusCode);
  }
}

handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      throw ConnectionErrorException(
        _createErrorModel(e.response?.data, e.response?.statusCode),
      );
    case DioExceptionType.badCertificate:
      throw BadCertificateException(
        _createErrorModel(e.response?.data, e.response?.statusCode),
      );
    case DioExceptionType.connectionTimeout:
      throw ConnectionTimeoutException(
        _createErrorModel(e.response?.data, e.response?.statusCode),
      );

    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(
        _createErrorModel(e.response?.data, e.response?.statusCode),
      );

    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(
        _createErrorModel(e.response?.data, e.response?.statusCode),
      );

    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw BadResponseException(
            _createErrorModel(e.response?.data, e.response?.statusCode),
          );

        case 401: //unauthorized
          throw UnauthorizedException(
            _createErrorModel(e.response?.data, e.response?.statusCode),
          );

        case 403: //forbidden
          throw ForbiddenException(
            _createErrorModel(e.response?.data, e.response?.statusCode),
          );

        case 404: //not found
          throw NotFoundException(
            _createErrorModel(e.response?.data, e.response?.statusCode),
          );

        case 409: //cofficient
          throw CofficientException(
            _createErrorModel(e.response?.data, e.response?.statusCode),
          );

        case 504: // Gateway timeout
          throw BadResponseException(
            ErrorModel(
              status: 504,
              errorMessage: e.response?.data?.toString() ?? 'Gateway timeout',
            ),
          );
      }

    case DioExceptionType.cancel:
      throw CancelException(
        ErrorModel(errorMessage: e.toString(), status: 500),
      );

    case DioExceptionType.unknown:
      throw UnknownException(
        ErrorModel(errorMessage: e.toString(), status: 500),
      );
  }
}
