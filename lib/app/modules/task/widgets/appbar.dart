import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:todo/app/data/values/dimens.dart';
import 'package:todo/app/data/values/images.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/app/theme/styles.dart';
import 'package:todo/utils/storage/storage_utils.dart';
import 'package:todo/widgets/buttons/primary_filled_button.dart';

import '../controllers/task_controller.dart';

class CustomAppBar extends GetView<TaskController> {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.secondaryColor,
              )),
          Text("Add New Thing", style: Styles.tsWhiteLight14),
          controller.type.isEmpty ||
                  controller.createdBy.value.userId != Storage.getUser().userId
              ? SizedBox(width: 50)
              : SizedBox(
                  width: 50,
                  child: IconButton(
                      onPressed: controller.deleteTask,
                      icon: Icon(
                        Icons.delete_outline_outlined,
                        size: 26,
                        color: AppColors.secondaryColor,
                      )),
                ),
        ],
      ).paddingSymmetric(vertical: 10.0, horizontal: 13.0),
    );
  }
}
