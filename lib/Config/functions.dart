import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/View/NoConnectionPage/noconnection_page.dart';
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

void showAlertDialog() {
  showHideDlg.value = true;
  showDialog(
    context: Get.context!,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: SimpleDialog(
          backgroundColor: AppColors.transParent,
          children: [
            Stack(
              children: [
                Container(
                  width: Get.width,
                  padding: EdgeInsets.only(top: 20.w, bottom: 10.w, left: 10.w, right: 10.w),
                  // height: Get.height ,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        child: Image.asset(
                          "assets/images/no-internet-connection.png",
                          height: 100.w,
                          // width: 80.w,
                        ),
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      Text(
                        'No Internet Connection',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(
                        height: 20.w,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 16,
                  child:  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: SvgPicture.asset(
                        "assets/icon/close.svg",
                        height: 14.h,
                        // color: sh_black,
                        fit: BoxFit.cover),
                  ),)
              ],
            )
          ],
        ),
      );
    },
  );
}

Future<bool> checkInternetStatus() async {
  bool status = false;
  try {
    final result = await InternetAddress.lookup('example.com')
        .timeout(const Duration(seconds: 20));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      status = true;
    }
  } on SocketException catch (_) {
    status = false;
  } catch (e) {
    status = false;
  }
  return status;
}

void showNoInternetDialog() async {
  await showDialog(
      useSafeArea: true,
      barrierDismissible: false,
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.appThemeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: const SizedBox(
              height: 150, width: 200, child: NoConnectionPage()),
        );
      });
}
