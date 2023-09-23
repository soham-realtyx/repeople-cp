

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/EarningsController/earnings_controller.dart';
import 'package:repeoplecp/Model/EarngingModel/earning_model.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/bottom_navigationBar_page.dart';
import 'package:repeoplecp/Widget/custom_boxDecoration.dart';
import 'package:repeoplecp/Widget/CustomButton/custom_button.dart';
import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';
import 'package:repeoplecp/Widget/horizontal_divider_widget.dart';

class ShareInvoicePage extends StatefulWidget {
   EarningModel objEarning = EarningModel();
   ShareInvoicePage({super.key,required this.objEarning});

  @override
  State<ShareInvoicePage> createState() => _ShareInvoicePageState();
}

class _ShareInvoicePageState extends State<ShareInvoicePage> {
  EarningsController cntEarning = Get.put(EarningsController());
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  GlobalKey<ScaffoldState> globalShareInvoicePageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: globalShareInvoicePageKey,
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
                  shareInvoiceData(),

                  const SizedBox(height: 10),
                ],
              ),
            ),
            cntCommonHeader.commonAppBar(
                "Share Invoice",
                globalShareInvoicePageKey,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarPage(selectedIndex: 2),
    );
  }

  Widget shareInvoiceData(){
    return Container(

      margin: const EdgeInsets.only(right: 20,bottom: 20,left: 20),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AppColors.black.withOpacity(0.08),
                spreadRadius: 0,
                blurRadius: 6,
                offset: const Offset(0, 3)
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          earningShareInvoiceDetails(),
          const SizedBox(height: 20),
          editInvoiceImageData(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 8.0,left: 8),
            child: submitButton(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget earningShareInvoiceDetails(){
    return Padding(
      padding: const EdgeInsets.only(right: 20,bottom:0,top: 20,left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.objEarning.name??"",style: boldTextStyle(txtColor: AppColors.newBlack,fontWeight: FontWeight.w700,fontSize: 14),),
          const SizedBox(height: 2),
          Text(widget.objEarning.address ??"",style: mediumTextStyle(txtColor: AppColors.appThemeColor,fontWeight: FontWeight.w700,fontSize: 12),),
          const SizedBox(height: 20),
          HorizontalDivider(color: AppColors.lightGreyColor, height: 1),
          const SizedBox(height: 20),
          if(widget.objEarning.earningDateList!=null)
            for(int i=0;i<widget.objEarning.earningDateList!.length;i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.objEarning.earningDateList![i].title??"",
                      style: mediumTextStyle(txtColor: AppColors.labelGreyColor,fontWeight: FontWeight.w600,fontSize: 12),
                    ),
                    Text(
                      widget.objEarning.earningDateList![i].earningValue??"",
                      style: boldTextStyle(txtColor: AppColors.newBlack,fontWeight: FontWeight.w700,fontSize: 14),
                    ),
                  ],
                ),
              ),
          HorizontalDivider(color: AppColors.lightGreyColor, height: 1),
        ],
      ),
    );
  }

  Widget editInvoiceImageData() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Invoice",
            style: TextStyle(
                fontSize: 10.sp,
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
              Obx(() => cntEarning.invoiceImage.value != ""
                  ? Obx(() => Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: Get.width-53.w,
                    height: 174.w,
                    // padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 138),
                    decoration: BoxDecoration(
                      color: AppColors.appThemeColor.withOpacity(0.2),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: cntEarning.invoiceImage.value != ""
                        ? Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.file(
                        File(cntEarning.invoiceImage.value),
                        fit: BoxFit.cover,
                      ),
                    )
                        : Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Image(
                            image: NetworkImage(cntEarning.invoiceImage.value),
                            fit: BoxFit.cover)),
                  ),
                  Obx(() => cntEarning.invoiceImage.value == ""
                      ? const SizedBox()
                      : GestureDetector(
                    onTap: () {
                      cntEarning.invoiceImagePicker();
                    },
                    child: Container(
                      width: Get.width-52.w,
                      height: 174.w,
                      // padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 138),
                      decoration: BoxDecoration(
                        color: AppColors.appThemeColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "CHANGE",
                          style: mediumTextStyle(
                              txtColor: AppColors.whiteColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  )
                ],
              ))
                  : GestureDetector(
                onTap: () {
                  cntEarning.invoiceImagePicker();
                },
                child: Container(
                  width: Get.width-52.w,
                  height: 174.w,
                  // padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 138),
                  decoration: BoxDecoration(
                    color: AppColors.appThemeColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      "+ADD",
                      style: TextStyle(
                          color: AppColors.appThemeColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: fontFamily),
                    ),
                  ),
                ),
              )),
            ],
          ),
          SizedBox(
            height: 8.w,
          ),
          HorizontalDivider(color: AppColors.labelGreyColor, height: 1),

        ],
      ),
    );
  }

  Widget submitButton() {
    return onTapButton(
        onTap: () {},
        height: 40.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.appThemeColor, 6, 0, AppColors.whiteColor),
        text: "Share Invoice".toUpperCase(),
        style: TextStyle(
            color: AppColors.whiteColor,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp));
  }

}
