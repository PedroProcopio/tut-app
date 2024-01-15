import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImplemeter extends NetworkInfo {
  final InternetConnectionChecker _internetConnectionChecker;

  NetworkInfoImplemeter(this._internetConnectionChecker);

  @override
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;
}
