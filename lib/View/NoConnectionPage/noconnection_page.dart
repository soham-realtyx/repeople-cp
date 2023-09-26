
import 'package:flutter/material.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';


class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.appThemeColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  noConnectionPng,
                  color: AppColors.whiteColor,
                  width: 100,
                  height: 100,
                ),
                SizedBox(
                  height: 10.w,
                ),
                Text(
                  "No Internet Connection",
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16.sp,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          )),
    );
  }
}