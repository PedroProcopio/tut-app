import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut_app/app/dependency_injection.dart';
import 'package:tut_app/data/datasource/remote_data_source.dart';
import 'package:tut_app/data/repository/repository_implementer.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/login/login_viewmodel.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _bindViewModel() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bindViewModel();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        padding: EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Image(image: AssetImage(ImageAssets.splashLogo)),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _userNameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: AppStrings.username,
                          labelText: AppStrings.username,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.usernameError,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: AppStrings.password,
                          labelText: AppStrings.password,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.passwordError,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: AppSize.s28),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder(
                    stream: _viewModel.outputIsAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewModel.login();
                                }
                              : null,
                          child: const Text(AppStrings.login),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p8,
                      left: AppPadding.p28,
                      right: AppPadding.p28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.forgotPasswordRoute);
                        },
                        child: Text(AppStrings.forgetPassword,
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.registerRoute);
                        },
                        child: Text(AppStrings.dontHaveAccount,
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
