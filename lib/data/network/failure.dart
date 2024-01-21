import 'package:tut_app/data/network/error_handler.dart';

class Failure {
  final int statusCode;
  final String message;

  Failure({required this.statusCode, required this.message});
}

class DefaultFailure extends Failure {
  DefaultFailure()
      : super(
            statusCode: ResponseCode.unknown, message: ResponseMessage.unknown);
}
