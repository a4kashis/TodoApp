import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/modules/task/controllers/task_controller.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/app/theme/styles.dart';
import 'package:todo/utils/storage/storage_utils.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(builder: (context, controller, child) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.secondaryColor,
                ),
              ),
              Text(
                  controller.type.isEmpty ||
                          controller.createdBy.userId !=
                              Storage.getUser().userId
                      ? "Add New Thing"
                      : "Update New Thing",
                  style: Styles.tsWhiteLight14),
              controller.type.isEmpty ||
                      controller.createdBy.userId != Storage.getUser().userId
                  ? SizedBox(width: 50)
                  : SizedBox(
                      width: 50,
                      child: IconButton(
                          onPressed: () => controller.deleteTask(context),
                          icon: Icon(
                            Icons.delete_outline_outlined,
                            size: 26,
                            color: AppColors.secondaryColor,
                          )),
                    ),
            ],
          ),
        ),
      );
    });
  }
}
