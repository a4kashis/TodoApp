import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/app/data/values/dimens.dart';
import 'package:todo/app/data/values/images.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/app/theme/styles.dart';
import 'package:todo/widgets/buttons/primary_filled_button.dart';

import '../controllers/auth_signup_controller.dart';

class AuthSignupView extends GetView<AuthSignupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            AppImages.loginHeader,
            height: 160,
            fit: BoxFit.fill,
            color: AppColors.primaryColor,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                    width: Dimens.screenWidth / 3,
                    child: Hero(
                        tag: AppImages.icAppLogo,
                        child: Image.asset(
                          AppImages.icAppLogo,
                        ))),
              ),
              SizedBox(height: Dimens.gapX3),
              Text(
                "YOUR\nTHING",
                style: GoogleFonts.titanOne(
                    fontSize: 44,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 6.0),
              Text(
                "Making life Easier !",
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Dimens.gapX5),
              Obx(
                () => PrimaryFilledButton(
                  child: controller.isLoading.value
                      ? CircularProgressIndicator()
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AppImages.icGoogle,
                              height: 30.0,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              "One Tap Login",
                              style: Styles.tsWhiteLight14,
                            ),
                          ],
                        ),
                  onTap: controller.isLoading.value ? null : controller.signup,
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ).paddingSymmetric(horizontal: 24.0, vertical: 16.0),
        ],
      ),
    );
  }
}
