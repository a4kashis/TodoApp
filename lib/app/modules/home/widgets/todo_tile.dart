import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:todo/app/data/models/dto/TaskData.dart';
import 'package:todo/app/data/models/dto/User.dart';
import 'package:todo/app/data/values/dimens.dart';
import 'package:todo/app/data/values/images.dart';
import 'package:todo/app/modules/task/views/task_view.dart';
import 'package:todo/app/routes/app_pages.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/app/theme/styles.dart';
import 'package:todo/utils/app_utils.dart';

class TodoTile extends StatelessWidget {
  final TaskData taskData;

  const TodoTile({Key? key, required this.taskData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.TASK_DETAILS, arguments: taskData),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xffe1e1e1), width: 1.0),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              thingType[taskData.thingType] ?? "",
              color: AppColors.primaryColor,
              height: 30,
            ),
          ),
          SizedBox(width: Dimens.gapX2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskData.title ?? "",
                  style: Styles.tsBlackMedium14,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 4.0),
                Text(
                  taskData.description ?? "",
                  style: Styles.tsBlackRegular12,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          SizedBox(width: Dimens.gapX2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppUtils.getFormattedDateTime(taskData.timeStamp ?? ""),
                  style: Styles.tsBlackRegular12),
              SizedBox(height: Dimens.gapX1),
              if (taskData.users != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (UserData user in taskData.users!)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(user.profileUrl ?? "",
                            height: 20, width: 20),
                      ).paddingOnly(right: 2.0),
                  ],
                )
            ],
          )
        ],
      ).paddingSymmetric(vertical: 20.0, horizontal: 24.0),
    );
  }
}
