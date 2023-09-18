
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:repeoplecp/Config/Utils/SizeConfig.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/string.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/LoginController/LoginController.dart';
import 'package:repeoplecp/View/EditProfilePage/EditProfilePage.dart';
import 'package:repeoplecp/View/HomePage/HomePage.dart';
import 'package:repeoplecp/Widget/CustomBoxDecoration.dart';
import 'package:repeoplecp/Widget/CustomButton/CustomButton.dart';
import 'package:repeoplecp/Widget/CustomTextField.dart';


class VerifyOTPPage extends StatefulWidget {
  final String? mobileNo;
  final int? isUser;
   const VerifyOTPPage({Key? key,this.mobileNo,this.isUser}) : super(key: key);

  @override
  _VerifyOTPPageState createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> with TickerProviderStateMixin{

  LoginController cntOtp = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    cntOtp.startTimer();
    cntOtp.countDown();
    cntOtp.mobileNo.value = widget.mobileNo??"";
    cntOtp.isNewUser.value = widget.isUser??0;
  }

  @override
  void dispose() {
    cntOtp.txtOtp1?.stopListen();
    cntOtp.timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: true,
      key: cntOtp.globalOtpPageKey,
      body: SafeArea(
        child: Stack(
          children: [
            oTPFormData()
          ],
        ),
      ),
    );
  }
  Widget oTPFormData() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Stack(
        children: [
          Stack(
            children: [
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: Image.asset(
                  splashBackImage,
                  height: Get.height,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 0.w),
              Padding(
                padding:  EdgeInsets.only(top: 80.w,left: 20.h,right: 20.h),
                child: Container(
                  margin:  EdgeInsets.only(top:170.w),
                  // margin: EdgeInsets.only(top: pageHeight - Get.height * 0.60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      otpTextField(),
                      SizedBox(height: 24.w),
                      resendOtpView(),
                      SizedBox(height: 16.w),
                      // if(widget.isUser==1)
                      // Obx(() => cntOtp.isReferralText.value==false?haveReferralCodeText():referralCodeTextField()),
                    ],
                  ),
                ),
              ),
              Obx(() => Positioned(
                bottom: 68.h,
                left: cntOtp.countText.value != 0?94:20.w,
                right: cntOtp.countText.value != 0?94:20.w,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child:  Obx(() => cntOtp.countText.value == 0?OnLoginTapButton(
                        onTap: (){
                          if (cntOtp.otpFormKeys.currentState!.validate()) {
                            cntOtp.otpFocusNode.unfocus();
                            Get.to(()=>const EditProfilePage());
                            // cntOtp.VerifyOtp();
                          }
                        },
                        height: 40.w,
                        width: Get.width,
                        decoration: CustomDecorations()
                            .backgroundLocal(AppColors.appThemeColor, 6, 0, AppColors.appThemeColor),
                        text: "CONTINUE",
                        style:
                        TextStyle(color: AppColors.whiteColor, fontSize: 12, fontWeight: FontWeight.w500))
                        : GestureDetector(
                      onTap: () {
                        if (cntOtp.otpFormKeys.currentState!.validate()) {
                          if(cntOtp.isRegister.value=="1"){
                            Get.to(() => const HomePage());
                          }else {
                            Get.to(() => const EditProfilePage());
                          }
                        }
                      },
                      child: Container(
                        height: 51,
                        width: 185,
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                        decoration: BoxDecoration(
                            color: AppColors.appThemeColor,
                            borderRadius: BorderRadius.circular(6)),
                        child: Image.asset(
                          width: 185,
                          height: 36,
                          otpProgressGif,
                          color: AppColors.whiteColor,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    )
                ),
              )
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 227.w,
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(color: AppColors.appThemeColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap:(){
                      Get.back();
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Image.asset(backArrowPng,width: 6.h, height: 12.w,color: AppColors.appThemeColor,)
                    ),
                  ),
                  SizedBox(height: 80.w),
                  Text(
                    "WELCOME TO REPEOPLE",
                    style: TextStyle(
                        letterSpacing: 0.8,
                        color: hex("#FFFFFF"),

                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 8.w),
                  Text(
                    "Enter the OTP sent to",
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),Obx(() => Text(
                    "${"+91"} ${cntOtp.mobileNo.value}",
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  )),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget resendOtpView() {
    return Obx(() => cntOtp.countText.value == 0
        ? GestureDetector(
      onTap: (){
        // cntOtp.ReSendOtp();
      },
      child: Text(
        "RESEND",
        style: TextStyle(
            letterSpacing: 0.5,
            color: hex("#006CB5"),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500),
      ),
    )
        : Text(
      "${cntOtp.countText.value} s",
      style: TextStyle(
          letterSpacing: 0.5,
          color: hex("#006CB5"),
          fontSize: 12.sp,
          fontWeight: FontWeight.w500),
    ));
  }

  Widget otpTextField() {
    return Form(
      key: cntOtp.otpFormKeys,
      child: Container(
          width: Get.width,
          alignment: Alignment.centerLeft,
          child: Pinput(
            length: 6,
            autofocus: false,
            controller: cntOtp.txtOtp,
            textInputAction: TextInputAction.done,
            focusNode: cntOtp.otpFocusNode,

            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter OTP";
              } else if (cntOtp.txtOtp!.length < 6) {
                return "Please enter 6 digits";
              } else {
                return null;
              }
              // return value == txtotp!.length < 6 ? "Please enter 6 digits" : 'Please enter OTP';
            },

            keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
            defaultPinTheme: PinTheme(
              width: 37.w,
              height: 46.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: AppColors.black,
                    width: 1
                ),
              ),
              textStyle:  TextStyle(
                fontFamily: fontFamily,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            focusedPinTheme: PinTheme(
              width: 37.w,
              height: 46.w,
              textStyle:  TextStyle(
                fontFamily: fontFamily,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: AppColors.black,
                    width: 1.5
                ),
              ),),
            showCursor: true,
            mainAxisAlignment: MainAxisAlignment.spaceBetween ,
            onCompleted: (pin) {
              cntOtp.otp.value = pin;
              // cntOtp.VerifyOtp();
            },
          )),
    );
  }

  Widget haveReferralCodeText(){
    return GestureDetector(
      onTap:(){
        cntOtp.isReferralText.value=true;
      },
      child: Text(
        haveAReferralCodeText,
        style: TextStyle(
            color: AppColors.appThemeColor,
            fontSize: 14.sp,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  // Widget referralCodeTextField(){
  //   return  simpleTextFieldNewWithCustomization(
  //       hintText: "kFQsvWm",
  //       imageIcon: IMG_PROFILEUSER_SVG_DASHBOARD,
  //       controller: cntOtp.txtReferCode,
  //       inputFormat: [UpperCaseTextFormatter()],
  //       textInputType: TextInputType.name,
  //       labelText: "Refer Code",
  //       textCapitalization: TextCapitalization.sentences,
  //       validator: (value) => validation(value, "Please enter referCode"));
  // }
}