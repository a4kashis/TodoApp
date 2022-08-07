import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:todo/app/data/values/dimens.dart';
import 'package:todo/app/data/values/images.dart';
import 'package:todo/app/modules/task/widgets/appbar.dart';
import 'package:todo/app/modules/task/widgets/users_list.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/app/theme/styles.dart';
import 'package:todo/utils/app_utils.dart';
import 'package:todo/utils/storage/storage_utils.dart';
import 'package:todo/utils/validators.dart';
import 'package:todo/widgets/buttons/primary_filled_button.dart';
import 'package:todo/widgets/text_field/textbox.dart';

import '../controllers/task_controller.dart';

class TaskView extends GetView<TaskController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          CustomAppBar(),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Obx(
                () => AbsorbPointer(
                  absorbing: (controller.createdBy.value.userId !=
                          Storage.getUser().userId &&
                      controller.taskId.isNotEmpty),
                  child: Form(
                    key: controller.formKey,
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.createdBy.value.userId !=
                                  Storage.getUser().userId &&
                              controller.taskId.isNotEmpty)
                            Text(
                              "You have only View access*",
                              style: Styles.tsGreyLight12
                                  .copyWith(fontStyle: FontStyle.italic),
                            ),

                          SizedBox(height: Dimens.gapX2),
                          Center(
                            child: InkWell(
                              onTap: () => AppUtils.getBottomSheet(
                                  children: thingType.entries
                                      .map(
                                        (e) => ListTile(
                                          onTap: () {
                                            Get.back();
                                            controller.thingType.value = e.key;
                                          },
                                          leading: Image.asset(e.value,
                                              height: 30,
                                              color: AppColors.secondaryColor),
                                          title: Text(
                                            e.key,
                                            style: Styles.tsWhiteLight14,
                                          ),
                                        ),
                                      )
                                      .toList()),
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color(0xff888888), width: 1.0),
                                ),
                                padding: const EdgeInsets.all(20.0),
                                child: Obx(
                                  () => Image.asset(
                                    thingType[controller.thingType.value] ?? "",
                                    color: AppColors.secondaryColor,
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Dimens.gapX3),
                          Obx(
                            () => DropdownButton<String>(
                              dropdownColor: AppColors.primaryColor,
                              value: controller.type.value,
                              icon: Icon(Icons.keyboard_arrow_down_sharp,
                                      color: AppColors.grey)
                                  .paddingOnly(right: 4.0),
                              iconSize: 24,
                              elevation: 2,
                              itemHeight: null,
                              isExpanded: true,
                              onChanged: (String? val) =>
                                  controller.type.value = val ?? "",
                              items: controller.typeList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Container(
                                      child: Text(
                                        value,
                                        // style: Styles.tsBlackRegular12,
                                      ),
                                    ));
                              }).toList(),
                              borderRadius: BorderRadius.circular(10.0),
                              style: Styles.tsWhiteLight14,
                            ),
                          ),
                          CustomTextField(
                            wrapper: controller.title,
                            label: 'Title',
                            validator: mandatoryValidator,
                          ),
                          CustomTextField(
                            wrapper: controller.description,
                            label: 'Description',
                            maxLine: null,
                            validator: mandatoryValidator,
                          ),
                          CustomTextField(
                            wrapper: controller.place,
                            label: 'Place',
                            validator: mandatoryValidator,
                          ),
                          CustomTextField(
                            wrapper: controller.time,
                            onTap: () => controller.pickDate(),
                            label: 'Date',
                            validator: mandatoryValidator,
                          ),
                          CustomTextField(
                            wrapper: controller.shareWith,
                            onTap: () => AppUtils.getBottomSheet(
                                children: [UsersList()]),
                            label: 'Share with',
                          ),
                          // SizedBox(height: Dimens.gapX1),
                          Obx(
                            () => SwitchListTile(
                              // dense: true,
                              activeColor: AppColors.secondaryColor,
                              value: controller.isCompleted.value,
                              onChanged: (value) {
                                controller.isCompleted.value = value;
                              },

                              title: Text("Completed",
                                  style: Styles.tsWhiteLight14),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          SizedBox(height: Dimens.gapX4),
                          Obx(
                            () => controller.isLoading.value
                                ? Center(child: CircularProgressIndicator())
                                : PrimaryFilledButton(
                                    text:
                                        "${controller.type.isEmpty ? "ADD" : "UPDATE"} YOUR THING",
                                    onTap: controller.saveTask),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const Map<String, String> thingType = const {
  "Shopping": AppImages.iTShirt,
  "Wakeup": AppImages.icWakeUp,
  "Reading": AppImages.icBook,
  "Sports": AppImages.icBike,
  "Groceries": AppImages.icMilk,
  "Gym": AppImages.icGym,
};
