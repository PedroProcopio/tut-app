import 'package:tut_app/data/network/api_app.dart';
import 'package:tut_app/data/request/request.dart';
import 'package:tut_app/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final AppServiceClient _apiServiceClient;

  RemoteDataSourceImpl(this._apiServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _apiServiceClient.login(loginRequest.email,
        loginRequest.password, loginRequest.imei, loginRequest.deviceName);
  }
}
