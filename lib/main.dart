import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/app/app.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;

void main() async {
  await initGetStorage();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

Future initGetStorage() async {
  await GetStorage.init();
}
