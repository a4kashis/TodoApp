import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/data/models/dto/TaskData.dart';
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

class TaskView extends StatefulWidget {
  final TaskData? task;

  const TaskView({super.key, this.task});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late final TaskController taskController;

  @override
  void initState() {
    taskController = Provider.of<TaskController>(context, listen: false);
    taskController.onInit(context, widget.task);
    super.initState();
  }

  @override
  void dispose() {
    taskController.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(builder: (context, controller, child) {
      return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Column(
          children: [
            CustomAppBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: AbsorbPointer(
                  absorbing: (controller.createdBy.userId !=
                          Storage.getUser().userId &&
                      controller.taskId.isNotEmpty),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.createdBy.userId !=
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
                            onTap: () => AppUtils.getBottomSheet(context,
                                children: thingType.entries
                                    .map(
                                      (e) => ListTile(
                                        onTap: () => controller.updateType(
                                            context, e.key),
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
                              child: Image.asset(
                                thingType[controller.thingType] ?? "",
                                color: AppColors.secondaryColor,
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Dimens.gapX3),
                        DropdownButton<String>(
                          dropdownColor: AppColors.primaryColor,
                          value: controller.type,
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Icon(Icons.keyboard_arrow_down_sharp,
                                color: AppColors.grey),
                          ),
                          iconSize: 24,
                          elevation: 2,
                          itemHeight: null,
                          isExpanded: true,
                          onChanged: (String? val) =>
                              controller.type = val ?? "",
                          items: controller.typeList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                  child: Text(
                                    value,
                                  ),
                                ));
                          }).toList(),
                          borderRadius: BorderRadius.circular(10.0),
                          style: Styles.tsWhiteLight14,
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
                          onTap: () => controller.pickDate(context),
                          label: 'Date',
                          validator: mandatoryValidator,
                        ),
                        CustomTextField(
                          wrapper: controller.shareWith,
                          onTap: () => AppUtils.getBottomSheet(context,
                              children: [UsersList()]),
                          label: 'Share with',
                          maxLine: null,
                        ),
                        // SizedBox(height: Dimens.gapX1),
                        SwitchListTile(
                          // dense: true,
                          activeColor: AppColors.secondaryColor,
                          value: controller.isCompleted,
                          onChanged: controller.updateCompletionStatus,
                          title:
                              Text("Completed", style: Styles.tsWhiteLight14),
                          contentPadding: EdgeInsets.zero,
                        ),
                        SizedBox(height: Dimens.gapX4),
                        controller.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : PrimaryFilledButton(
                                text:
                                    "${controller.type.isEmpty ? "ADD" : "UPDATE"} YOUR THING",
                                onTap: () => controller.saveTask(context)),
                        SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
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
