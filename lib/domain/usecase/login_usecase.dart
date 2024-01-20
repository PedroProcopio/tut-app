import 'package:dartz/dartz.dart';
import 'package:tut_app/app/functions.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/request/request.dart';
import 'package:tut_app/domain/model/models.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase {
  final Repostory _repostory;

  LoginUseCase(this._repostory);

  @override
  Future<Either<Failure, dynamic>> execute(LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repostory.login(LoginRequest(
        email: input.email,
        password: input.password,
        imei: deviceInfo.identifier,
        deviceName: deviceInfo.name));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
