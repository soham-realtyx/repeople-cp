import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/SizeConfig.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/CommenHeaderController.dart';
import 'package:repeoplecp/Controller/RegistrationController/RegistrationController.dart';
import 'package:repeoplecp/Widget/CustomBoxDecoration.dart';
import 'package:repeoplecp/Widget/CustomButton/CustomButton.dart';
import 'package:repeoplecp/Widget/HorizontalDividerWidget.dart';

class RERADetailsPage extends StatefulWidget {
  const RERADetailsPage({super.key});

  @override
  State<RERADetailsPage> createState() => _RERADetailsPageState();
}

class _RERADetailsPageState extends State<RERADetailsPage> {
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
                  reRaDetailForm(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            cntCommonHeader.commonAppBar(
              "RERA Details",
              cntRegistration.globalSuccessPageKey,
            )
          ],
        ),
      ),
    );
  }

  Widget reRaDetailForm() {
    return Container(
      padding: const EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 24),
      margin: const EdgeInsets.only(right: 20, left: 20),
      width: Get.width,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                offset: const Offset(0, 3),
                blurRadius: 6,
                spreadRadius: 0)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [editReRaImageData()],
      ),
    );
  }

  Widget editReRaImageData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "RERA Certificate*",
          style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.labelGreyColor,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() => cntRegistration.reRaImage.value != ""
                ? Obx(() => Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: Get.width-52.w,
                          height: 174.w,
                          // padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 138),
                          decoration: BoxDecoration(
                            color: AppColors.appThemeColor.withOpacity(0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: cntRegistration.reRaImage.value != ""
                              ? Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.file(
                                    File(cntRegistration.reRaImage.value),
                                    fit: BoxFit.cover,
                                  ))
                              : Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image(
                                      image: NetworkImage(profile_pic.value),
                                      fit: BoxFit.cover)),
                        ),
                        Obx(() => cntRegistration.reRaImage.value == ""
                            ? const SizedBox()
                            : GestureDetector(
                                onTap: () {
                                  cntRegistration.profileImagePicker();
                                },
                                child: Container(
                                  width: Get.width-52.w,
                                    height: 174.w,
                                    // padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 138),
                                    decoration: BoxDecoration(
                                      color: AppColors.appThemeColor.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                        child: Text(
                                  "CHANGE",
                                  style: mediumTextStyle(
                                      txtColor: AppColors.whiteColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                                    ),
                                ),
                        ),
                        )
                      ],
                    ))
                : GestureDetector(
                    onTap: () {
                      cntRegistration.profileImagePicker();
                    },
                    child: Container(
                      width: Get.width-52.w,
                      height: 174.w,
                      // padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 138),
                      decoration: BoxDecoration(
                        color: AppColors.appThemeColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          "+ADD",
                          style: TextStyle(
                              color: AppColors.appThemeColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: fontFamily),
                        ),
                      ),
                    ),
                  )),
          ],
        ),
        SizedBox(
          height: 8.w,
        ),
        HorizontalDivider(color: AppColors.labelGreyColor, height: 1),
        SizedBox(
          height: 20.w,
        ),
        verifyButton()
      ],
    );
  }
  Widget verifyButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: OnTapButton(
            onTap: () {Get.to(()=>const RERADetailsPage());},
            height: 40.w,
            decoration: CustomDecorations().backgroundLocal(
                AppColors.appThemeColor, 6, 0, AppColors.whiteColor),
            text: "verify".toUpperCase(),
            style: TextStyle(
                color: AppColors.whiteColor,
                fontFamily: fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp)));
  }
}
