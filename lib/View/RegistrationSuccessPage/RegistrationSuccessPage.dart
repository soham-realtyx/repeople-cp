import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/SizeConfig.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/CommenHeaderController.dart';
import 'package:repeoplecp/Controller/RegistrationController/RegistrationController.dart';

class RegistrationSuccessPage extends StatefulWidget {
  const RegistrationSuccessPage({super.key});

  @override
  State<RegistrationSuccessPage> createState() => _RegistrationSuccessPageState();
}

class _RegistrationSuccessPageState extends State<RegistrationSuccessPage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  RegistrationController cntRegistration = Get.put(RegistrationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      key: cntRegistration.globalSuccessPageKey,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: appBarHeight),
                  invitationRequestWidget(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            cntCommonHeader.commonAppBar(
                "Invitation", cntRegistration.globalSuccessPageKey,
            )
          ],
        ),
      ),
    );
  }

  Widget invitationRequestWidget(){
    return Container(
      padding: const EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 24),
      margin: const EdgeInsets.only(right: 20, left: 20,top: 20),
      width: Get.width,
      decoration: BoxDecoration(
          color: hex("FFFFFF"),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                offset: const Offset(0, 3),
                blurRadius: 6,
                spreadRadius: 0)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(successGif,height: 80.w,width: 80.w),
          const SizedBox(height: 12),
          Center(
            child: Text(
              "Invitation Request",
              style: mediumTextStyle(txtColor: AppColors.newBlack,fontWeight: FontWeight.w600,fontSize: 14),
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              "Successfully",
              style: mediumTextStyle(txtColor: AppColors.green,fontWeight: FontWeight.w600,fontSize: 14),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            textAlign: TextAlign.center,
            "Please ask your company admin to accept your invitation so that you can access the app.",
            style: mediumTextStyle(txtColor: AppColors.newBlack,fontWeight: FontWeight.w400,fontSize: 10),
          ),
        ],
      ),
    );
  }

}
