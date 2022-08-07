import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo/app/data/values/dimens.dart';
import 'package:todo/app/data/values/images.dart';
import 'package:todo/app/modules/home/controllers/home_controller.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/app/theme/styles.dart';
import 'package:todo/utils/app_utils.dart';

class Dashboard extends GetView<HomeController> {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.screenHeight / 3.3,
      child: Stack(
        children: [
          Image.asset(
            AppImages.bgCover,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Row(
            children: [
              Expanded(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: controller.openDrawer,
                              child: Icon(
                                FontAwesomeIcons.barsStaggered,
                                color: AppColors.white,
                                size: 20,
                              ),
                            ),
                            SizedBox(height: Dimens.gapX2),
                            Text("Your\nThings",
                                style: Styles.tsWhiteRegular32),
                            Spacer(),
                            Text(
                                AppUtils.getFormattedDateTime(controller.today),
                                style: Styles.tsGreyLight12),
                          ],
                        ).paddingOnly(left: 24.0, top: 20.0, bottom: 20.0),
                      ),
                      Container(
                        height: 4.0,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          AppColors.primaryColor,
                          AppColors.secondaryColor
                        ])),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: Dimens.screenWidth / 2.2,
                decoration:
                    BoxDecoration(color: AppColors.black.withOpacity(0.2)),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            valueTile(
                                title: "Personal",
                                value: (controller.personalCount.value)
                                    .toString()
                                    .padLeft(2, "0")),
                            valueTile(
                                title: "Business",
                                value: controller.businessCount.value
                                    .toString()
                                    .padLeft(2, "0")),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimens.gapX4),
                      Center(
                        child: Obx(
                          () => controller.isLoading.value
                              ? SizedBox(height: 26)
                              : SizedBox(
                                  height: 26.0,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 12.0,
                                        lineWidth: 2.6,
                                        percent: controller.taskData.length != 0
                                            ? (controller.completedCount.value /
                                                controller.taskData.length)
                                            : 0,
                                        linearGradient: LinearGradient(colors: [
                                          AppColors.primaryColor,
                                          AppColors.secondaryColor,
                                        ]),
                                      ),
                                      SizedBox(width: Dimens.gapX1),
                                      Text(
                                        "${controller.taskData.length != 0 ? (controller.completedCount.value / controller.taskData.length * 100).round() : 0}% Done",
                                        style: Styles.tsGreyLight12,
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      )
                    ],
                  ).paddingOnly(
                      left: 10.0, right: 24.0, top: 20.0, bottom: 20.0),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget valueTile({required String title, required String value}) => Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            value,
            style: Styles.tsWhiteBold24,
          ),
          Text(
            title,
            style: Styles.tsGreyLight12,
          )
        ],
      );
}
