import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:todo/app/data/models/dto/User.dart';
import 'package:todo/app/data/repository/user_repository.dart';
import 'package:todo/app/routes/app_pages.dart';
import 'package:todo/base/base_controller.dart';
import 'package:todo/utils/storage/storage_utils.dart';

class AuthSignupController extends ChangeNotifier {
  final repository = UserRepository();
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  bool isLoading = false;

  Future<void> signup(BuildContext context) async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential result = await auth.signInWithCredential(authCredential);

      User? user = result.user;

      if (user != null) {
        UserData userData = UserData(
          userId: user.uid,
          name: user.displayName ?? "",
          phone: user.phoneNumber ?? "",
          email: user.email ?? "",
          profileUrl: user.photoURL ?? "",
        );
        isLoading = true;
        notifyListeners();

        bool response = await repository.pushUser(userData);

        isLoading = false;
        notifyListeners();

        if (response == true) {
          Storage.setUser(userData);
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.HOME, (route) => false);
        }
      }
    }
  }
}
