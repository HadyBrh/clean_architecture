import 'package:clean_architecture/core_flutter_package.dart';
import 'package:dio/dio.dart';

class NetworkError {
  NetworkError getException(dynamic dioError) {
    if (dioError is DioError) {
      switch (dioError.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          return DeadlineExceededException(error: dioError);
        case DioErrorType.response:
          switch (dioError.response?.statusCode) {
            case 400:
              return BadRequestException(error: dioError);
            case 401:
            case 403:
              return UnauthorizedException(error: dioError);
            case 404:
              return NotFoundException(error: dioError);
            case 409:
              return ConflictException(error: dioError);
            case 500:
              return InternalServerErrorException(error: dioError);
          }
          break;
        case DioErrorType.cancel:
          break;
        case DioErrorType.other:
          return NoInternetConnectionException(error: dioError);
      }
    }

    return SomethingWrongException(error: dioError);
  }
}

class BadRequestException extends NetworkError {
  final DioError error;

  BadRequestException({required this.error});

  @override
  String toString() {
    return AppConstant.invalidRequest;
  }
}

class InternalServerErrorException extends NetworkError {
  final DioError error;

  InternalServerErrorException({required this.error});

  @override
  String toString() {
    return AppConstant.internalServerError;
  }
}

class ConflictException extends NetworkError {
  final DioError error;

  ConflictException({required this.error});

  @override
  String toString() {
    return AppConstant.conflictOccurred;
  }
}

class UnauthorizedException extends NetworkError {
  final DioError? error;

  UnauthorizedException({this.error});

  @override
  String toString() {
    return AppConstant.unAuthorizedAccess;
  }
}

class NotFoundException extends NetworkError {
  final DioError error;

  NotFoundException({required this.error});

  @override
  String toString() {
    return AppConstant.requestedInformationNotFound;
  }
}

class NoInternetConnectionException extends NetworkError {
  final DioError error;

  NoInternetConnectionException({required this.error});

  @override
  String toString() {
    return AppConstant.noInternetConnection;
  }
}

class DeadlineExceededException extends NetworkError {
  final DioError error;

  DeadlineExceededException({required this.error});

  @override
  String toString() {
    return AppConstant.connectionTimedOut;
  }
}

class SomethingWrongException extends NetworkError {
  final dynamic error;

  SomethingWrongException({this.error});

  @override
  String toString() {
    return AppConstant.somethingWentWrong;
  }
}
