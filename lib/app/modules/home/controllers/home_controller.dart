import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:todo/app/data/models/dto/TaskData.dart';
import 'package:todo/app/data/repository/task_repository.dart';
import 'package:todo/base/base_controller.dart';
import 'package:todo/utils/storage/storage_utils.dart';

class HomeController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final repository = TaskRepository();
  List<TaskData> taskData = [];
  String today = DateFormat.yMMMd().format(DateTime.now());
  int personalCount = 0;
  int businessCount = 0;
  int completedCount = 0;
  bool isLoading = false;

  void onInit() {
    getTasks();
  }

  openDrawer() => scaffoldKey.currentState!.openDrawer();

  getTasks() async {
    isLoading = true;
    var response =
        await repository.getTasksList(Storage.getUser().userId ?? "");
    if (response != false) {
      taskData = response;
      businessCount = 0;
      personalCount = 0;
      completedCount = 0;

      response.forEach((TaskData element) {
        if (element.type == "Business")
          businessCount = businessCount + 1;
        else if (element.type == "Personal") personalCount = personalCount + 1;
        if (element.isCompleted == true) completedCount = completedCount + 1;
      });
    }
    isLoading = false;
    notifyListeners();
  }
}
