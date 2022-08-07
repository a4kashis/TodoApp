import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/data/values/dimens.dart';
import 'package:todo/app/data/values/images.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/app/theme/styles.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: SizedBox(
            width: Dimens.screenWidth / 2,
            child: Hero(
                tag: AppImages.icAppLogo,
                child: Image.asset(AppImages.icAppLogo))),
      ),
    );
  }
}
