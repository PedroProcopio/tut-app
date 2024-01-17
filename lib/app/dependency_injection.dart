import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/data/datasource/remote_data_source.dart';
import 'package:tut_app/data/network/api_app.dart';
import 'package:tut_app/data/network/dio_factory.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/repository/repository_implementer.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/login/login_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplemeter(InternetConnectionChecker()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<Repostory>(
      () => RepositoryImpl(instance(), instance()));

  initAppModule();
}

initLoginModule() {
  if (!GetIt.instance.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
