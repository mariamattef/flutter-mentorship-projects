// abstract class Failure {
//   final String message;

//   Failure(this.message);
// }

import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with API service');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with API service');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with API service');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad request with API service');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode ?? 500,
          dioException.response?.data ?? {},
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request to API was cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet connection');
      case DioExceptionType.unknown:
        if (dioException.message?.contains('SocketException') == true) {
          return ServerFailure('No Internet connection');
        }
        return ServerFailure(
          'Unexpected error with API service, please try again',
        );
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(
        response?['error']?['message'] ?? 'Authentication error',
      );
    } else if (statusCode == 404) {
      return ServerFailure(
        'Your request was not found. Please try again later',
      );
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server Error. Please try again later');
    } else {
      return ServerFailure('Oops! There was an error, please try again later');
    }
  }
}
