import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/EditProfileController/edit_profile_controller.dart';
import 'package:repeoplecp/View/SelectRegistrationPage/select_registration_page.dart';
import 'package:repeoplecp/Widget/custom_boxDecoration.dart';
import 'package:repeoplecp/Widget/CustomButton/custom_button.dart';
import 'package:repeoplecp/Widget/custom_textField.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  EditProfileController cntEditProfile = Get.put(EditProfileController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cntEditProfile.roleTypeData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: cntEditProfile.globalEditProfilePageKey,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: appBarHeight),
                  editFormData(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            cntCommonHeader.commonAppBar(
                "Edit Profile", cntEditProfile.globalEditProfilePageKey,
              isSkipButtonHide: true
            )
          ],
        ),
      ),
    );
  }

  Widget editFormData() {
    return Container(
      color: AppColors.whiteColor,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 6,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                editImageData(),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: cntEditProfile.formKey,
                  child: Column(
                    children: [
                      simpleTextFieldNewWithCustomization(
                          hintText: "John",
                          controller: cntEditProfile.txtFirstName,
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
                          controller: cntEditProfile.txtLastName,
                          textInputType: TextInputType.name,
                          inputFormat: [UpperCaseTextFormatter()],
                          textCapitalization: TextCapitalization.sentences,
                          labelText: "Last Name*",
                          validator: (value) =>
                              validation(value, "Please enter last name")),
                      const SizedBox(
                        height: 16,
                      ),
                      phoneNumberTextField(
                          cntEditProfile.txtContactNew,cntEditProfile.mobileFocusNode),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                simpleTextFieldNewWithCustomization(
                  hintText: "johndoe@example.com",
                  controller: cntEditProfile.txtEmailNew,
                  textInputType: TextInputType.emailAddress,
                  labelText: "Email",
                ),
                const SizedBox(
                  height: 16,
                ),
                commonDropDownTextField(
                  labelText: "Role",
                  onTap: () {
                    cntEditProfile.selectRoleType();
                  },
                  controller: cntEditProfile.txtUserRole,
                  hintText: "Select Role",
                ),
                const SizedBox(
                  height: 60,
                ),
                saveButton(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget editImageData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Profile Photo",
          style: TextStyle(
              fontSize: 11.sp,
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
            Obx(() => cntEditProfile.image.value != "" ||
                    profilePic.value != ""
                ? Obx(() => Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 70.w,
                          height: 70.w,
                          decoration: BoxDecoration(
                            color: AppColors.appThemeColor.withOpacity(0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: cntEditProfile.image.value != ""
                              ? Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.file(
                                    File(cntEditProfile.image.value),
                                    fit: BoxFit.cover,
                                  ))
                              : Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image(
                                      image: NetworkImage(profilePic.value),
                                      fit: BoxFit.cover)),
                        ),
                      ],
                    ))
                : GestureDetector(
                    onTap: () {
                      cntEditProfile.profileImagePicker();
                    },
                    child: Container(
                      width: 70.w,
                      height: 70.w,
                      // margin: EdgeInsets.only(right: 9.w,bottom: 9.h),
                      decoration: BoxDecoration(
                        color: AppColors.appThemeColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          "+ADD",
                          style: TextStyle(
                              color: AppColors.appThemeColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: fontFamily),
                        ),
                      ),
                    ),
                  )),
            SizedBox(width: 8.w),
            Obx(() => cntEditProfile.image.value == ""
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      cntEditProfile.profileImagePicker();
                    },
                    child:  Text("CHANGE",style: mediumTextStyle(txtColor: AppColors.appThemeColor,fontWeight: FontWeight.w600,fontSize: 10),)))
          ],
        ),
        SizedBox(
          height: 5.w,
        ),
        Divider(
          color: AppColors.greyColor,
          thickness: 1,
        ),
      ],
    );
  }

  Widget saveButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: onTapButton(
            onTap: () {
              if (cntEditProfile.formKey.currentState!.validate()) {
                // cntEditProfile.editProfile();
              Get.to(()=>const SelectRegistrationPage());
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
