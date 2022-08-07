import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo/app/data/values/dimens.dart';
import 'package:todo/app/data/values/images.dart';
import 'package:todo/app/modules/splash/controllers/splash_controller.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/app/theme/styles.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    SplashController splashController =
        Provider.of<SplashController>(context, listen: false);
    splashController.onInit(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Hero(
                tag: AppImages.icAppLogo,
                child: Image.asset(AppImages.icAppLogo))),
      ),
    );
  }
}
