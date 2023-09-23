import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/BankDetailController/bank_details_controller.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/View/BankDetailsPage/bank_form_details_page.dart';
import 'package:repeoplecp/Widget/CustomButton/custom_button.dart';
import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';
import 'package:repeoplecp/Widget/custom_boxDecoration.dart';

class BankDetailsPage extends StatefulWidget {
  const BankDetailsPage({super.key});

  @override
  State<BankDetailsPage> createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  BankDetailsController cntBankDetails = Get.put(BankDetailsController());
  GlobalKey<ScaffoldState> globalBankDetailsPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    cntBankDetails.getBankDetailsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: globalBankDetailsPageKey,
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
                  bankDetailListData(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Obx(() => cntCommonHeader.commonAppBar(
                "Bank Details", globalBankDetailsPageKey,
                isMenuIconHide: true))
          ],
        ),
      ),
    );
  }

  Widget bankDetailListData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: cntBankDetails.arrBankDetailsList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _generateBankDetailData(index);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
          child: addNewBankButton(),
        )
      ],
    );
  }

  Widget _generateBankDetailData(int index) {
    BankCertificatesModel objBankDetails = cntBankDetails.arrBankDetailsList[index];
    return Container(
      margin: const EdgeInsets.only(right: 20, bottom: 12, left: 20),
      padding: EdgeInsets.only(
          bottom: objBankDetails.isExpiryCertificates == "1" ||
              objBankDetails.isWrongCompanyInfo == "1"
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
          for (int i = 0; i < objBankDetails.bankDetailsList!.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: bankDetailsWidget(
                subTextColor:
                objBankDetails.bankDetailsList![i].isExpiryDate == "1"
                    ? AppColors.red
                    : AppColors.appThemeColor,
                titleText: objBankDetails.bankDetailsList![i].title ?? "",
                subTitleText: objBankDetails.bankDetailsList![i].subTitle ?? "",
              ),
            ),
          objBankDetails.isExpiryCertificates == "1"
              ? expiryCertificatesButton(index)
              : const SizedBox(),
          objBankDetails.isWrongCompanyInfo == "1"
              ? wrongCompanyInfoButton(index)
              : const SizedBox()
        ],
      ),
    );
  }

  Widget expiryCertificatesButton(int index) {
    BankCertificatesModel objBankDetails =
    cntBankDetails.arrBankDetailsList[index];
    return onTapButton(
        onTap: () {},
        height: 26.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.offWhiteShadeYellowColor, 6, 0, AppColors.whiteColor),
        text: objBankDetails.isExpiryCertificates == "1"
            ? "Please Upload New Bank Certificate"
            : "",
        style: TextStyle(
            color: AppColors.newBlack,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 8.sp));
  }

  Widget wrongCompanyInfoButton(int index) {
    BankCertificatesModel objBankDetails =
    cntBankDetails.arrBankDetailsList[index];
    return onTapButton(
        onTap: () {},
        height: 26.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.offWhiteShadeRedColor, 6, 0, AppColors.whiteColor),
        text: objBankDetails.isWrongCompanyInfo == "1"
            ? "Name doesn't match with Company Information"
            : "",
        style: TextStyle(
            color: AppColors.newBlack,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 8.sp));
  }

  Widget addNewBankButton() {
    return onTapButton(
        onTap: () {
          Get.to(()=>const BankFormDetailsPage());
        },
        height: 40.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.appThemeColor, 6, 0, AppColors.whiteColor),
        text: "Add another Bank Certificate".toUpperCase(),
        style: TextStyle(
            color: AppColors.whiteColor,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp));
  }

  Widget bankDetailsWidget(
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
