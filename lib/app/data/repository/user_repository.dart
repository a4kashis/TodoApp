import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/app/data/models/dto/User.dart';

import 'package:todo/main.dart';

class UserRepository {
  final CollectionReference _usersCollection = fireStore.collection('users');

  Future<bool> pushUser(UserData data) async {
    late final status;
    await _usersCollection
        .doc(data.userId)
        .set(data.toJson())
        .then((value) => status = true)
        .catchError((error) => status = false);
    return status;
  }
}
