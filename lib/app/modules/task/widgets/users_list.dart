import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/modules/task/controllers/task_controller.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/app/theme/styles.dart';

class UsersList extends StatelessWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TaskController>(context, listen: true);
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.width / 1.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Users", style: Styles.tsWhiteLight14),
          SizedBox(height: 10.0),
          Divider(color: AppColors.white, thickness: 0.1),
          controller.usersList.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.usersList.length,
                  itemBuilder: (ctx, i) => ListTile(
                    title: Text(
                      controller.usersList[i].name ?? "",
                      style: Styles.tsWhiteLight14,
                    ),
                    onTap: () => controller.handleUser(controller.usersList[i]),
                    trailing: controller.tempUserIDList
                            .contains(controller.usersList[i].userId ?? "")
                        ? Icon(Icons.check, color: AppColors.secondaryColor)
                        : SizedBox(),
                  ),
                  separatorBuilder: (ctx, i) => SizedBox(height: 8.0),
                )
              : Text("No Users", style: Styles.tsWhiteLight14),
        ],
      ),
    );
  }
}
