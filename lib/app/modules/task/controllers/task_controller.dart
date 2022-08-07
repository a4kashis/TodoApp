import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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

class TaskController extends ChangeNotifier {
  HomeController? homeController;
  final formKey = GlobalKey<FormState>();
  final TaskRepository repository = TaskRepository();
  String type = "Business";
  String taskId = "";
  String thingType = "Shopping";
  TextFieldWrapper title = TextFieldWrapper();
  TextFieldWrapper description = TextFieldWrapper();
  TextFieldWrapper place = TextFieldWrapper();
  TextFieldWrapper time = TextFieldWrapper();
  TextFieldWrapper shareWith = TextFieldWrapper();
  bool isCompleted = false;
  List<String> typeList = const ["Business", "Personal"];
  DateTime today = DateTime.now();
  Uuid uuid = Uuid();
  bool isLoading = false;
  List<UserData> usersList = [];
  List<UserData> tempUsersList = [];
  List<String> tempUserIDList = [];
  UserData createdBy = UserData();

  void onInit(context, TaskData? task) {
    homeController = Provider.of<HomeController>(context, listen: false);
    getUsers();
    if (task != null) {
      taskId = task.id ?? "";
      title.controller.text = task.title ?? "";
      type = task.type ?? "";
      description.controller.text = task.description ?? "";
      place.controller.text = task.place ?? "";
      time.controller.text = task.timeStamp ?? "";
      isCompleted = task.isCompleted ?? false;
      createdBy = task.createdBy ?? UserData();
      tempUsersList = [];
      tempUserIDList = [];
      task.users?.forEach((element) {
        tempUsersList.add(element);
        tempUserIDList.add(element.userId ?? "");
      });
      generateShareWith();
    }
  }

  updateType(context, value) {
    Navigator.pop(context);
    thingType = value;
    notifyListeners();
  }

  deleteTask(context) async {
    bool response = await repository.deleteTask(taskId);
    if (response == true) {
      Navigator.pop(context);
      homeController?.getTasks();
      AppUtils.showSnackBar("Deleted Successfully");
    } else {
      AppUtils.showSnackBar(ErrorMessages.networkGeneral);
    }
  }

  void saveTask(context) async {
    if (formKey.currentState!.validate()) {
      TaskData task = TaskData(
        id: taskId,
        title: title.controller.text.trim(),
        type: type,
        description: description.controller.text.trim(),
        place: place.controller.text.trim(),
        timeStamp: time.controller.text.trim(),
        createdBy: Storage.getUser(),
        users: tempUsersList,
        thingType: thingType,
        isCompleted: isCompleted,
      );

      log("taskData ${jsonEncode(task.toJson())}");
      isLoading = true;
      notifyListeners();

      bool? response;
      if (taskId.isEmpty) {
        task.id = uuid.v1();
        response = await repository.addTask(task);
      } else {
        response = await repository.updateTask(task);
      }
      log("$response");
      isLoading = false;
      if (response == true) {
        Navigator.pop(context);
        AppUtils.showSnackBar("Request Successful");
        homeController?.getTasks();
        log("Successful");
      }
      notifyListeners();
    }
  }

  getUsers() async {
    var response = await repository.getAllUsers();
    if (response != false) {
      usersList = response;
      print("userslength ${usersList.length}");
      notifyListeners();
    }
  }

  updateCompletionStatus(value) {
    isCompleted = value;
    notifyListeners();
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
    notifyListeners();
  }

  generateShareWith() {
    shareWith.controller.text = "";
    for (var user in tempUsersList)
      shareWith.controller.text =
          shareWith.controller.text + "| ${user.name ?? ""} ";
  }

  pickDate(context) async {
    DateTime? date = await showDatePicker(
        context: context,
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

  void onDispose() {
    type = "Business";
    taskId = "";
    title.controller.text = "";
    description.controller.text = "";
    place.controller.text = "";
    time.controller.text = "";
    isCompleted = false;
    createdBy = UserData();
    tempUsersList = [];
    tempUserIDList = [];
    shareWith.controller.text = "";
  }
}
