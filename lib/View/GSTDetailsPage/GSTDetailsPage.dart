import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/SizeConfig.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/CommenHeaderController.dart';
import 'package:repeoplecp/Controller/RegistrationController/RegistrationController.dart';
import 'package:repeoplecp/View/BankDetailsPage/BankDetailsPage.dart';
import 'package:repeoplecp/Widget/CustomBoxDecoration.dart';
import 'package:repeoplecp/Widget/CustomButton/CustomButton.dart';
import 'package:repeoplecp/Widget/HorizontalDividerWidget.dart';

class GSTDetailsPage extends StatefulWidget {
  const GSTDetailsPage({super.key});

  @override
  State<GSTDetailsPage> createState() => _GSTDetailsPageState();
}

class _GSTDetailsPageState extends State<GSTDetailsPage> {
  @override
  void initState() {
    super.initState();
  }
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  RegistrationController cntRegistration = Get.put(RegistrationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: cntRegistration.globalGSTDetailsPageKey,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  reRaDetailForm(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Obx(() =>  cntCommonHeader.commonAppBar(
                "GST Details",
                cntRegistration.globalGSTDetailsPageKey,
                backOnTap: (){
                  if(cntRegistration.isOpenGSTDetails.value == false){
                    cntRegistration.isOpenGSTDetails.value = true;
                  }else {
                    Get.back();
                  }
                },
                isShowBackArrow: true
            ))
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
        children: [
          editGSTImageData(),
          Obx(() =>SizedBox(
            height: cntRegistration.isOpenGSTDetails.value == true? 16.w:10,
          )),
          Obx(() => cntRegistration.isOpenGSTDetails.value == true? verifyButton() : const SizedBox()),

          Obx(() =>  cntRegistration.isOpenGSTDetails.value != true ? gstDetailsData() :const SizedBox())
        ],
      ),
    );
  }

  Widget editGSTImageData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "GST Certificate*",
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
            Obx(() => cntRegistration.gstImage.value != ""
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
                  child: cntRegistration.gstImage.value != ""
                      ? Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.file(
                      File(cntRegistration.gstImage.value),
                      fit: BoxFit.cover,
                    ),
                  )
                      : Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image(
                          image: NetworkImage(profile_pic.value),
                          fit: BoxFit.cover)),
                ),
                Obx(() => cntRegistration.gstImage.value == ""
                    ? const SizedBox()
                    : GestureDetector(
                  onTap: () {
                    cntRegistration.CameraSelect(DocumentType.gsTPhoto);
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
                cntRegistration.CameraSelect(DocumentType.gsTPhoto);
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
          height: 4.w,
        ),
        Obx(() =>  cntRegistration.isGSTValidationShow.value == false
            ?  Text("Please Enter GST Details",style: mediumTextStyle(fontSize: 12,fontWeight: FontWeight.w400,txtColor: AppColors.red),)
            :  const SizedBox()),

      ],
    );
  }

  Widget gstDetailsData() {
    return Obx(() => AnimatedContainer(
      clipBehavior: Clip.hardEdge,
      curve: Curves.fastOutSlowIn,
      height: cntRegistration.isOpenGSTDetails.value == true ? 320.w : 320,
      width: Get.width,
      //margin: const EdgeInsets.only(left: 0, right:0, bottom: 35, top: 0),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppColors.whiteColor,
          boxShadow: [fullcontainerboxShadow]
      ),
      duration: const Duration(milliseconds: 500),
      child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: gstDetailsWidgetData()),
    ));
  }


  Widget gstDetailsWidgetData(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.w,),
        gstDetailsWidget(
            titleText: "GSTIN",subTitleText: "27AALCR0049L1Z2"
        ),
        SizedBox(height: 24.w,),
        gstDetailsWidget(
            titleText: "Company Name",subTitleText: "Brikkin Martech Private Limited"
        ),
        SizedBox(height: 24.w),
        gstDetailsWidget(
            titleText: "RERA State",subTitleText: "Maharashtra"
        ),
        SizedBox(height: 24.w),
        gstDetailsWidget(
            titleText: "GSTIN Status",subTitleText: "Active"
        ),
        SizedBox(height: 24.w),
        submitButton(),
      ],
    );
  }

  Widget gstDetailsWidget({String? titleText,String? subTitleText}){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titleText??"",style: mediumTextStyle(txtColor:  AppColors.maiGreyColor,fontWeight: FontWeight.w400,fontSize: 12),),
          const SizedBox(height: 2),
          Text(subTitleText??"",style: boldTextStyle(fontSize: 14,fontWeight: FontWeight.w700,txtColor: AppColors.appThemeColor),),
        ]
    );
  }

  Widget verifyButton() {
    return OnTapButton(
        onTap: () {
          if(cntRegistration.isGSTValidationShow.value==true) {
            setState(() {
              cntRegistration.isOpenGSTDetails.value =
              !cntRegistration.isOpenGSTDetails.value;
            });
          }
        },
        height: 40.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.appThemeColor, 6, 0, AppColors.whiteColor),
        text: "verify".toUpperCase(),
        style: TextStyle(
            color: AppColors.whiteColor,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp));
  }

  Widget submitButton() {
    return OnTapButton(
        onTap: () {
          Get.to(()=>const BankDetailsPage());
        },
        height: 40.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.appThemeColor, 6, 0, AppColors.whiteColor),
        text: "submit".toUpperCase(),
        style: TextStyle(
            color: AppColors.whiteColor,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp));
  }
}
