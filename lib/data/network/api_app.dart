import 'package:tut_app/data/responses/responses.dart';
import 'package:retrofit/http.dart';
import 'package:tut_app/app/constants.dart';
import 'package:dio/dio.dart';
part 'api_app.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient{

  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;


  @POST("/customers/login")
  Future<AuthenticationResponse> login(

    @Field("email") String email,
    @Field("password") String password,
    @Field("imei") String imei,
    @Field("deviceType") String deviceType

  );

}