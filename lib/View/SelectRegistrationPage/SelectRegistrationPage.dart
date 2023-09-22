import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/SizeConfig.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/string.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/CommenHeaderController.dart';
import 'package:repeoplecp/Controller/RegistrationController/RegistrationController.dart';
import 'package:repeoplecp/Model/CertificatesModel/CertificatesModel.dart';
import 'package:repeoplecp/View/RERADetailsPage/RERADetailsPage.dart';
import 'package:repeoplecp/View/RegistrationSuccessPage/RegistrationSuccessPage.dart';
import 'package:repeoplecp/Widget/CustomBoxDecoration.dart';
import 'package:repeoplecp/Widget/CustomButton/CustomButton.dart';
import 'package:repeoplecp/Widget/CustomTextField.dart';
import 'package:repeoplecp/Widget/HorizontalDividerWidget.dart';
import 'package:repeoplecp/Widget/SvgPictureWidget/SvgPictureWidget.dart';

class SelectRegistrationPage extends StatefulWidget {
  const SelectRegistrationPage({super.key});

  @override
  State<SelectRegistrationPage> createState() => _SelectRegistrationPageState();
}

class _SelectRegistrationPageState extends State<SelectRegistrationPage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  RegistrationController cntRegistration = Get.put(RegistrationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: cntRegistration.globalRegistrationPageKey,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: appBarHeight),
                      if (cntRegistration.isResisterMyCompany.value == false && cntRegistration.isMyCompanyIsRegister.value == false)
                        registeredData(),
                      const SizedBox(height: 20),
                      Visibility(
                          visible: cntRegistration.isResisterMyCompany.value,
                          child: registeredMyCompanyData()),
                      Visibility(
                        visible: cntRegistration.isMyCompanyIsRegister.value,
                          child: checkIfMyCompany()),
                      // Visibility(
                      //     visible: cntRegistration.isInvitationSuccess.value,
                      //     child: invitationRequestWidget()),
                      const SizedBox(height: 40),
                    ],
                  )),
            ),
            Obx(() => cntCommonHeader.commonAppBar(
                    cntRegistration.isResisterMyCompany.value == true
                        ? "Register My Company"
                        : cntRegistration.isMyCompanyIsRegister.value==true ? "Check if my Company" : "Select",
                    cntRegistration.globalRegistrationPageKey,
                    color: AppColors.whiteColor,
                    logOutOnTap: () {},
                backOnTap: () {
                        if (cntRegistration.isResisterMyCompany.value == true
                            || cntRegistration.isMyCompanyIsRegister.value == true) {
                          cntRegistration.isResisterMyCompany.value = false;
                          if(cntRegistration.isRERATextShow.value == false) {
                            cntRegistration.isMyCompanyIsRegister.value = false;
                            cntRegistration.isResisterMyCompany.value = false;
                          }
                        } else {
                          Get.back();
                        }
                        if(cntRegistration.isRERATextShow.value==true){
                          cntRegistration.isRERATextShow.value = false;
                        }
                }, isLogOutButtonHide: true, isShowBackArrow: true))
          ],
        ),
      ),
    );
  }

  Widget registeredData() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          registeredSelectWidget(
              onTap: () {
                cntRegistration.registerOption?.value =
                    RegistrationSelect.registerMyCompany;
                cntRegistration.isResisterMyCompany.value = true;
              },
              icons: DefaultSvg(
                  imagePath: registeredSvgIcons,
                  height: 70.w,
                  width: 70.w,
                  color: AppColors.black),
              titleText: "Register My Company",
              description:
                  "I am an authorised representative of the company and would like to register my company with Prestige Group and act as admin."),
          const SizedBox(height: 10),
          Text(
            "OR",
            style: mediumTextStyle(
                fontSize: 10,
                txtColor: AppColors.labelGreyColor,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          registeredSelectWidget(
              onTap: () {
                cntRegistration.registerOption?.value =
                    RegistrationSelect.myCompanyIsRegistered;
                cntRegistration.isMyCompanyIsRegister.value=true;
                cntRegistration.txtReRaNo.value!.text = '';
              },
              icons: DefaultSvg(
                  imagePath: registeredSearchSvgIcons,
                  height: 70.w,
                  width: 70.w,
                  color: AppColors.black),
              titleText: "Check if my Company is registered",
              description:
                  "I am a team member and want to check if the company I represent, is already registered with Prestige Group or not."),
        ],
      ),
    );
  }

  Widget registeredMyCompanyData() {
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
          Text(
            "Register My Company",
            style: mediumTextStyle(
                txtColor: AppColors.appThemeColor,
                fontWeight: FontWeight.w600,
                fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            "I am an authorised representative of the company and would like to register my company with Prestige Group and act as admin.",
            style: mediumTextStyle(
                txtColor: AppColors.newBlack,
                fontWeight: FontWeight.w400,
                fontSize: 10),
          ),
          const SizedBox(height: 12),
          registerCertificateOptionData(),
          const SizedBox(height: 12),
          HorizontalDivider(height: 1.2, color: AppColors.lightGreyColor),
          const SizedBox(height: 12),
          gstCertificatesWidget(),
          const SizedBox(height: 12),
          saveRegisterMyCompanyButton()
        ],
      ),
    );
  }

  Widget registerCertificateOptionData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "To continue with this option, you will require:",
          style: mediumTextStyle(
              txtColor: AppColors.newBlack,
              fontWeight: FontWeight.w400,
              fontSize: 10),
        ),
        const SizedBox(height: 12),
        Obx(
          () => ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: cntRegistration.arrCertificateList != null
                ? cntRegistration.arrCertificateList.length
                : 0,
            itemBuilder: (BuildContext context, int index) {
              CertificateModel obj = cntRegistration.arrCertificateList[index];
              return Obx(() => Padding(
                    padding: EdgeInsets.only(
                        bottom: obj.title == "Cancelled Cheque" ? 0 : 12.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 22,
                          width: 22,
                          child: Theme(
                            data: ThemeData(
                                checkboxTheme: const CheckboxThemeData(
                                    splashRadius: 6,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.comfortable,
                                    shape: BeveledRectangleBorder(
                                        side: BorderSide()),
                                    mouseCursor: MaterialStatePropertyAll(
                                        MaterialStateMouseCursor.clickable))),
                            child: Checkbox(
                              value: obj.isCheck?.value,
                              onChanged: (value) {
                                obj.isCheck?.value = value ?? false;
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              tristate: true,
                              activeColor: AppColors.appThemeColor,
                              focusColor: AppColors.lightGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                                side: BorderSide(
                                    color: AppColors.lightGrey,
                                    width: 0.4,
                                    style: BorderStyle.solid),
                              ),
                              splashRadius: 4,
                              visualDensity:
                                  VisualDensity.adaptivePlatformDensity,
                              side: BorderSide(
                                width: 1.2,
                                color: AppColors.lightGrey,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          obj.title ?? "",
                          style: TextStyle(
                            color: obj.isCheck?.value == true
                                ? AppColors.newBlack
                                : AppColors.greyColor,
                            fontWeight: FontWeight.w700,
                            fontFamily: fontFamily,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 0.h);
            },
          ),
        )
      ],
    );
  }

  Widget gstCertificatesWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("GST Certificate",
            style: mediumTextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                txtColor: AppColors.labelGreyColor)),
        SizedBox(height: 12.w),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() => GestureDetector(
                      onTap: () {
                        cntRegistration.gstCertificatesOption?.value =
                            GSTCertificatesSelect.gstCertificates;
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5, color: AppColors.appThemeColor),
                            shape: BoxShape.circle),
                        child: Center(
                          child: ClipOval(
                            child: Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                  color: cntRegistration
                                              .gstCertificatesOption?.value ==
                                          GSTCertificatesSelect.gstCertificates
                                      ? AppColors.appThemeColor
                                      : AppColors.whiteColor,
                                  shape: BoxShape.circle),
                            ),
                          ),
                        ),
                      ),
                    )),
                const SizedBox(width: 10),
                Text("GST Certificate",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: cntRegistration.gstCertificatesOption?.value ==
                                GSTCertificatesSelect.gstCertificates
                            ? AppColors.newBlack
                            : AppColors.labelGreyColor,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp)),
              ],
            )),
        const SizedBox(height: 20),
        Obx(() => Row(
              children: [
                Obx(() => GestureDetector(
                      onTap: () {
                        cntRegistration.gstCertificatesOption?.value =
                            GSTCertificatesSelect.noGSTDeclaration;
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5, color: AppColors.appThemeColor),
                            shape: BoxShape.circle),
                        child: Center(
                          child: ClipOval(
                            child: Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                  color: cntRegistration
                                              .gstCertificatesOption?.value ==
                                          GSTCertificatesSelect.noGSTDeclaration
                                      ? AppColors.appThemeColor
                                      : AppColors.whiteColor,
                                  shape: BoxShape.circle),
                            ),
                          ),
                        ),
                      ),
                    )),
                const SizedBox(width: 10),
                Text("No GST Declaration",
                    style: TextStyle(
                        color: cntRegistration.gstCertificatesOption?.value ==
                                GSTCertificatesSelect.noGSTDeclaration
                            ? AppColors.newBlack
                            : AppColors.labelGreyColor,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp)),
                Text(" [Download]",
                    style: TextStyle(
                        color: AppColors.appThemeColor,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp)),
              ],
            )),
      ],
    );
  }

  Widget checkIfMyCompany() {
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
      child: Form(
        key: cntRegistration.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Check if my Company is registered",
              style: mediumTextStyle(
                  txtColor: AppColors.appThemeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              "I am a team member and want to check if the company I represent, is already registered with Prestige Group or not.",
              style: mediumTextStyle(
                  txtColor: AppColors.newBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 10),
            ),
            SizedBox(height: cntRegistration.isRERATextShow.value != true?10:12),
            Obx(() => cntRegistration.isRERATextShow.value != true
                ? simpleTextFieldNewWithCustomization(
                    hintText: "EXAMPLEA51800035827",
                    controller: cntRegistration.txtReRaNo,
                    inputFormat: [UpperCaseTextFormatter()],
                    textInputType: TextInputType.text,
                    labelText: "RERA Number*",
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) =>
                        validation(value, "Please enter RERA number"))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          cntRegistration.txtReRaNo.value!.text.toString(),
                        style: mediumTextStyle(txtColor: AppColors.green,fontWeight: FontWeight.w600,fontSize: 12),
                      ),
                      Text(
                        reRaText,
                        style: mediumTextStyle(txtColor: AppColors.green,fontWeight: FontWeight.w400,fontSize: 12),
                      )
                    ],
                  )),
            const SizedBox(height: 12),
            cntRegistration.isRERATextShow.value != true
            ? saveCheckMyCompanyRegisteredButton()
            : requestAnInviteButton(),
            SizedBox(height: cntRegistration.isRERATextShow.value == true?12:0),
            cntRegistration.isRERATextShow.value == true

            ? GestureDetector(
              onTap: (){
                if(cntRegistration.isRERATextShow.value == true){
                  cntRegistration.isRERATextShow.value = false;
                  cntRegistration.txtReRaNo.value!.text = '';
                }
              },
              child: Center(
                child: Text(
                  "Check Other Number".toUpperCase(),
                  style: mediumTextStyle(txtColor: AppColors.appThemeColor,fontWeight: FontWeight.w600,fontSize: 10),
                ),
              ),
            ) :const SizedBox()
          ],
        ),
      ),
    );
  }



  Widget saveRegisterMyCompanyButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: OnTapButton(
            onTap: () {Get.to(()=>const RERADetailsPage());},
            height: 40.w,
            decoration: CustomDecorations().backgroundLocal(
                AppColors.labelGreyColor, 6, 0, AppColors.whiteColor),
            text: "Register Now".toUpperCase(),
            style: TextStyle(
                color: AppColors.whiteColor,
                fontFamily: fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp)));
  }

  Widget saveCheckMyCompanyRegisteredButton() {
    return OnTapButton(
        onTap: () {
          if (cntRegistration.formKey.currentState!.validate()) {
            cntRegistration.isRERATextShow.value = true;

          }
        },
        height: 40.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.labelGreyColor, 6, 0, AppColors.whiteColor),
        text: "Register Now".toUpperCase(),
        style: TextStyle(
            color: AppColors.whiteColor,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp));
  }

  Widget requestAnInviteButton() {
    return OnTapButton(
        onTap: () {
          Get.to(()=>  RegistrationSuccessPage(isInvitationSuccess: cntRegistration.isInvitationSuccessShowScreen.value=true))?.whenComplete(() {
            // cntRegistration.isInvitationSuccessShowScreen.value=true;
          });
        },
        height: 40.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.appThemeColor, 6, 0, AppColors.whiteColor),
        text: "Request an Invite".toUpperCase(),
        style: TextStyle(
            color: AppColors.whiteColor,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp));
  }

  Widget registeredSelectWidget(
      {Widget? icons,
      String? titleText,
      String? description,
      GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 24, top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icons ?? const SizedBox(),
            const SizedBox(height: 10),
            Text(
              titleText ?? "",
              style: mediumTextStyle(
                  fontWeight: FontWeight.w600,
                  txtColor: AppColors.appThemeColor,
                  fontSize: 14),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                description ?? "",
                textAlign: TextAlign.center,
                style: mediumTextStyle(
                    fontWeight: FontWeight.w400,
                    txtColor: AppColors.newBlack,
                    fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
