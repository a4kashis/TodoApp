import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/data/values/dimens.dart';
import 'package:todo/app/modules/task/controllers/task_controller.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/app/theme/styles.dart';

class UsersList extends GetView<TaskController> {
  const UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ConstrainedBox(
        constraints: BoxConstraints(maxHeight: Dimens.screenWidthX12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Users", style: Styles.tsWhiteLight14),
            SizedBox(height: 10.0),
            Divider(color: AppColors.white, thickness: 0.1),
            ListView.separated(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: controller.usersList.length,
              itemBuilder: (ctx, i) => ListTile(
                title: Text(
                  controller.usersList[i].name ?? "",
                  style: Styles.tsWhiteLight14,
                ),
                onTap: () => controller.addItem(controller.usersList[i]),
                trailing: Obx(
                  () =>
                      controller.tempUsersList.contains(controller.usersList[i])
                          ? Icon(Icons.check, color: AppColors.secondaryColor)
                          : SizedBox(),
                ),
              ),
              separatorBuilder: (ctx, i) => SizedBox(height: 8.0),
            ),
          ],
        ),
      ),
    );
  }
}
