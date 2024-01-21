import 'dart:async';

import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/base/base_viewmodel.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  //CONTROLLERS

  final StreamController<String> _userNameController =
      StreamController<String>.broadcast();
  final StreamController<String> _passwordController =
      StreamController<String>.broadcast();

  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = const LoginObject(username: "", password: "");

  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  //METHODS

  //INPUTS
  @override
  void dispose() {
    _userNameController.close();
    _passwordController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;

  @override
  Sink<String> get inputPassword => _passwordController.sink;

  @override
  Sink<String> get inputUserName => _userNameController.sink;

  @override
  void login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.username!, loginObject.password!)))
        .fold(
      (failure) {
        inputState.add(ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.message!));
      },
      (data) {
        inputState.add(ContentState());
      },
    );
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
    _validate();
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }

  //OUTPUTS
  @override
  Stream<bool> get outputIsPasswordValid =>
      _passwordController.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid =>
      _userNameController.stream.map((userName) => _isUserNameValid(userName));

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password!) &&
        _isUserNameValid(loginObject.username!);
  }

  @override
  // TODO: implement outputPassword
  Stream<String> get outputPassword => throw UnimplementedError();

  @override
  // TODO: implement outputUserName
  Stream<String> get outputUserName => throw UnimplementedError();

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());
}

mixin LoginViewModelInputs {
  setUserName(String userName);
  setPassword(String password);
  void login();

  Sink<String> get inputUserName;
  Sink<String> get inputPassword;
  Sink get inputIsAllInputValid;
}

mixin LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<String> get outputUserName;
  Stream<String> get outputPassword;
  Stream<bool> get outputIsAllInputsValid;
}
