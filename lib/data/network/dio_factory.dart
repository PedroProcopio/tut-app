import 'package:dio/dio.dart';
import 'package:tut_app/app/constants.dart';


const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-Type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LENGUAGE = "lenguage";



class DioFactory{

  Future<Dio> getDio() async{
    Dio dio = Dio();

    Duration timeOut = const Duration(seconds: 60*1000);

    Map<String,String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constants.token,
      DEFAULT_LENGUAGE: "en"

    };

    dio.options = BaseOptions( 
      baseUrl: Constants.baseUrl,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      headers: headers
    );

    return dio;
  }
}