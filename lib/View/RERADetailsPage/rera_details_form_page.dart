import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/RegistrationController/registration_controller.dart';
import 'package:repeoplecp/View/PanDetailsPage/pan_details_form_page.dart';
import 'package:repeoplecp/Widget/custom_boxDecoration.dart';
import 'package:repeoplecp/Widget/CustomButton/custom_button.dart';
import 'package:repeoplecp/Widget/custom_textField.dart';
import 'package:repeoplecp/Widget/horizontal_divider_widget.dart';

class RERADetailsPage extends StatefulWidget {
  const RERADetailsPage({super.key});

  @override
  State<RERADetailsPage> createState() => _RERADetailsPageState();
}

class _RERADetailsPageState extends State<RERADetailsPage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  RegistrationController cntRegistration = Get.put(RegistrationController());
  @override
  void initState() {
    super.initState();
    cntRegistration.entityTypeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: cntRegistration.globalReRaPageKey,
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
              "RERA Details",
              cntRegistration.globalReRaPageKey,
              backOnTap: (){
                if(cntRegistration.isOpenReRaDetails.value == false){
                  cntRegistration.isOpenReRaDetails.value = true;
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
      padding: const EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 0),
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
      child: editReRaImageData(),
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
                                  ),
                          )
                              : Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image(
                                      image: NetworkImage(profilePic.value),
                                      fit: BoxFit.cover)),
                        ),
                        Obx(() => cntRegistration.reRaImage.value == ""
                            ? const SizedBox()
                            : GestureDetector(
                                onTap: () {
                                  cntRegistration.cameraSelects(DocumentType.reRaPhoto);
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
                      cntRegistration.cameraSelects(DocumentType.reRaPhoto);
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
       Obx(() =>  cntRegistration.isRERAValidationShow.value == false
           ?  Text("Please Enter RERA Certificate",style: mediumTextStyle(fontSize: 12,fontWeight: FontWeight.w400,txtColor: AppColors.red),)
           :  const SizedBox()),
       Obx(() =>SizedBox(
          height: cntRegistration.isOpenReRaDetails.value == true? 16.w:10,
        )),
        Obx(() => cntRegistration.isOpenReRaDetails.value == true? verifyButton() : const SizedBox()),

        Obx(() =>  cntRegistration.isOpenReRaDetails.value != true ? reRaDetailsData() :const SizedBox())
      ],
    );
  }

  Widget reRaDetailsData() {
    return Obx(() => AnimatedContainer(
      clipBehavior: Clip.hardEdge,
      curve: Curves.fastOutSlowIn,
      height: cntRegistration.isOpenReRaDetails.value == true ? 320.w : 530.w,
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
          child: rERADetailsWidgetData()),
    ));
  }


  Widget rERADetailsWidgetData(){
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Form(
        key: cntRegistration.reRaFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonDropDownTextField(
              labelText: "Entity Type*",
              onTap: () {
                cntRegistration.selectEntityType();
              },
            validator: (value) =>
                validation(value, "Please select entity type"),
              controller: cntRegistration.txtEntityType.value,
              hintText: "Select Entity Type",
            ),
            SizedBox(height: 24.w,),
            reRaDetailsWidget(
                titleText: "Company Name",subTitleText: "Brikkin Martech Private Limited"
            ),
            SizedBox(height: 24.w,),
            reRaDetailsWidget(
                titleText: "RERA Number",subTitleText: "A51800035827"
            ),
            SizedBox(height: 24.w,),
            reRaDetailsWidget(
                titleText: "RERA State",subTitleText: "Maharashtra"
            ),
            SizedBox(height: 24.w,),
            reRaDetailsWidget(
                titleText: "Registered Address",subTitleText: "Tehsil: Andheri, Mumbai Suburban, 400093"
            ),
            SizedBox(height: 24.w,),
            reRaDetailsWidget(
                titleText: "Start Date",subTitleText: "30/05/2022"
            ),
            SizedBox(height: 24.w,),
            reRaDetailsWidget(
                titleText: "End Date",subTitleText: "30/05/2027"
            ),
            SizedBox(height: 24.w),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget reRaDetailsWidget({String? titleText,String? subTitleText}){
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
    return onTapButton(
        onTap: () {
          if(cntRegistration.isRERAValidationShow.value==true) {
            setState(() {
              cntRegistration.isOpenReRaDetails.value =
              !cntRegistration.isOpenReRaDetails.value;
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
    return onTapButton(
        onTap: () {
          if(cntRegistration.reRaFormKey.currentState!.validate()) {
            Get.to(() => const PanFormDetailsPage());
          }
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
