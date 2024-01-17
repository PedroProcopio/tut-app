import 'package:tut_app/app/dependency_injection.dart';
import 'package:tut_app/presentation/forgot_password/forgot_password.dart';
import 'package:tut_app/presentation/login/login.dart';
import 'package:tut_app/presentation/main/main_view.dart';
import 'package:tut_app/presentation/onboarding/onboarding.dart';
import 'package:tut_app/presentation/register/register.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/splash/splash.dart';
import 'package:tut_app/presentation/store_details/store_details.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String mainRoute = "/main";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String loginRoute = "/login";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(title: const Text(AppStrings.noRouteFound)),
              body: const Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}
