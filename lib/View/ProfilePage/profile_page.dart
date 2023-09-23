import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/string.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/MyAccountController/myaccount_controller.dart';
import 'package:repeoplecp/View/BankDetailsPage/bank_details_page.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/bottom_navigationBar_page.dart';
import 'package:repeoplecp/View/ContactDetailsPage/contact_details_page.dart';
import 'package:repeoplecp/View/EditProfilePage/edit_profile_page.dart';
import 'package:repeoplecp/View/GSTDetailsPage/gst_details_page.dart';
import 'package:repeoplecp/View/MarketingInformation/marketing_information_page.dart';
import 'package:repeoplecp/View/PanDetailsPage/pan_details_page.dart';
import 'package:repeoplecp/View/RERADetailsPage/rera_details_page.dart';
import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';
import 'package:repeoplecp/Widget/CustomStyledSwitch/custom_styled_switch.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  MyAccountController cntAccount = Get.put(MyAccountController());
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  GlobalKey<ScaffoldState> globalMyAccountPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // check.value = globalMyAccountPageKey;
      BottomNavigationBarPage().selectedIndex = 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        // WillPopScope(
        // onWillPop: ()async{
        //   BottomNavigationBarPage().selectedIndex=4;
        //   Get.offAll(const HomePage());
        //   return false;
        // },
        // child:
        Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: globalMyAccountPageKey,
      endDrawer: const CustomDrawer(
        animatedOffset: Offset(1.0, 0),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: appBarHeight),
                  accountHeaderData(),
                  const SizedBox(height: 20),
                  myLoginDetailsData(),
                  const SizedBox(height: 20),
                  whatsAppStatusData(),
                  const SizedBox(height: 40),
                  loginDetailsListData()
                ],
              ),
            ),
            cntCommonHeader.commonAppBar("Profile", globalMyAccountPageKey,
                isMenuIconHide: true)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarPage(selectedIndex: 4),
    );
    // );
  }

  Widget accountHeaderData() {
    return Container(
      height: 130.w,
      color: AppColors.lightWhite,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.appThemeColor,
            ),
            height: 88.w,
            width: Get.width,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  loginUserImage1(),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const EditProfilePage());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Text(
                              /*firstname.value*/ "YASH",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 22.sp,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w900,
                                  height: 0.9.w,
                                  // letterSpacing: 0.8,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 6
                                    ..color = AppColors.appThemeColor,
                                ),
                              ),
                            ),
                            Text(/*firstname.value*/ "YASH",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontFamily: fontFamily,
                                      // letterSpacing: 0.8,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 22.sp,
                                      color: AppColors.whiteColor,
                                      height: 0.9.w),
                                )),
                          ],
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Text(
                              /*lastname.value*/ "GOSWAMI",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 22.sp,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w900,
                                  height: 0.9.w,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 6
                                    ..color = AppColors.appThemeColor,
                                ),
                              ),
                            ),
                            Text(/*lastname.value*/ "GOSWAMI",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontFamily: fontFamily,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 22.sp,
                                      color: AppColors.whiteColor,
                                      height: 0.9.w),
                                )),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Get.to(() =>
                                const EditProfilePage() /*)?.whenComplete(() => cntAccount.getProfileData()*/);
                          },
                          child: Text(
                            lblEditProfile.toUpperCase(),
                            style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 10.sp,
                                color: AppColors.newBlack,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 12.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget loginUserImage1() {
    return Container(
      width: 70.w,
      height: 70.w,
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.whiteColor, width: 2),
          color: AppColors.whiteColor),
      child: InkWell(
        onTap: () {
          if (Is_Login.isTrue) {
            Get.to(const EditProfilePage());
          } else {
            Get.back();
            //LoginDialog();
          }
        },
        child: Container(
          width: 70.h,
          height: 70.w,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.whiteColor),
          child: !Is_Login.isTrue
              ? SvgPicture.asset(userDefaultImage)
              : cntAccount.userImage.value != ""
                  ? Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.file(
                        File(cntAccount.userImage.value),
                        fit: BoxFit.cover,
                      ))
                  : Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image(
                          image: NetworkImage(profile_pic.value),
                          fit: BoxFit.cover)),
        ),
      ),
    );
  }

  Widget myLoginDetailsData() {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 0,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: AppColors.whiteColor, width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          myLoginDataDetailsWidget(title: "Role", subtitle: "Admin"),
          SizedBox(height: 20.h),
          myLoginDataDetailsWidget(
            title: "Email",
            subtitle: /*email.value*/ "yash@themidnight.in",
          ),
          SizedBox(height: 20.h),
          myLoginDataDetailsWidget(
              title: "Mobile",
              subtitle: "${"+91"} ${/*mobile.value*/ "9876543210"}"),
        ],
      ),
    );
  }

  Widget myLoginDataDetailsWidget({String? title, String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toString(),
          style: TextStyle(
            color: AppColors.labelGreyColor,
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
            fontFamily: fontFamily,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          subtitle.toString(),
          style: TextStyle(
            color: AppColors.newBlack,
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            fontFamily: fontFamily,
          ),
        )
      ],
    );
  }

  Widget loginActionListData(
      {String? icons,
      String? title,
      GestureTapCallback? onTap,
      String? count}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  icons ?? "",
                  height: 24.w,
                  width: 24.w,
                  color: AppColors.black,
                ),
                const SizedBox(width: 10),
                Text(
                  title.toString(),
                  style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                count != "0"
                    ? Container(
                        width: 16.w,
                        height: 16.w,
                        // padding: const EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(19),
                          shape: BoxShape.circle,
                          color: AppColors.red,
                        ),
                        child: Center(
                          child: Text(
                            count.toString(),
                            textAlign: TextAlign.center,
                            style: mediumTextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                txtColor: AppColors.whiteColor),
                          ),
                        ),
                      )
                    : const SizedBox(),
                SvgPicture.asset(
                  newRightArrowSvgIcons,
                  height: 24.w,
                  width: 24.w,
                  color: AppColors.black,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget whatsAppStatusData() {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 20),
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: hex("D0EEE1"),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(whatsAppSvgIcons, width: 32, height: 32),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Are you on WhatsApp?",
                style: semiBoldTextStyle(
                    txtColor: AppColors.lightGreen,
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              ),
              const SizedBox(height: 4),
              SizedBox(
                  width: 185.w,
                  child: Text(
                    "We’ll share all your updates with you there",
                    style: mediumTextStyle(
                        txtColor: AppColors.boldLightGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 10),
                  )),
            ],
          ),
          const SizedBox(width: 10),
          StyledSwitch(
            onToggled: (isToggled) {
              cntAccount.isWhatsAppEnable.value = isToggled;
            },
          )
        ],
      ),
    );
  }

  Widget loginDetailsListData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        loginActionListData(
            onTap: () {
              Get.to(() => const ReRaDetailsPage(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 350)
              );
            },
            icons: reportSvgIcons,
            title: "RERA Details",
            count: "3"),
        loginActionListData(
            onTap: () {
              Get.to(() => const PanDetailsPage(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 350)
              );
            },
            icons: reportSvgIcons,
            title: "PAN Details",
            count: "0"),
        loginActionListData(
            onTap: () {
              Get.to(() => const GSTDetailsPage(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 350)
              );
            },
            icons: reportSvgIcons,
            title: "GST Details",
            count: "3"),
        loginActionListData(
            onTap: () {
              Get.to(() => const BankDetailsPage(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 350)
              );
            },
            icons: buildingBankSvgIcons,
            title: "Bank Account Details",
            count: "2"),
        loginActionListData(
            onTap: () {
              Get.to(() => const ContactDetailsPage(
                    mobileNo: "9876543210",
                    address:
                        "203, 2nd Floor, Ackruti Star, MIDC Central Road, Andheri East, Mumbai, 400093",
                    designation: "Accountant",
                    email: "johnbrikkin.com",
                    fName: "John",
                    lName: "Doe",
                    poinOfMobileNo: "9876543210",
                    website: "https://brikkin.com",
                  ),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 350)
              );
            },
            icons: reportSvgIcons,
            title: "Contact Details",
            count: "0"),
        loginActionListData(
            onTap: () {
              Get.to(()=>const MarketingInformation(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 350)
              );
            },
            icons: reportSvgIcons,
            title: "Marketing Information",
            count: "0"),
        loginActionListData(
            onTap: () {}, icons: logOutSvgIcons, title: "Logout", count: "0"),
      ],
    );
    /*return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: cntAccount.arrLoginDetailsList.length,
      itemBuilder: (context, index) {
        LoginDetailsModel objLoginDetails = cntAccount.arrLoginDetailsList[index];
        return
          loginActionListData(
          count: objLoginDetails.count??"",
          title: objLoginDetails.name??"",
          icons: objLoginDetails.icon??"",
          onTap: objLoginDetails.onTap
        );
      },
    );*/
  }
}
