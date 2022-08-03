import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/data/models/dto/User.dart';
import 'package:todo/app/data/values/dimens.dart';
import 'package:todo/app/data/values/images.dart';
import 'package:todo/app/routes/app_pages.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/app/theme/styles.dart';
import 'package:todo/utils/app_utils.dart';
import 'package:todo/utils/storage/storage_utils.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserData user = Storage.getUser();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: Dimens.screenHeight / 5,
            child: Stack(
              children: [
                Image.asset(
                  AppImages.bgCover,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: AppColors.black.withOpacity(0.4),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppUtils.imageHandler(user.profileUrl ?? "",
                                height: 70, width: 70, borderRadius: 100),
                            SizedBox(width: 20.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${user.name ?? ""}",
                                    style: Styles.tsWhiteRegular18
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    "${user.email}",
                                    style: Styles.tsBlackRegular12
                                        .copyWith(color: AppColors.white),
                                  ),
                                  if (user.phone != null)
                                    if (user.phone!.isNotEmpty)
                                      Text(
                                        "${user.phone}",
                                        style: Styles.tsBlackRegular12
                                            .copyWith(color: AppColors.white),
                                      ).paddingOnly(top: 8.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 24.0, vertical: 24.0),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: logout,
          )
        ],
      ),
    );
  }

  logout() async {
    await Storage.clearStorage();
    Get.offAllNamed(Routes.AUTH_SIGNUP);
  }
}
