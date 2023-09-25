import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/View/NotificationPage/notification_page.dart';

Widget trailingHistoryIcon(Color color, {String notificationIcon = ""}){
  return Stack(
    children: [
      IconButton(
        icon: Icon(
          Icons.more_time,
          size: 30,
          color: color,
        ),
        onPressed: () {
          // Get.to(FacilitiesHistoryPage());
          //Get.to(Document_Screen());

        },
      ),
      // Positioned(
      //     left: 25,
      //     top: 12,
      //     child: Icon(
      //       Icons.circle,
      //       size: 10,
      //       color: Colors.red,
      //     ))
    ],
  );

}

Widget trailingIconDrawer(String drawerIcon, Color color , VoidCallback onTap) {
  return Stack(
    children: [
      InkWell(
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 5),
            child:
            SvgPicture.asset(
              sideMenuSvgIcons,
              height: 24.w,
              width: 24.w,
              color: color,
            )
        ),
      )
    ],
  );
}

Widget trailingIconNotification(Color color,{String notificationIcon = "",VoidCallback? onTap,}) {
  return Stack(
    children: [
      InkWell(
        splashColor: AppColors.transParent,
        focusColor: AppColors.transParent,
        highlightColor: AppColors.transParent,
        hoverColor:  AppColors.transParent,
        onTap: (){
          Get.to(
              const NotificationPage(),
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 400)
          );
        },
        child:
        SvgPicture.asset(
          notificationIcon,
          color: color,
          height: 24.w,
          width: 24.w,
        ),
      ),

      if(isBadgeShow.isTrue)   Positioned(
          left: 13,
          top: 4,
          child: ClipOval(
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.whiteColor,width: 1),
                color: hex("E20000"),
              ),
            ),
          )
      )
    ],
  );
}
Widget leadingIconOfAppbar(/*MaterialColor color*/) {
  return Row(
    children: [
      Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child:
          SvgPicture.asset(
            rePeopleAppLogo,
            width: 126.w,
            color: hex("006CB5"),
            height: 20.w,
          )
      ),
    ],
  );
}

Widget trailingIconSearch(String drawerIcon, Color color , VoidCallback onTap) {
  return Stack(
    children: [
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 5),
          child: Image.asset(
            drawerIcon,
            height: 25,
            width: 25,
            color: color,
          ),
        ),
      )
    ],
  );
}
