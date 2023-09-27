import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/TeamController/team_controller.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/bottom_navigationbar_page.dart';
import 'package:repeoplecp/Widget/custom_boxDecoration.dart';
import 'package:repeoplecp/Widget/CustomButton/custom_button.dart';
import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';
import 'package:repeoplecp/Widget/custom_textField.dart';

class AddTeamsPage extends StatefulWidget {
  const AddTeamsPage({super.key});

  @override
  State<AddTeamsPage> createState() => _AddTeamsPageState();
}

class _AddTeamsPageState extends State<AddTeamsPage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  TeamController cntTeam = Get.put(TeamController());
  GlobalKey<ScaffoldState> globalAddTeamPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    cntTeam.roleTypeData();
    BottomNavigationBarPage().selectedIndex = 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: globalAddTeamPageKey,
      endDrawer: const CustomDrawer(
        animatedOffset: Offset(1.0, 0),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 90),
                  addTeamFormData(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            cntCommonHeader.commonAppBar("Add Team Member", globalAddTeamPageKey,
                isMenuIconHide: true),
          ],
        ),
      ),
    );
  }

  Widget addTeamFormData(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 20),
      margin: const EdgeInsets.only(right: 20,left: 20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow:[
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 3)
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form(
            key: cntTeam.formKey,
            child: Column(
              children: [
                simpleTextFieldNewWithCustomization(
                    hintText: "John",
                    controller: cntTeam.txtFirstName,
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
                    controller: cntTeam.txtLastName,
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
                    cntTeam.txtContactNew,cntTeam.mobileFocusNode),
                const SizedBox(
                  height: 16,
                ),
                simpleTextFieldNewWithCustomization(
                  hintText: "email@example.com",
                  controller: cntTeam.txtEmail,
                  textInputType: TextInputType.emailAddress,
                  labelText: "Email",
                ),
                const SizedBox(
                  height: 16,
                ),
                commonDropDownTextField(
                  labelText: "Role",
                  onTap: () {
                    cntTeam.selectRoleType();
                  },
                  controller: cntTeam.txtUserRole,
                  hintText: "Select Role",
                ),
                const SizedBox(
                  height: 70,
                ),
                saveButton()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget saveButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: onTapButton(
            onTap: () {
              if (cntTeam.formKey.currentState!.validate()) {
                Get.back();
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
