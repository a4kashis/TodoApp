import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/app/data/models/dto/TaskData.dart';
import 'package:todo/app/data/models/dto/User.dart';
import 'package:todo/app/data/values/images.dart';
import 'package:todo/main.dart';
import 'package:todo/utils/storage/storage_utils.dart';

class TaskRepository {
  final CollectionReference _todoCollection = fireStore.collection('todo');
  final CollectionReference _usersCollection = fireStore.collection('users');

  Future<bool> addTask(TaskData data) async {
    late final status;
    await _todoCollection
        .doc(data.id ?? "")
        .set(data.toJson())
        .then((value) => status = true)
        .catchError((error) {
      print(error);
      status = false;
    });
    return status;
  }

  Future<bool> updateTask(TaskData data) async {
    late final status;
    await _todoCollection
        .doc(data.id ?? "")
        .update(data.toJson())
        .then((value) => status = true)
        .catchError((error) {
      print(error);
      status = false;
    });
    return status;
  }

  Future<dynamic> getAllUsers() async {
    var response;
    await _usersCollection.get().then((value) {
      List<UserData> list = [];
      value.docs.forEach((element) {
        var user = UserData.fromJson(element.data());
        if (Storage.getUser().userId != user.userId) {
          list.add(user);
        }
      });
      response = list;
    }, onError: (e) {
      print(e);
      response = false;
    });
    return response;
  }

  Future<dynamic> getTasksList(String userId) async {
    var response;
    await _todoCollection.get().then((value) {
      List<TaskData> list = [];
      value.docs.forEach((element) {
        TaskData task = TaskData.fromJson(element.data());
        if (task.createdBy?.userId == userId) list.add(task);
        if (task.users != null) {
          for (UserData user in task.users!) {
            if (user.userId == userId) {
              if (!list.contains(task)) {
                list.add(task);
              }
            }
          }
        }
      });
      response = list;
    }, onError: (e) {
      print(e);
      response = false;
    });
    return response;
  }

  Future<dynamic> deleteTask(String taskId) async {
    var response;
    await _todoCollection.doc(taskId).delete().then((value) {
      response = true;
    }, onError: (e) {
      print(e);
      response = false;
    });
    return response;
  }
}
