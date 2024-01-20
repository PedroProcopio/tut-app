import 'package:dio/dio.dart';
import 'package:tut_app/data/network/failure.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  reciveTimeout,
  sendTimeout,
  cacheTimeout,
  unknown,
  noInternetConnection
}


class ErrorHandler implements Exception{
  late Failure failure;

  ErrorHandler.handle(dynamic error){
    if(error is DioException){

      failure = _handleError(error);

    }
    else{
      failure = DataSource.unknown.getFailure();

    }

  }

  

  Failure _handleError(DioException error){

    switch(error.type){
      case DioExceptionType:
        return DataSource.connectTimeout.getFailure();
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.reciveTimeout.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioExceptionType.badResponse:
        switch(error.response!.statusCode){
          case ResponseCode.badRequest:
            return DataSource.badRequest.getFailure();
          case ResponseCode.unauthorized:
            return DataSource.unauthorized.getFailure();
          case ResponseCode.forbidden:
            return DataSource.forbidden.getFailure();
          case ResponseCode.notFound:
            return DataSource.notFound.getFailure();
          case ResponseCode.internalServerError:
            return DataSource.internalServerError.getFailure();
          default:
            return DataSource.unknown.getFailure();


        }
      case DioExceptionType.unknown:
        return DataSource.unknown.getFailure();
      default:
        return DataSource.unknown.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.badRequest:
        return Failure(
            statusCode: ResponseCode.badRequest,
            message: ResponseMessage.badRequest);
      case DataSource.unauthorized:
        return Failure(
            statusCode: ResponseCode.unauthorized,
            message: ResponseMessage.unauthorized);
      case DataSource.forbidden:
        return Failure(
            statusCode: ResponseCode.forbidden,
            message: ResponseMessage.forbidden);
      case DataSource.notFound:
        return Failure(
            statusCode: ResponseCode.notFound,
            message: ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(
            statusCode: ResponseCode.internalServerError,
            message: ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(
            statusCode: ResponseCode.connectTimeout,
            message: ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return Failure(
            statusCode: ResponseCode.cancel, message: ResponseMessage.cancel);
      case DataSource.reciveTimeout:
        return Failure(
            statusCode: ResponseCode.reciveTimeout,
            message: ResponseMessage.reciveTimeout);
      case DataSource.sendTimeout:
        return Failure(
            statusCode: ResponseCode.sendTimeout,
            message: ResponseMessage.sendTimeout);
      case DataSource.cacheTimeout:
        return Failure(
            statusCode: ResponseCode.cacheTimeout,
            message: ResponseMessage.cacheTimeout);
      case DataSource.noInternetConnection:
        return Failure(
            statusCode: ResponseCode.noInternetConnection,
            message: ResponseMessage.noInternetConnection);
      case DataSource.unknown:
        return Failure(
            statusCode: ResponseCode.unknown,
            message: ResponseMessage.unknown);
      default:
        return Failure(
            statusCode: ResponseCode.unknown, message: ResponseMessage.unknown);
    }
  }
}


class ApiInternalStatus{
  static const int success = 0;
  static const int failure = 1;
}

class ResponseCode {
  //Api status codes
  static const int success = 200;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int internalServerError = 500;

  //local status codes
  static const int unknown = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int reciveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheTimeout = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  //Api status codes
  static const String success = "Success";
  static const String noContent = "Success with no Content";
  static const String badRequest = "Bad Request, try again later";
  static const String unauthorized = "User is Unauthorized, try again later";
  static const String forbidden = "Forbidden Request, try again later";
  static const String notFound = "URL is Not Found, try again later";
  static const String internalServerError =
      "Something went wrong, try again later";

  //local status codes
  static const String unknown = "Something went wrong, try again later";
  static const String connectTimeout = "Timeout error, try again later";
  static const String cancel = "Request was canceled, try again later";
  static const String reciveTimeout = "Timeout error, try again later";
  static const String sendTimeout = "Timeout error, try again later";
  static const String cacheTimeout = "Cache error, try again later";
  static const String noInternetConnection =
      "Please Check your internet connection";
}
