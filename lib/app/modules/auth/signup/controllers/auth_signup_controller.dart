import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/app/data/models/dto/response.dart';
import 'package:todo/app/data/models/dto/User.dart';
import 'package:todo/app/data/repository/user_repository.dart';
import 'package:todo/app/routes/app_pages.dart';
import 'package:todo/base/base_controller.dart';
import 'package:todo/utils/storage/storage_utils.dart';

class AuthSignupController extends BaseController<UserRepository> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final RxBool isLoading = RxBool(false);

  Future<void> signup() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      isLoading.value = true;
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential result = await auth.signInWithCredential(authCredential);
      isLoading.value = false;
      User? user = result.user;

      if (user != null) {
        UserData userData = UserData(
          userId: user.uid,
          name: user.displayName ?? "",
          phone: user.phoneNumber ?? "",
          email: user.email ?? "",
          profileUrl: user.photoURL ?? "",
        );
        isLoading.value = true;
        bool response = await repository.pushUser(userData);
        isLoading.value = false;
        if (response == true) {
          Storage.setUser(userData);
          Get.offAllNamed(Routes.HOME);
        }
      }
    }
  }
}
