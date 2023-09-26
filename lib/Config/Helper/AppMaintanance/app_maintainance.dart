import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';

class AppMaintenancePage extends StatefulWidget {
  const AppMaintenancePage({Key? key}) : super(key: key);

  @override
  State<AppMaintenancePage> createState() => _AppMaintenancePageState();
}

class _AppMaintenancePageState extends State<AppMaintenancePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          exit(0);
        },
        child: Scaffold(
          backgroundColor: AppColors.pageBackgroundColor,
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 70.0,right: 20,left: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
                  Center(child: SvgPicture.asset(rePeopleAppLogo,width: 200,height: 30,)),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Under Maintenance',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      color: AppColors.appThemeColor,
                      fontSize: 24.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Lottie.asset("assets/GIF/maintenance.json",fit:BoxFit.contain ,repeat: true,height: 200, width: 250),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Text(
                        'We’ve got something Special in app for you.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          color: AppColors.black,
                          fontSize: 18.sp,
                        ),
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Text(
                        "we will get back to you very soon with more updates.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.sp,
                        ),
                      )),
                  const SizedBox(
                    height: 30.0,
                  ),
                  InkWell(
                    onTap: () {
                      // Get.back();
                      exit(0);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.appThemeColor,
                          border:
                              Border.all(color: AppColors.lightGreyColor, width: 1.0),
                          borderRadius: const BorderRadius.all(Radius.circular(13))),
                      height: 50.0,
                      width: 190.0,
                      child: Center(
                        child: Text(
                          'Close Application',
                          style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontFamily: fontFamily,
                              fontSize: 12.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
