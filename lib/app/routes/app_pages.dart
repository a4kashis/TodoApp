import 'package:flutter/material.dart';
import 'package:todo/app/modules/auth/signup/views/auth_signup_view.dart';
import 'package:todo/app/modules/home/views/home_view.dart';
import 'package:todo/app/modules/splash/views/splash_view.dart';
import 'package:todo/app/modules/task/views/task_view.dart';

part 'app_routes.dart';

class AppPages {
  static final Map<String, Widget Function(BuildContext)> pages = {
    Routes.SPLASH: (context) => const SplashView(),
    Routes.AUTH_SIGNUP: (context) => const AuthSignupView(),
    Routes.HOME: (context) => const HomeView(),
  };
}
