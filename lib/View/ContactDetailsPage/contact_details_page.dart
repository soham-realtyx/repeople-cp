import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/RegistrationController/registration_controller.dart';
import 'package:repeoplecp/View/RegistrationSuccessPage/registration_success_page.dart';
import 'package:repeoplecp/Widget/custom_boxDecoration.dart';
import 'package:repeoplecp/Widget/CustomButton/custom_button.dart';
import 'package:repeoplecp/Widget/custom_textField.dart';

class ContactDetailsPage extends StatefulWidget {
  final String? mobileNo;
  final String? address;
  final String? website;
  final String? fName;
  final String? lName;
  final String? designation;
  final String? email;
  final String? poinOfMobileNo;
  const ContactDetailsPage(
      {super.key,
      this.mobileNo,
      this.address,
      this.email,
      this.designation,
      this.fName,
      this.lName,
      this.poinOfMobileNo,
      this.website});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  @override
  void initState() {
    super.initState();
    cntRegistration.txtMobileNo.value!.text=widget.mobileNo??"";
    cntRegistration.txtCorrespondenceAddress.value!.text=widget.address??"";
    cntRegistration.txtWebsite.value!.text=widget.website??"";
    cntRegistration.txtFirstName.value!.text=widget.fName??"";
    cntRegistration.txtLastName.value!.text=widget.lName??"";
    cntRegistration.txtPointOfMobile.value!.text=widget.poinOfMobileNo??"";
    cntRegistration.txtPointOfEmail.value!.text=widget.email??"";
    cntRegistration.txtDesignation.value!.text=widget.designation??"";
  }

  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  RegistrationController cntRegistration = Get.put(RegistrationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: cntRegistration.globalContactDetailsPageKey,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 85.w),
                  checkIfMyCompanyIsRegisteredData(),
                  const SizedBox(height: 12),
                  pointOfContactDetailsData(),
                  const SizedBox(height: 20),
                  saveButton(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Obx(() => cntCommonHeader.commonAppBar(
                  "Contact Details",
                  cntRegistration.globalContactDetailsPageKey,
                ))
          ],
        ),
      ),
    );
  }

  Widget checkIfMyCompanyIsRegisteredData() {
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
          Text("Check if my Company is registered",
              style: semiBoldTextStyle(
                  txtColor: AppColors.appThemeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14)),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: cntRegistration.contactDetailsFormKey,
            child: Column(
              children: [
                phoneNumberTextField(cntRegistration.txtMobileNo),
                const SizedBox(
                  height: 16,
                ),
                simpleTextFieldNewWithCustomization(
                    hintText: "Address",
                    controller: cntRegistration.txtCorrespondenceAddress,
                    inputFormat: [UpperCaseTextFormatter()],
                    textInputType: TextInputType.name,
                    labelText: "Correspondence Address*",
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) => validation(
                        value, "Please enter correspondence Address")),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          simpleTextFieldNewWithCustomization(
            hintText: "www.example.com",
            controller: cntRegistration.txtWebsite,
            inputFormat: [UpperCaseTextFormatter()],
            textInputType: TextInputType.name,
            labelText: "Website",
            textCapitalization: TextCapitalization.sentences,
          ),
        ],
      ),
    );
  }

  Widget pointOfContactDetailsData() {
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
        key: cntRegistration.pointOfContactDetailsFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Point of Contact Details",
                style: semiBoldTextStyle(
                    txtColor: AppColors.appThemeColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
            const SizedBox(
              height: 20,
            ),
            simpleTextFieldNewWithCustomization(
                hintText: "John",
                controller: cntRegistration.txtFirstName,
                inputFormat: [UpperCaseTextFormatter()],
                textInputType: TextInputType.name,
                labelText: "First Name*",
                textCapitalization: TextCapitalization.sentences,
                validator: (value) =>
                    validation(value, "Please enter first name")),
            const SizedBox(
              height: 16,
            ),
            simpleTextFieldNewWithCustomization(
                hintText: "Doe",
                controller: cntRegistration.txtLastName,
                textInputType: TextInputType.name,
                inputFormat: [UpperCaseTextFormatter()],
                textCapitalization: TextCapitalization.sentences,
                labelText: "Last Name*",
                validator: (value) =>
                    validation(value, "Please enter last name")),
            const SizedBox(
              height: 16,
            ),
            simpleTextFieldNewWithCustomization(
                hintText: "Example",
                controller: cntRegistration.txtDesignation,
                textInputType: TextInputType.name,
                inputFormat: [UpperCaseTextFormatter()],
                textCapitalization: TextCapitalization.sentences,
                labelText: "Designation*",
                validator: (value) =>
                    validation(value, "Please enter designation")),
            const SizedBox(
              height: 16,
            ),
            phoneNumberTextField(cntRegistration.txtPointOfMobile),
            const SizedBox(
              height: 16,
            ),
            simpleTextFieldNewWithCustomization(
                hintText: "email@example.com",
                controller: cntRegistration.txtPointOfEmail,
                inputFormat: [UpperCaseTextFormatter()],
                textInputType: TextInputType.name,
                labelText: "Email*",
                textCapitalization: TextCapitalization.sentences,
                validator: (value) => validation(value, "Please enter email")),
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: onTapButton(
            onTap: () {
              if (cntRegistration.contactDetailsFormKey.currentState!
                      .validate() ||
                  cntRegistration.pointOfContactDetailsFormKey.currentState!
                      .validate()) {
                Get.to(() => RegistrationSuccessPage(
                      isRegisteredSuccess:
                          cntRegistration.isResisterShowScreen.value = true,
                    ));
              }
            },
            height: 40.w,
            decoration: CustomDecorations().backgroundLocal(
                AppColors.appThemeColor, 6, 0, AppColors.appThemeColor),
            text: "Submit".toUpperCase(),
            style: TextStyle(
                color: AppColors.whiteColor,
                fontFamily: fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp)));
  }
}
