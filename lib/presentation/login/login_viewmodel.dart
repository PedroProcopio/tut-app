import 'dart:async';

import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/base/base_viewmodel.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  //CONTROLLERS

  final StreamController<String> _userNameController =
      StreamController<String>.broadcast();
  final StreamController<String> _passwordController =
      StreamController<String>.broadcast();

  var loginObject = LoginObject(username: "", password: "");

  LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  //METHODS

  //INPUTS
  @override
  void dispose() {
    _userNameController.close();
    _passwordController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink<String> get inputPassword => _passwordController.sink;

  @override
  Sink<String> get inputUserName => _userNameController.sink;

  @override
  void login() async {
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.username!, loginObject.password!)))
        .fold((failure) {
      print(failure.message);
    }, (data) {
      print(data.customer?.name);
    });
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(username: userName);
  }

  //OUTPUTS
  @override
  Stream<bool> get isPasswordValid =>
      _passwordController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get isUserNameValid =>
      _userNameController.stream.map((userName) => _isUserNameValid(userName));

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  @override
  // TODO: implement outputPassword
  Stream<String> get outputPassword => throw UnimplementedError();

  @override
  // TODO: implement outputUserName
  Stream<String> get outputUserName => throw UnimplementedError();
}

mixin LoginViewModelInputs {
  setUserName(String userName);
  setPassword(String password);
  void login();

  Sink<String> get inputUserName;
  Sink<String> get inputPassword;
}

mixin LoginViewModelOutputs {
  Stream<bool> get isUserNameValid;
  Stream<bool> get isPasswordValid;
  Stream<String> get outputUserName;
  Stream<String> get outputPassword;
}
