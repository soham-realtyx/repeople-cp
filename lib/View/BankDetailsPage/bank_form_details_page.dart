import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/RegistrationController/registration_controller.dart';
import 'package:repeoplecp/View/ContactDetailsPage/contact_details_page.dart';
import 'package:repeoplecp/Widget/custom_boxDecoration.dart';
import 'package:repeoplecp/Widget/CustomButton/custom_button.dart';
import 'package:repeoplecp/Widget/custom_textField.dart';
import 'package:repeoplecp/Widget/horizontal_divider_widget.dart';

class BankFormDetailsPage extends StatefulWidget {
  const BankFormDetailsPage({super.key});

  @override
  State<BankFormDetailsPage> createState() => _BankFormDetailsPageState();
}

class _BankFormDetailsPageState extends State<BankFormDetailsPage> {
  @override
  void initState() {
    super.initState();
    cntRegistration.accountTypeData().whenComplete(() =>cntRegistration.objAccountType.value=cntRegistration.arrAccountTypeList[0]);
  }
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  RegistrationController cntRegistration = Get.put(RegistrationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: cntRegistration.globalBankDetailsPageKey,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  bankDetailForm(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Obx(() =>  cntCommonHeader.commonAppBar(
                "Bank Details",
                cntRegistration.globalBankDetailsPageKey,
                backOnTap: (){
                  if(cntRegistration.isOpenBankDetails.value == false){
                    cntRegistration.isOpenBankDetails.value = true;
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

  Widget bankDetailForm() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          editBankImageData(),
          Obx(() =>SizedBox(
            height: cntRegistration.isOpenBankDetails.value == true? 16.w:10,
          )),
          Obx(() => cntRegistration.isOpenBankDetails.value == true? verifyButton() : const SizedBox()),

          Obx(() =>  cntRegistration.isOpenBankDetails.value != true ? bankDetailsData() :const SizedBox())
        ],
      ),
    );
  }

  Widget editBankImageData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cancelled Cheque*",
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
            Obx(() => cntRegistration.banPassbookImage.value != ""
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
                  child: cntRegistration.banPassbookImage.value != ""
                      ? Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.file(
                      File(cntRegistration.banPassbookImage.value),
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
                Obx(() => cntRegistration.banPassbookImage.value == ""
                    ? const SizedBox()
                    : GestureDetector(
                  onTap: () {
                    cntRegistration.CameraSelect(DocumentType.bankPassBookPhoto);
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
                cntRegistration.CameraSelect(DocumentType.bankPassBookPhoto);
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
        Obx(() =>  cntRegistration.isBankPassBookValidationShow.value == false
            ?  Text("Please enter cancelled cheque",style: mediumTextStyle(fontSize: 12,fontWeight: FontWeight.w400,txtColor: AppColors.red),)
            :  const SizedBox()),

      ],
    );
  }

  Widget bankDetailsData() {
    return Obx(() => AnimatedContainer(
      clipBehavior: Clip.hardEdge,
      curve: Curves.fastOutSlowIn,
      height: cntRegistration.isOpenBankDetails.value == true ? 320.w : 500,
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
          child: panDetailsWidgetData()),
    ));
  }


  Widget panDetailsWidgetData(){
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Form(
        key: cntRegistration.bankFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.w,),
            bankDetailsWidget(
                titleText: "Company Name",subTitleText: "Brikkin Martech Private Limited"
            ),
            SizedBox(height: 24.w),
            bankDetailsWidget(
                titleText: "Bank",subTitleText: "Kotak Mahindra Bank"
            ),
            SizedBox(height: 24.w),
            bankDetailsWidget(
                titleText: "Account Number",subTitleText: "0645293614"
            ),
            SizedBox(height: 14.w),
            commonDropDownTextField(
              labelText: "Type*",
              onTap: () {
                cntRegistration.selectAccountType();
              },
              validator: (value) =>
                  validation(value, "Please select account type"),
              controller: cntRegistration.txtAccountType.value,
              hintText: "Select Account Type",
            ),
            SizedBox(height: 24.w),
            bankDetailsWidget(
                titleText: "Branch",subTitleText: "MIDC Andheri East"
            ),
            SizedBox(height: 24.w),
            bankDetailsWidget(
                titleText: "IFSC",subTitleText: "KKBK0001367"
            ),
            SizedBox(height: 24.w),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget bankDetailsWidget({String? titleText,String? subTitleText}){
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
          if(cntRegistration.isBankPassBookValidationShow.value==true) {
            setState(() {
              cntRegistration.isOpenBankDetails.value =
              !cntRegistration.isOpenBankDetails.value;
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
          if(cntRegistration.bankFormKey.currentState!=null&&cntRegistration.bankFormKey.currentState!.validate()){
            Get.to(()=>const ContactDetailsPage());
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
