import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/PanDetailsController/pan_details_controller.dart';
import 'package:repeoplecp/View/PanDetailsPage/pan_details_form_page.dart';
import 'package:repeoplecp/Widget/CustomButton/custom_button.dart';
import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';
import 'package:repeoplecp/Widget/custom_boxDecoration.dart';

class PanDetailsPage extends StatefulWidget {
  const PanDetailsPage({super.key});

  @override
  State<PanDetailsPage> createState() => _PanDetailsPageState();
}

class _PanDetailsPageState extends State<PanDetailsPage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  PanDetailsController cntPanDetails = Get.put(PanDetailsController());
  GlobalKey<ScaffoldState> globalPanDetailsPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    cntPanDetails.getPanDetailsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: globalPanDetailsPageKey,
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
                  panDetailListData(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Obx(() => cntCommonHeader.commonAppBar(
                "PAN Details", globalPanDetailsPageKey,
                isMenuIconHide: true))
          ],
        ),
      ),
    );
  }

  Widget panDetailListData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: cntPanDetails.arrPanDetailsList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _generatePanDetailData(index);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
          child: addNewPanButton(),
        )
      ],
    );
  }

  Widget _generatePanDetailData(int index) {
    PanCertificatesModel objPanDetails = cntPanDetails.arrPanDetailsList[index];
    return Container(
      margin: const EdgeInsets.only(right: 20, bottom: 12, left: 20),
      padding: EdgeInsets.only(
          bottom: objPanDetails.isExpiryCertificates == "1" ||
                  objPanDetails.isWrongCompanyInfo == "1"
              ? 20
              : 4,
          left: 8,
          right: 8,
          top: 20),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AppColors.black.withOpacity(0.08),
                offset: const Offset(0, 3),
                spreadRadius: 0,
                blurRadius: 6),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < objPanDetails.panDetailsList!.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: panDetailsWidget(
                subTextColor:
                    objPanDetails.panDetailsList![i].isExpiryDate == "1"
                        ? AppColors.red
                        : AppColors.appThemeColor,
                titleText: objPanDetails.panDetailsList![i].title ?? "",
                subTitleText: objPanDetails.panDetailsList![i].subTitle ?? "",
              ),
            ),
          objPanDetails.isExpiryCertificates == "1"
              ? expiryCertificatesButton(index)
              : const SizedBox(),
          objPanDetails.isWrongCompanyInfo == "1"
              ? wrongCompanyInfoButton(index)
              : const SizedBox()
        ],
      ),
    );
  }

  Widget expiryCertificatesButton(int index) {
    PanCertificatesModel objPanDetails =
        cntPanDetails.arrPanDetailsList[index];
    return onTapButton(
        onTap: () {},
        height: 26.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.offWhiteShadeYellowColor, 6, 0, AppColors.whiteColor),
        text: objPanDetails.isExpiryCertificates == "1"
            ? "Please Upload New PAN Certificate"
            : "",
        style: TextStyle(
            color: AppColors.newBlack,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 8.sp));
  }

  Widget wrongCompanyInfoButton(int index) {
    PanCertificatesModel objPanDetails =
        cntPanDetails.arrPanDetailsList[index];
    return onTapButton(
        onTap: () {},
        height: 26.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.offWhiteShadeRedColor, 6, 0, AppColors.whiteColor),
        text: objPanDetails.isWrongCompanyInfo == "1"
            ? "Name doesn't match with Company Information"
            : "",
        style: TextStyle(
            color: AppColors.newBlack,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 8.sp));
  }

  Widget addNewPanButton() {
    return onTapButton(
        onTap: () {Get.to(()=>const PanFormDetailsPage());},
        height: 40.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.appThemeColor, 6, 0, AppColors.whiteColor),
        text: "Add another PAN Certificate".toUpperCase(),
        style: TextStyle(
            color: AppColors.whiteColor,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp));
  }

  Widget panDetailsWidget(
      {String? titleText, String? subTitleText, Color? subTextColor}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        titleText ?? "",
        style: mediumTextStyle(
            txtColor: AppColors.maiGreyColor,
            fontWeight: FontWeight.w400,
            fontSize: 12),
      ),
      const SizedBox(height: 2),
      Text(
        subTitleText ?? "",
        style: boldTextStyle(
            fontSize: 14, fontWeight: FontWeight.w700, txtColor: subTextColor),
      ),
    ]);
  }
}
