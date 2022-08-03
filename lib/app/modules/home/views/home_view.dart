import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:todo/app/data/values/dimens.dart';
import 'package:todo/app/data/values/images.dart';
import 'package:todo/app/modules/home/widgets/app_drawer.dart';
import 'package:todo/app/modules/home/widgets/dashboard.dart';
import 'package:todo/app/modules/home/widgets/todo_tile.dart';
import 'package:todo/app/routes/app_pages.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/app/theme/styles.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: AppDrawer(),
      body: Column(
        children: [
          Dashboard(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => controller.getTasks(),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("INBOX")
                        .paddingOnly(left: 30.0, bottom: 10.0, top: 20.0),
                    Obx(
                      () => ListView.separated(
                        itemCount: controller.taskData.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        itemBuilder: (ctx, i) =>
                            TodoTile(taskData: controller.taskData[i]),
                        separatorBuilder: (ctx, i) => Divider(height: 0.0),
                      ),
                    ),
                    Row(
                      children: [
                        Text("COMPLETED"),
                        SizedBox(width: Dimens.gapX1),
                        Container(
                            padding: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF9a9dab)),
                            child: Obx(
                              () => Text(
                                "${controller.completedCount.value}",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                      ],
                    ).paddingOnly(left: 30.0, bottom: 30.0, top: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.TASK_DETAILS),
          child: Icon(Icons.add)),
    );
  }
}
