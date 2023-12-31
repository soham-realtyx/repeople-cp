import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/LoginController/login_controller.dart';
import 'package:repeoplecp/View/HomePage/home_page.dart';
import 'package:repeoplecp/View/OTPPage/otp_page.dart';
import 'package:repeoplecp/Widget/custom_boxDecoration.dart';
import 'package:repeoplecp/Widget/CustomButton/custom_button.dart';
import 'package:repeoplecp/Widget/custom_textField.dart';

class SendOTPPage extends StatefulWidget {
  final String? isRegistered;
  const SendOTPPage({super.key,this.isRegistered});

  @override
  State<SendOTPPage> createState() => _SendOTPPageState();
}

class _SendOTPPageState extends State<SendOTPPage> {
  LoginController cntLogin = Get.put(LoginController());
  GlobalKey<ScaffoldState> globalLoginPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    cntLogin.isRegister.value=widget.isRegistered??"";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      resizeToAvoidBottomInset: true,
      key: globalLoginPageKey,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: loginFormData(),
            )
          ],
        ),
      ),
    );
  }

  Widget loginFormData() {
    return Form(
      key: cntLogin.formKeys,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Stack(
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
                    padding:  EdgeInsets.only(top: 70.w,left: 20.h,right: 20.h),
                    child: Container(
                      margin:  EdgeInsets.only(top:170.w),
                      // margin: EdgeInsets.only(top: pageHeight - Get.height * 0.60),
                      child: Column(
                        children: [
                          // LoginForm_5(),
                          phoneNumberTextField(cntLogin.txtContactNew,cntLogin.mobileFocusNode),
                          SizedBox(height: 24.w),
                          onLoginTapButton(
                            onTap: () {
                              if (cntLogin.formKeys.currentState!
                                  .validate() /* && isocode1.value!="" &&isocode1.value!="INDIA"*/) {
                                if (cntLogin.txtContactNew.value?.text.length == 10) {
                                  cntLogin.isOtpFieldShown.value = true;
                                  Get.to(()=> VerifyOTPPage(mobileNo: cntLogin.txtContactNew.value?.text.toString(),isUser: cntLogin.isUser.value,));
                                }
                              }
                            },
                            height: 40.w,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color:AppColors.appThemeColor,width: 1 )
                            ),
                            text: "GET SMS OTP",
                            style: TextStyle(
                                color: AppColors.appThemeColor,
                                fontSize: 12.sp,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 68.h,left: 20.w,right: 20.w,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: onLoginTapButton(
                          onTap: (){
                            Get.to(()=>const HomePage());
                            // GetWhatsappText();
                            // WALunchUrl("whatsapp://send?phone=$whatsAppLoginNo&text=${Uri.encodeFull(whatsAppLoginMessage)}");
                          },
                          height: 40.w,
                          width: Get.width,
                          decoration: CustomDecorations()
                              .backgroundLocal(AppColors.appThemeColor, 6, 0, AppColors.appThemeColor),
                          text: "Login with Whatsapp".toUpperCase(),
                          icon: Image.asset(whatsAppIcons,height: 18.w,width: 18.h),
                          style:
                          TextStyle(color: AppColors.whiteColor, fontSize: 12, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
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
                    SizedBox(height: 100.w),
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
                      "Tell us your mobile number",
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
