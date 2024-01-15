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
  noInternetConnection
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
