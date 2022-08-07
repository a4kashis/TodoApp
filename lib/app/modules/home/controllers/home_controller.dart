import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/app/data/models/dto/TaskData.dart';
import 'package:todo/app/data/repository/task_repository.dart';
import 'package:todo/base/base_controller.dart';
import 'package:todo/utils/storage/storage_utils.dart';

class HomeController extends BaseController<TaskRepository> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final RxList<TaskData> taskData = RxList();
  final String today = DateFormat.yMMMd().format(DateTime.now());
  final RxInt personalCount = RxInt(0);
  final RxInt businessCount = RxInt(0);
  final RxInt completedCount = RxInt(0);
  final RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    getTasks();
    super.onInit();
  }

  openDrawer() => scaffoldKey.currentState!.openDrawer();

  getTasks() async {
    isLoading.value = true;
    var response =
        await repository.getTasksList(Storage.getUser().userId ?? "");
    if (response != false) {
      taskData.assignAll(response);
      businessCount.value = 0;
      personalCount.value = 0;
      completedCount.value = 0;

      response.forEach((TaskData element) {
        if (element.type == "Business")
          businessCount.value = businessCount.value + 1;
        else if (element.type == "Personal")
          personalCount.value = personalCount.value + 1;
        if (element.isCompleted == true)
          completedCount.value = completedCount.value + 1;
      });
    }
    isLoading.value = false;
  }
}
