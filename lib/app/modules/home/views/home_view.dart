import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/data/values/dimens.dart';
import 'package:todo/app/modules/home/widgets/app_drawer.dart';
import 'package:todo/app/modules/home/widgets/dashboard.dart';
import 'package:todo/app/modules/home/widgets/todo_shimmer.dart';
import 'package:todo/app/modules/home/widgets/todo_tile.dart';
import 'package:todo/app/modules/task/controllers/task_controller.dart';
import 'package:todo/app/modules/task/views/task_view.dart';
import 'package:todo/app/routes/app_pages.dart';
import 'package:todo/app/theme/app_colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeController homeController;

  @override
  void initState() {
    homeController = Provider.of<HomeController>(context, listen: false);
    homeController.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, controller, child) {
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, bottom: 10.0, top: 20.0),
                        child: Text("INBOX"),
                      ),
                      controller.isLoading
                          ? TodoShimmer()
                          : ListView.separated(
                              itemCount: controller.taskData.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              itemBuilder: (ctx, i) =>
                                  TodoTile(taskData: controller.taskData[i]),
                              separatorBuilder: (ctx, i) =>
                                  Divider(height: 0.0),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, bottom: 30.0, top: 20.0),
                        child: Row(
                          children: [
                            Text("COMPLETED"),
                            SizedBox(width: Dimens.gapX1),
                            Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF9a9dab)),
                              child: Text(
                                "${controller.completedCount}",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TaskView()),
                ),
            child: Icon(Icons.add)),
      );
    });
  }
}
