import 'package:get/get.dart';
import 'package:todo/app/modules/auth/signup/bindings/auth_signup_binding.dart';
import 'package:todo/app/modules/auth/signup/views/auth_signup_view.dart';
import 'package:todo/app/modules/home/bindings/home_binding.dart';
import 'package:todo/app/modules/home/views/home_view.dart';
import 'package:todo/app/modules/splash/bindings/splash_binding.dart';
import 'package:todo/app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: Routes.AUTH_SIGNUP,
      page: () => AuthSignupView(),
      binding: AuthSignupBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
