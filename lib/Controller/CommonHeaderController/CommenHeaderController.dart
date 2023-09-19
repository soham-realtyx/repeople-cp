import 'dart:ui';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:repeoplecp/Config/Functions.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Widget/CustomAppBar/CustomAppBar.dart';

class CommonHeaderController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // Close Data

  ClosePageCallback() {
    var getPageStringList = Get.currentRoute.split(" ");
    String pageName = getPageStringList.last;
    // BottomNavigatorController cntBottom = Get.put(BottomNavigatorController());
    if (pageName == "ProjectListPage" || pageName == "FavoritePage") {
      // cntBottom.SelectIndex(0);
    } else {
      Get.back();
    }
  }

  Widget commonAppBar(
    String title,
    GlobalKey<ScaffoldState> scaffoldKey, {
    bool showSearch = false,
    bool isNotificationHide = false,
    Color? color,
    bool isMenuIconHide = false,
    bool isSkipButtonHide = false,
    bool isLogOutButtonHide = false,
    bool isCenterTitle = false,
    bool isShowBackArrow = false,
    isShowHistoryIcon = false,
    GestureTapCallback? skipOnTap,
    GestureTapCallback? logOutOnTap,
    GestureTapCallback? backOnTap,
  }) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: CustomDetailsAppBar(
          title: "Project List",
          height: appBarHeight,
          color: Colors.grey.shade200.withOpacity(0.2) ??
              AppColors.whiteColor.withOpacity(0.0),
          leadingWidget: [
            isShowBackArrow?
              GestureDetector(
                onTap: backOnTap,
                child: Container(
                  margin: const EdgeInsets.only(left: 14),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: hex("006CB5").withOpacity(0.2)),
                  child: Center(
                    child: SvgPicture.asset(leftBackArrowSvgIcons,
                        height: 12, width: 6, color: AppColors.appThemeColor),
                  ),
                ),
              )
              : GestureDetector(
              onTap:() =>  backOnTap??ClosePageCallback(),
              child: Container(
                margin: const EdgeInsets.only(left: 14),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: hex("006CB5").withOpacity(0.2)),
                child: Center(
                  child: SvgPicture.asset(leftBackArrowSvgIcons,
                      height: 12, width: 6, color: AppColors.appThemeColor),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: isCenterTitle
                    ? Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: AppColors.appThemeColor, fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontFamily: fontFamily,
                            // overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Text(
                        title,
                        style: TextStyle(
                            color: AppColors.appThemeColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            overflow: TextOverflow.ellipsis),
                        maxLines: 1,
                      ),
              ),
            )
          ],
          trillingWidget: [
            if (showSearch)
              TrallingIconSearch(imgSearch, AppColors.appFontColor, () {}),
            if (!isNotificationHide)
              TrallingIconNotification(AppColors.appFontColor),
            const SizedBox(
              width: 12,
            ),
            if (isShowHistoryIcon) TrailingHistoryIcon(AppColors.appFontColor),
            if (isMenuIconHide)
              TrallingIconDrawer(
                  imgMenu,
                  AppColors.appFontColor, () {
                      scaffoldKey.currentState!.openEndDrawer();
                  }),
            if (isSkipButtonHide)
              skipTextButton(text: "Skip",icons: SvgPicture.asset(skipArrowSvgIcons),skipOnTap: skipOnTap),
            if (isLogOutButtonHide)
              logOutButton(text: "Logout",icons: SvgPicture.asset(logOutSvgIcons),skipOnTap: logOutOnTap),
            if (isLogOutButtonHide)const SizedBox(
              width: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget skipTextButton({
    String? text,
    Widget? icons,
    GestureTapCallback? skipOnTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text!.toUpperCase(),
          style: mediumTextStyle(
              fontSize: 10,
              txtColor: AppColors.appThemeColor,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 8),
        icons??const SizedBox()
      ],
    );
  }

  Widget logOutButton({
    String? text,
    Widget? icons,
    GestureTapCallback? skipOnTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text!.toUpperCase(),
          style: mediumTextStyle(
              fontSize: 10,
              txtColor: AppColors.appThemeColor,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 8),
        icons??const SizedBox()
      ],
    );
  }
}
