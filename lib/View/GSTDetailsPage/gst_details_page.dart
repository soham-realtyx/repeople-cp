import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/GSTDetailsController/gst_details_controller.dart';
import 'package:repeoplecp/View/GSTDetailsPage/gst_details_form_page.dart';
import 'package:repeoplecp/Widget/CustomButton/custom_button.dart';
import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';
import 'package:repeoplecp/Widget/custom_boxDecoration.dart';

class GSTDetailsPage extends StatefulWidget {
  const GSTDetailsPage({super.key});

  @override
  State<GSTDetailsPage> createState() => _GSTDetailsPageState();
}

class _GSTDetailsPageState extends State<GSTDetailsPage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  GSTDetailsController cntGSTDetails = Get.put(GSTDetailsController());
  GlobalKey<ScaffoldState> globalGSTDetailsPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    cntGSTDetails.getGSTDetailsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: globalGSTDetailsPageKey,
      endDrawer: const CustomDrawer(
        animatedOffset: Offset(1.0, 0),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 85.w),
                  gstDetailListData(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Obx(() => cntCommonHeader.commonAppBar(
                "GST Details", globalGSTDetailsPageKey,
                isMenuIconHide: true))
          ],
        ),
      ),
    );
  }

  Widget gstDetailListData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: cntGSTDetails.arrGSTDetailsList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _generateGSTDetailData(index);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
          child: addNewGSTButton(),
        )
      ],
    );
  }

  Widget _generateGSTDetailData(int index) {
    GSTCertificatesModel objGSTDetails = cntGSTDetails.arrGSTDetailsList[index];
    return Container(
      margin: const EdgeInsets.only(right: 20, bottom: 12, left: 20),
      padding: EdgeInsets.only(
          bottom: objGSTDetails.isExpiryCertificates == "1" ||
              objGSTDetails.isWrongCompanyInfo == "1"
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
          for (int i = 0; i < objGSTDetails.gstDetailsList!.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: gstDetailsWidget(
                subTextColor:
                objGSTDetails.gstDetailsList![i].isExpiryDate == "1"
                    ? AppColors.red
                    : AppColors.appThemeColor,
                titleText: objGSTDetails.gstDetailsList![i].title ?? "",
                subTitleText: objGSTDetails.gstDetailsList![i].subTitle ?? "",
              ),
            ),
          objGSTDetails.isExpiryCertificates == "1"
              ? expiryCertificatesButton(index)
              : const SizedBox(),
          objGSTDetails.isWrongCompanyInfo == "1"
              ? wrongCompanyInfoButton(index)
              : const SizedBox()
        ],
      ),
    );
  }

  Widget expiryCertificatesButton(int index) {
    GSTCertificatesModel objGSTDetails =
    cntGSTDetails.arrGSTDetailsList[index];
    return onTapButton(
        onTap: () {},
        height: 26.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.offWhiteShadeYellowColor, 6, 0, AppColors.whiteColor),
        text: objGSTDetails.isExpiryCertificates == "1"
            ? "Please Upload New GST Certificate"
            : "",
        style: TextStyle(
            color: AppColors.newBlack,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 8.sp));
  }

  Widget wrongCompanyInfoButton(int index) {
    GSTCertificatesModel objGSTDetails =
    cntGSTDetails.arrGSTDetailsList[index];
    return onTapButton(
        onTap: () {},
        height: 26.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.offWhiteShadeRedColor, 6, 0, AppColors.whiteColor),
        text: objGSTDetails.isWrongCompanyInfo == "1"
            ? "Name doesn't match with Company Information"
            : "",
        style: TextStyle(
            color: AppColors.newBlack,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 8.sp));
  }

  Widget addNewGSTButton() {
    return onTapButton(
        onTap: () {
          Get.to(()=>const GSTFormDetailsPage());
        },
        height: 40.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.appThemeColor, 6, 0, AppColors.whiteColor),
        text: "Add another GST Certificate".toUpperCase(),
        style: TextStyle(
            color: AppColors.whiteColor,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp));
  }

  Widget gstDetailsWidget(
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
