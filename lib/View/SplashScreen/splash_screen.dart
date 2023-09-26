
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Controller/SplashScreenController/splash_screen_controller.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {

  SplashScreenController cntSplash = Get.put(SplashScreenController());
  late Timer timer;
  double percent = 0;

  @override
  void dispose() {
    timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    cntSplash.check_app_update();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    cntSplash.loadData();
    WidgetsBinding.instance.addObserver(this);
    progressTimer();
  }

  progressTimer() async {
    timer = Timer.periodic(const Duration(milliseconds: 40), (_) {
      percent += 1;
      setState(() {
        if (percent >= 100) {
          timer.cancel();
          // percent=0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      body: SafeArea(child: splashWidget()),
    );
  }

  Widget splashWidget() {
    return Stack(
      children: [
        SizedBox(
            height: Get.height,
            width: Get.width,
            child: Image.asset(
              splashBackImage,
              height: Get.height,
              width: Get.width,
              fit: BoxFit.cover,
            )),
        Padding(
          padding:  EdgeInsets.only(left: 20.h,right: 20.h,bottom: 50.w,top: 180.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                rePeopleAppLogo,
                height: 34.w,
                width: 210.h,
                fit: BoxFit.cover,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 250.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "WELCOME TO REPEOPLE",
                          style: TextStyle(
                              letterSpacing: 0.8,
                              color: AppColors.lightGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 9.w),
                        Text(
                          "Browse Projects.",
                          style: TextStyle(
                              color: AppColors.lightGrey,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Schedule Site Visit.",
                          style: TextStyle(
                              color: AppColors.lightGrey,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Refer and Earn. ",
                          style: TextStyle(
                              color: AppColors.lightGrey,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    // SizedBox(height: 100.w),

                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Powered by",
                      style: TextStyle(
                          color: hex("#898989"),
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "TOTALITY",
                      style: TextStyle(
                          color: hex("#453D97"),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w900),
                    ),

                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
