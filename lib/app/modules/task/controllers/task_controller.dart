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
  final RxList<String> tempUserIDList = RxList();
  final Rx<UserData> createdBy = UserData().obs;

  @override
  void onInit() {
    getUsers();
    getArguments();
    super.onInit();
  }

  void getArguments() async {
    if (Get.arguments != null) {
      TaskData arguments = Get.arguments;
      taskId.value = arguments.id ?? "";
      title.controller.text = arguments.title ?? "";
      type.value = arguments.type ?? "";
      description.controller.text = arguments.description ?? "";
      place.controller.text = arguments.place ?? "";
      time.controller.text = arguments.timeStamp ?? "";
      isCompleted.value = arguments.isCompleted ?? false;
      createdBy.value = arguments.createdBy ?? UserData();
      tempUsersList.value = [];
      tempUserIDList.value = [];
      arguments.users?.forEach((element) {
        tempUsersList.add(element);
        tempUserIDList.add(element.userId ?? "");
      });
      generateShareWith();
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
      isLoading.value = true;
      bool? response;
      if (taskId.isEmpty) {
        task.id = uuid.v1();
        response = await repository.addTask(task);
      } else {
        response = await repository.updateTask(task);
      }
      log("$response");
      isLoading.value = false;
      if (response == true) {
        Get.back();
        AppUtils.showSnackBar("Request Successful");
        _homeController.getTasks();
        log("Successful");
      }
    }
  }

  getUsers() async {
    var response = await repository.getAllUsers();
    if (response != false) {
      usersList.assignAll(response);
    }
  }

  handleUser(UserData user) {
    if (tempUserIDList.contains(user.userId)) {
      tempUserIDList.remove(user.userId);
      tempUsersList.removeWhere((e) => e.userId == user.userId);
    } else {
      tempUsersList.add(user);
      tempUserIDList.add(user.userId ?? "");
    }
    generateShareWith();
  }

  generateShareWith() {
    shareWith.controller.text = "";
    for (var user in tempUsersList)
      shareWith.controller.text =
          shareWith.controller.text + "| ${user.name ?? ""} ";
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
