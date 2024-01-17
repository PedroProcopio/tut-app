import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/domain/usecase/login_usecase.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(LoginUseCaseInput request);
}
