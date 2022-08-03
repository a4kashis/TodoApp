import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/app/data/values/images.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/app/theme/styles.dart';
import 'package:todo/widgets/buttons/primary_filled_button.dart';

class AppUtils {
  AppUtils._privateConstructor();

  static showSnackBar(String text) {
    Get.rawSnackbar(
        snackPosition: SnackPosition.TOP,
        borderRadius: 10.0,
        borderColor: AppColors.primaryColor,
        messageText: Text(text,
            style: Styles.tsBlackMedium14
                .copyWith(color: AppColors.white, letterSpacing: 0.2)),
        backgroundColor: AppColors.secondaryColor,
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 14.0));
  }

  static getBottomSheet({required List<Widget> children}) => Get.bottomSheet(
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          children: children,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        isScrollControlled: true,
        ignoreSafeArea: false,
        backgroundColor: AppColors.primaryColor,
      );

  static showCustomDialog(
          {required List<Widget> children, isCloseEnabled = true}) =>
      Get.dialog(
        barrierDismissible: isCloseEnabled,
        Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isCloseEnabled)
                  Row(
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: () => Get.back(),
                        child: Icon(Icons.close, size: 18),
                      )
                    ],
                  ),
                for (Widget child in children) child,
              ],
            ),
          ),
        ),
      );

  static String getFormattedDateTime(String val) {
    String formattedDate = "";
    try {
      DateTime dt = DateFormat('dd/MM/yyyy').parse(val);
      formattedDate = "${DateFormat.yMMMd().format(dt)}";
      // ${DateFormat.jm().format(dt)}
    } catch (e) {
      debugPrint(e.toString());
      formattedDate = val;
    }

    return formattedDate;
  }

  static String getInitials(String value) {
    try {
      return value.isNotEmpty
          ? (value.trim().split(' ')).map((l) => l[0]).take(2).join()
          : '';
    } catch (e) {
      debugPrint(e.toString());
      return value.substring(0, 1);
    }
  }

  static imageHandler(String url,
      {double height = 60, double width = 60, double borderRadius = 10}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        url,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (ctx, obj, _) => Image.asset(
          AppImages.noImageFound,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
