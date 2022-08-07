import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:todo/app/modules/auth/signup/controllers/auth_signup_controller.dart';
import 'package:todo/app/modules/home/controllers/home_controller.dart';
import 'package:todo/app/modules/splash/controllers/splash_controller.dart';
import 'package:todo/app/modules/task/controllers/task_controller.dart';

List<SingleChildWidget> getAllProviders(BuildContext context) {
  return [
    ChangeNotifierProvider(create: (context) => SplashController()),
    ChangeNotifierProvider(create: (context) => AuthSignupController()),
    ChangeNotifierProvider(create: (context) => HomeController()),
    ChangeNotifierProvider(create: (context) => TaskController()),
  ];
}
