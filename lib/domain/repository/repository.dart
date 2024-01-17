import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/request/request.dart';
import 'package:tut_app/data/responses/responses.dart';
import 'package:tut_app/domain/models.dart';
import 'package:dartz/dartz.dart';

abstract class Repostory {
  Future<Either<Failure, AuthenticationResponse>> login(
      LoginRequest loginRequest);
}
