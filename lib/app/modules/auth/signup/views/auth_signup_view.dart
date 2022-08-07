import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:todo/app/data/values/dimens.dart';
import 'package:todo/app/data/values/images.dart';
import 'package:todo/app/modules/auth/signup/controllers/auth_signup_controller.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/app/theme/styles.dart';
import 'package:todo/widgets/buttons/primary_filled_button.dart';
import 'package:provider/provider.dart';

class AuthSignupView extends StatelessWidget {
  const AuthSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthSignupController>(
        builder: (context, authController, child) {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              AppImages.loginHeader,
              height: 160,
              fit: BoxFit.fill,
              color: AppColors.primaryColor,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Hero(
                            tag: AppImages.icAppLogo,
                            child: Image.asset(
                              AppImages.icAppLogo,
                            ))),
                    SizedBox(height: Dimens.gapX3),
                    Text(
                      "YOUR\nTHING",
                      style: GoogleFonts.titanOne(
                          fontSize: 44,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      "Making life Easier !",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: Dimens.gapX3),
                    PrimaryFilledButton(
                      child: authController.isLoading
                          ? Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CircularProgressIndicator(),
                            )
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
                      onTap: () => authController.isLoading
                          ? null
                          : authController.signup(context),
                      color: AppColors.primaryColor,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 160)
          ],
        ),
      );
    });
  }
}
