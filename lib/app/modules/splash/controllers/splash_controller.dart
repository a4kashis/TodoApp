import 'package:flutter/material.dart';
import 'package:todo/app/routes/app_pages.dart';
import 'package:todo/utils/storage/storage_utils.dart';

class SplashController extends ChangeNotifier {
  void onInit(BuildContext context) {
    _startOnBoarding(context);
  }

  _startOnBoarding(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));

    if (Storage.isUserExists())
      Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (route) => false);
    else
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.AUTH_SIGNUP, (route) => false);
  }
}
