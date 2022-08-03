import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/app/data/models/dto/TaskData.dart';
import 'package:todo/app/data/models/dto/User.dart';
import 'package:todo/app/data/repository/task_repository.dart';
import 'package:todo/app/data/values/strings.dart';
import 'package:todo/app/modules/home/controllers/home_controller.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/base/base_controller.dart';
import 'package:todo/utils/app_utils.dart';
import 'package:todo/utils/helper/text_field_wrapper.dart';
import 'package:todo/utils/storage/storage_utils.dart';
import 'package:uuid/uuid.dart';

class TaskController extends BaseController<TaskRepository> {
  final formKey = GlobalKey<FormState>();
  final HomeController _homeController = Get.find();
  final RxString type = RxString("Business");
  final RxString taskId = RxString("");
  final RxString thingType = RxString("Shopping");
  final TextFieldWrapper title = TextFieldWrapper();
  final TextFieldWrapper description = TextFieldWrapper();
  final TextFieldWrapper place = TextFieldWrapper();
  final TextFieldWrapper time = TextFieldWrapper();
  final TextFieldWrapper shareWith = TextFieldWrapper();
  final RxBool isCompleted = RxBool(false);
  final List<String> typeList = const ["Business", "Personal"];
  final DateTime today = DateTime.now();
  final uuid = Uuid();
  final RxBool isLoading = RxBool(false);
  final RxList<UserData> usersList = RxList();
  final RxList<UserData> tempUsersList = RxList();

  @override
  void onInit() {
    getArguments();
    getUsers();
    super.onInit();
  }

  void getArguments() {
    if (Get.arguments != null) {
      TaskData arguments = Get.arguments;
      taskId.value = arguments.id ?? "";
      title.controller.text = arguments.title ?? "";
      type.value = arguments.type ?? "";
      description.controller.text = arguments.description ?? "";
      place.controller.text = arguments.place ?? "";
      time.controller.text = arguments.timeStamp ?? "";
      tempUsersList.assignAll(arguments.users ?? []);
      isCompleted.value = arguments.isCompleted ?? false;
    }
  }

  deleteTask() async {
    bool response = await repository.deleteTask(taskId.value);
    if (response == true) {
      Get.back();
      _homeController.getTasks();
      AppUtils.showSnackBar("Deleted Successfully");
    } else {
      AppUtils.showSnackBar(ErrorMessages.networkGeneral);
    }
  }

  void saveTask() async {
    if (formKey.currentState!.validate()) {
      TaskData task = TaskData(
        id: taskId.value,
        title: title.controller.text.trim(),
        type: type.value,
        description: description.controller.text.trim(),
        place: place.controller.text.trim(),
        timeStamp: time.controller.text.trim(),
        createdBy: Storage.getUser(),
        users: tempUsersList,
        thingType: thingType.value,
        isCompleted: isCompleted.value,
      );

      log("taskData ${jsonEncode(task.toJson())}");
      bool response;
      if (taskId.isEmpty) {
        task.id = uuid.v1();
        response = await repository.addTask(task);
      } else {
        response = await repository.updateTask(task);
      }
      log("$response");

      if (response == true) {
        Get.back();
        AppUtils.showSnackBar("Request Successful");
        _homeController.getTasks();
        log("Successful");
      }
    }
  }

  void getUsers() async {
    var response = await repository.getAllUsers();
    if (response != false) {
      usersList.assignAll(response);
    }
  }

  void addItem(UserData user) {
    if (tempUsersList.contains(user)) {
      tempUsersList.remove(user);
    } else {
      tempUsersList.add(user);
    }
    shareWith.controller.text = "";
    for (UserData user in tempUsersList)
      shareWith.controller.text =
          " ${shareWith.controller.text} ${user.name ?? ""}";
    print(tempUsersList.length);
  }

  pickDate() async {
    DateTime? date = await showDatePicker(
        context: Get.context!,
        initialDate: today,
        firstDate: today,
        lastDate: DateTime(today.year + 1),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
            ),
            child: child!,
          );
        });

    if (date != null) {
      time.controller.text = DateFormat("dd/MM/yyyy").format(date);
    }
  }
}
