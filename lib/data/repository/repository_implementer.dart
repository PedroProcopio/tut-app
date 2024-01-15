import 'package:dartz/dartz.dart';
import 'package:tut_app/data/datasource/remote_data_source.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/request/request.dart';
import 'package:tut_app/data/responses/responses.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/domain/repository.dart';

class RepositoryImpl extends Repostory {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, AuthenticationResponse>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.login(loginRequest);

      if (response.status == "200") {
        return Right(response.toDomain());
      } else {
        return Left(Failure(
            statusCode: 409,
            message: response.message ??
                "we have a biz error logic from the api side"));
      }
    } else {
      return Left(Failure(
          statusCode: 501, message: "please check your internet connection"));
    }
  }
}
