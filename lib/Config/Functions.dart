import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';

Widget TrailingHistoryIcon(Color color, {String notificationIcon = ""}){
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
              height: 25,
              width: 25,
              color: color,
            )
          // Image.asset(
          //   // drawerIcon,
          //   drawerIcon,
          //   // IMG_SIDEMENU_PNG,
          //   height: 25,
          //   width: 25,
          //   color: color,
          // ),
        ),
      )
    ],
  );
}

Widget TrallingIconNotification(Color color,{String notificationIcon = "",VoidCallback? onTap,}) {
  return Stack(
    children: [
      InkWell(
        splashColor: AppColors.transParent,
        focusColor: AppColors.transParent,
        highlightColor: AppColors.transParent,
        hoverColor:  AppColors.transParent,
        onTap: (){
          // Get.to(
          //     NotificationCustomDrawer(
          //       animatedOffset: Offset(1.0, 0),
          //     )
          // );
        },
        child:
        //Image.asset(IMG_NOTIFICATON_PNG,height: 30,color: color),
        SvgPicture.asset(
          notificationIcon,
          color: color,
          height: 24,
          width: 24,
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
  return Container(
    child: Row(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child:
            SvgPicture.asset(
              rePeopleAppLogo,
              width: 126,
              color: hex("006CB5"),
              height: 20,
            )
          // Image.asset(
          //   IMG_APPLOGO,
          //   width: 150,
          //   height: 60,
          //   color: color,
          // ),
        ),
      ],
    ),
  );
}

Widget TrallingIconSearch(String drawerIcon, Color color , VoidCallback onTap) {
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
