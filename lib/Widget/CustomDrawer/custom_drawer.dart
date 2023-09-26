
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:repeoplecp/Controller/Drawer/drawer_controller.dart';
import 'package:repeoplecp/Model/DrawerModal/drawer_modal.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/bottom_navigationbar_page.dart';
import 'package:repeoplecp/View/ProfilePage/profile_page.dart';
import 'package:repeoplecp/View/RelationShipManagerPage/relationship_manager_page.dart';
import 'package:repeoplecp/View/SendOTPPage/send_otp_page.dart';
import 'package:repeoplecp/Widget/AnimationDrawer/animated_drawer.dart';

class CustomDrawer extends StatefulWidget {
  final Offset? animatedOffset;
  final bool? isRegistered;
  const CustomDrawer({super.key,this.animatedOffset,this.isRegistered});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  CustomDrawerController cntDrawer = Get.put(CustomDrawerController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cntDrawer.isRegistered.value=widget.isRegistered??false;
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedDrawer(
        offset: widget.animatedOffset,
        duration: const Duration(milliseconds: 200),
    child: SafeArea(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            drawerData()
          ],
        ),
      ),
    )
    );
  }

  Widget drawerData() {
    return SafeArea(
      child: Container(
        width: 320.w,
        height: Get.height,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: AppColors.pageBackgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10))),
        child: Stack(
          children: [
            Column(
              children: [
                drawerHeaderData(),
                newDrawerAllData(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget newDrawerAllData(){
    return Expanded(
      child: ListView(
        physics: const ScrollPhysics(),
        clipBehavior: Clip.hardEdge,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.w),
              newDrawerListData(),
              SizedBox(height: 20.w),
              newDrawerOtherListData(),
              const SizedBox(height: 80,)
            ],
          ),
        ],
      ),
    );
  }

  Widget newDrawerOtherListData(){
    return Obx(() => ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: cntDrawer.arrNewDrawerOtherList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        DrawerModal objList = cntDrawer.arrNewDrawerOtherList[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: GestureDetector(
            onTap:objList.onTap??(){},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      objList.images??"",
                      color: Colors.black,
                      height: 24.w,width: 24.w, fit: BoxFit.cover,),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text(
                      objList.title??"",
                      style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black
                      ),
                    ),
                    objList.lblVersion??const SizedBox(),
                  ],
                ),
                SvgPicture.asset(
                  rightArrowSvgIcons,
                  height: 15.w,
                  width: 15.w,
                  color: AppColors.black,
                ),
              ],
            ),
          ),
        );
      },
    ));
  }

  Widget drawerHeaderData() {
    return SizedBox(
      height: 130.w,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.appThemeColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                )),
            height: 90.w,
            width: Get.width,
          ),
          Padding(
            padding: EdgeInsets.only(top: 24.0.w,right: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                cntDrawer.closeIcon(),
              ],
            ),
          ),
          loginUserImageData(),

        ],
      ),
    );
  }

  Widget loginUserImageData() {
    return Positioned(
      top: 55.w,
      left: 20,
      child: Row(
        crossAxisAlignment: !isLogin.isTrue?CrossAxisAlignment.center:CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            child: InkWell(
              onTap: () {
                if (isLogin.isTrue) {
                  const ProfilePage();
                } else {
                  Get.back();
                  // cntDrawer.LoginDialog();
                }
              },
              child: Container(
                width: 74.w,
                height: 74.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.whiteColor, width: 1),
                    color: AppColors.whiteColor),
                child: !isLogin.isTrue
                    ? Image.asset(
                  width: 74.w,
                  height: 74.w,
                  userPngImage,
                  fit: BoxFit.fill,
                )
                    : cntDrawer.image.value != ""
                    ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(cntDrawer.image.value),
                      fit: BoxFit.fill,
                      width: 74.w,
                      height: 74.w,
                    ))
                    : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                        width: 74.w,
                        height: 74.w,
                        image: NetworkImage(profilePic.value),
                        fit: BoxFit.fill)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: (){
              isLogin.isFalse ? Get.to(()=>const SendOTPPage()) : Get.to(()=>const ProfilePage());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Text(
                        isLogin.isTrue
                            ? lblAppMenu
                            : /*firstname.value*/"Yash".toUpperCase(),
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 22.sp,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w900,
                            height: 1,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 6
                              ..color = AppColors.appThemeColor,
                          ),
                        )),
                    Text(
                        isLogin.isTrue
                            ? lblAppMenu
                            : /*firstname.value*/
                        "Yash".toUpperCase(),
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w900,
                              fontSize: 22.sp,
                              color: AppColors.whiteColor,
                              height: 1),
                        )),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Text(
                          "Goswami".toUpperCase(),
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 22.sp,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w900,
                              height: 0.9,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 6
                                ..color = AppColors.appThemeColor,
                            ),
                          )),
                      Text(
                          // !Is_Login.isTrue
                          //     ? lblAppMenuLoginSignUp
                          //     :
                          /*lastname.value*/"Goswami".toUpperCase(),
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.w900,
                                fontSize: 22.sp,
                                color: AppColors.whiteColor,
                                height: 0.9),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Get.to(()=>const ProfilePage());
                    BottomNavigationBarPage().selectedIndex = 4;
                  },
                  child: Text(
                    /*!Is_Login.isTrue ? "" :*/ lblViewProfile.toUpperCase(),
                    style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 10.sp,
                        color: AppColors.labelGreyColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          // SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget newDrawerListData() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() =>  ListView.builder(
            itemCount: cntDrawer.arrNewDrawerList_1.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Obx(() => _newDrawerListData(index));
            },
          )),
          SizedBox(height: 12.w),
          GestureDetector(
            onTap: (){
              Get.to(()=>const RelationShipManagerPage());
            },
            child: Container(
              width:Get.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.08),
                    spreadRadius: 0,
                    blurRadius: 6,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 8,
                          bottom: 8),
                      decoration: BoxDecoration(
                          color: AppColors.relationShipManagerColor,
                          borderRadius:
                          BorderRadius.circular(6)),
                      child:
                      SvgPicture.asset(
                        relationShipManagerSvgIcons,
                        height: 24.w,
                        width: 24.w,
                        color: AppColors.whiteColor,
                      )),
                  const SizedBox(width: 8),
                  Text(
                    "Relationship Manager",
                    style: mediumTextStyle(
                        fontSize: 12, txtColor: AppColors.black),
                    textAlign: TextAlign.left,
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: 12.w),
          Obx(() => ListView.builder(
            itemCount: cntDrawer.arrNewDrawerList_2.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index2) {
              return _newDrawerListData2(index2);
            },
          ))
        ],
      ),
    );
  }

  Widget _newDrawerListData(int index) {
    DrawerModal objDrawerList_1 = cntDrawer.arrNewDrawerList_1[index];
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(left: 20,right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            index == 0
                ? Expanded(
              child: GestureDetector(
                onTap: (){
                  cntDrawer.navigateProjectScreen_1(index);
                },
                child:  Container(
                  height: 192.w,
                  width: 140.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          height: 192.w,
                          width: 140.w,
                          fadeInDuration: Duration.zero,
                          fadeOutDuration: Duration.zero,
                          placeholderFadeInDuration: Duration.zero,
                          imageUrl: objDrawerList_1.images ?? "",
                          fit: BoxFit.fill,
                          errorWidget: (context, value, error) {
                            return Image.asset(
                              objDrawerList_1.images ?? "",
                              fit: BoxFit.fill,
                              height: 192.w,
                              width: 140.w,
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 14.w,bottom: 10.w),
                          child: Text(
                            objDrawerList_1.title!,
                            // textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteColor,
                                fontSize: 12.sp,
                                fontFamily: fontFamily),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
                : const SizedBox(),
            SizedBox(width: 12.h),
            index == 0
                ? Expanded(
              child: Wrap(
                direction: Axis.vertical,
                runAlignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  for (int i = 0; i < cntDrawer.arrNewDrawerList_1.length; i++)
                    i == 1 || i == 2 || i == 3
                        ? GestureDetector(
                      onTap: (){
                        cntDrawer.navigateScreen_1(i);
                      },
                      child: Padding(
                        padding:  EdgeInsets.only(bottom: i==2?14.w:0,top: i==2?14.w:0),
                        child: Container(
                          // height: 56.h,
                          width:134.w,
                          padding: EdgeInsets.symmetric(horizontal: 9.w,vertical: 8.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.08),
                                blurRadius: 6,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(
                                      left: 8,
                                      right: 8,
                                      top: 8,
                                      bottom: 8),
                                  decoration: BoxDecoration(
                                      color: cntDrawer.arrNewDrawerList_1[i]
                                          .backColor ??
                                          AppColors.whiteColor,
                                      borderRadius:
                                      BorderRadius.circular(6)),
                                  child:
                                  SvgPicture.asset(
                                    cntDrawer.arrNewDrawerList_1[i].images ?? "",
                                    height: 24.w,
                                    width: 24.h,
                                    color: AppColors.whiteColor,
                                  )),
                              SizedBox(width: 8.w),
                              SizedBox(
                                width: 68.w,
                                child: Text(
                                  cntDrawer.arrNewDrawerList_1[i].title ?? "",
                                  style: TextStyle(
                                      fontSize: 12.sp,fontFamily: fontFamily,fontWeight: FontWeight.w500, color: AppColors.newBlack),
                                  textAlign: TextAlign.left,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    )
                        : const SizedBox(),
                ],
              ),
            )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }


  Widget _newDrawerListData2(int index3) {
    DrawerModal objDrawerList_2 = cntDrawer.arrNewDrawerList_2[index3];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          index3 == 3
              ? Expanded(
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                for (int i = 0; i < cntDrawer.arrNewDrawerList_2.length; i++)
                  i == 0 || i == 1 || i == 2
                      ? GestureDetector(
                          onTap: (){
                            cntDrawer.navigateScreen_2(i);
                          },
                          child: Padding(
                            padding:  EdgeInsets.only(bottom: i==1?14.w:0,top: i==1?14.w:0),
                            child: Container(
                              width:134.w,
                              // margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.symmetric(horizontal: 9.w,vertical: 8.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withOpacity(0.08),
                                    spreadRadius: 0,
                                    blurRadius: 6,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 8,
                                          right: 8,
                                          top: 8,
                                          bottom: 8),
                                      decoration: BoxDecoration(
                                          color: cntDrawer.arrNewDrawerList_2[i]
                                              .backColor ??
                                              AppColors.whiteColor,
                                          borderRadius:
                                          BorderRadius.circular(6)),
                                      child:
                                      // objMyProperties.icon.toString().contains("svg")
                                      //     ?
                                      SvgPicture.asset(
                                        cntDrawer.arrNewDrawerList_2[i].images ?? "",
                                        height: 24.w,
                                        width: 24.h,
                                        color: AppColors.whiteColor,
                                      )),
                                  SizedBox(width: 8.w),
                                  SizedBox(
                                    width: 68.w,
                                    child: Text(
                                      cntDrawer.arrNewDrawerList_2[i].title ?? "",
                                      style: TextStyle(
                                          fontSize: 12.sp,fontFamily: fontFamily,fontWeight: FontWeight.w500, color: AppColors.newBlack),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
              ],
            ),
          )
              : const SizedBox(),

          SizedBox(width: 12.w),
          index3 == 3
              ? Expanded(
            child: GestureDetector(
              onTap: (){
                cntDrawer.navigateEarningScreen_1(index3);
              },
              child: Container(
                height: 192.w,
                width: 140.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        height: 192.w,
                        width: 140.w,
                        fadeInDuration: Duration.zero,
                        fadeOutDuration: Duration.zero,
                        placeholderFadeInDuration: Duration.zero,
                        imageUrl: objDrawerList_2.images ?? "",
                        fit: BoxFit.fill,
                        errorWidget: (context, value, error) {
                          return Image.asset(
                            objDrawerList_2.images ?? "",
                            height: 192.w,
                            width: 140.w,
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 14.w,bottom: 8.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Earnings",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.whiteColor,
                                  fontSize: 12.sp,
                                  fontFamily: fontFamily),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
              : const SizedBox(),
        ],
      ),
    );
  }


}
