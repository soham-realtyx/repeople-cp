import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/RegistrationController/registration_controller.dart';
import 'package:repeoplecp/Controller/rera_details_controller/rera_details_controller.dart';
import 'package:repeoplecp/Widget/CustomButton/custom_button.dart';
import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';
import 'package:repeoplecp/Widget/custom_boxDecoration.dart';

class ReRaDetailsPage extends StatefulWidget {
  const ReRaDetailsPage({super.key});

  @override
  State<ReRaDetailsPage> createState() => _ReRaDetailsPageState();
}

class _ReRaDetailsPageState extends State<ReRaDetailsPage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  ReRaDetailsController cntReRaDetails = Get.put(ReRaDetailsController());
  GlobalKey<ScaffoldState> globalRERADetailsPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    cntReRaDetails.getReRaDetailsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: globalRERADetailsPageKey,
      endDrawer: const CustomDrawer(
        animatedOffset: Offset(1.0, 0),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 84),
                  reRaDetailListData(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Obx(() =>  cntCommonHeader.commonAppBar(
                "RERA Details",
                globalRERADetailsPageKey,
                isMenuIconHide: true
            ))
          ],
        ),
      ),
    );
  }

  Widget reRaDetailListData(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: cntReRaDetails.arrReRaDetailsList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _generateReRaDetailData(index);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 8),
          child: addNewReRaButton(),
        )
      ],
    );
  }

  Widget _generateReRaDetailData(int index){
    ReRaCertificatesModel objReRaDetails = cntReRaDetails.arrReRaDetailsList[index];
    return Container(
      margin: const EdgeInsets.only(right: 20,bottom: 12,left: 20),
      padding:   EdgeInsets.only(bottom: objReRaDetails.isExpiryCertificates=="1"|| objReRaDetails.isWrongCompanyInfo=="1"?20:4,left: 8,right: 8,top: 20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            offset: const Offset(0, 3),
            spreadRadius: 0,
            blurRadius: 6
          ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for(int i=0;i<objReRaDetails.reRaDetailsList!.length;i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: reRaDetailsWidget(
                subTextColor: objReRaDetails.reRaDetailsList![i].isExpiryDate=="1"?AppColors.red:AppColors.appThemeColor,
                titleText: objReRaDetails.reRaDetailsList![i].title??"",
                subTitleText: objReRaDetails.reRaDetailsList![i].subTitle??"",
              ),
            ),
          objReRaDetails.isExpiryCertificates=="1"?expiryCertificatesButton(index):const SizedBox(),
          objReRaDetails.isWrongCompanyInfo=="1"?wrongCompanyInfoButton(index):const SizedBox()
        ],
      ),
    );
  }

  Widget expiryCertificatesButton(int index){
    ReRaCertificatesModel objReRaDetails = cntReRaDetails.arrReRaDetailsList[index];
    return onTapButton(
        onTap: () {
        },
        height: 26.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.offWhiteShadeYellowColor, 6, 0, AppColors.whiteColor),
        text: objReRaDetails.isExpiryCertificates=="1"?"Please Upload New RERA Certificate":"",
        style: TextStyle(
            color: AppColors.newBlack,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 8.sp));
  }

  Widget wrongCompanyInfoButton(int index){
    ReRaCertificatesModel objReRaDetails = cntReRaDetails.arrReRaDetailsList[index];
    return onTapButton(
        onTap: () {
        },
        height: 26.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.offWhiteShadeRedColor, 6, 0, AppColors.whiteColor),
        text: objReRaDetails.isWrongCompanyInfo=="1"?"Name doesn't match with Company Information":"",
        style: TextStyle(
            color: AppColors.newBlack,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 8.sp));
  }

  Widget addNewReRaButton(){
    return onTapButton(
        onTap: () {
        },
        height: 40.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.appThemeColor, 6, 0, AppColors.whiteColor),
        text: "Add another RERA Certificate".toUpperCase(),
        style: TextStyle(
            color: AppColors.whiteColor,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp));
  }

  Widget reRaDetailsWidget({String? titleText,String? subTitleText, Color? subTextColor}){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titleText??"",style: mediumTextStyle(txtColor:  AppColors.maiGreyColor,fontWeight: FontWeight.w400,fontSize: 12),),
          const SizedBox(height: 2),
          Text(subTitleText??"",style: boldTextStyle(fontSize: 14,fontWeight: FontWeight.w700,txtColor: subTextColor),),
        ]
    );
  }
}
