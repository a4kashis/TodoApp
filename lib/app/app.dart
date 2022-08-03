import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/app_binding.dart';
import 'package:todo/app/data/values/constants.dart';
import 'package:todo/app/data/values/env.dart';
import 'package:todo/app/routes/app_pages.dart';
import 'package:todo/app/theme/app_theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: GetMaterialApp(
        title: Env.title,
        navigatorKey: GlobalKeys.navigationKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        initialRoute: Routes.SPLASH,
        getPages: AppPages.pages,
        defaultTransition: Transition.cupertino,
        initialBinding: AppBinding(),
      ),
    );
  }
}
