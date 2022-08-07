import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/app_binding.dart';
import 'package:todo/app/data/values/constants.dart';
import 'package:todo/app/data/values/env.dart';
import 'package:todo/app/routes/app_pages.dart';
import 'package:todo/app/theme/app_theme.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: getAllProviders(context),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: MaterialApp(
          scaffoldMessengerKey: scaffoldKey,
          title: Env.title,
          navigatorKey: GlobalKeys.navigationKey,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          initialRoute: Routes.SPLASH,
          routes: AppPages.pages,
        ),
      ),
    );
  }
}
