import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/EarningsController/earnings_controller.dart';
import 'package:repeoplecp/Model/EarningModel/earning_model.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/bottom_navigationbar_page.dart';
import 'package:repeoplecp/View/HomePage/home_page.dart';
import 'package:repeoplecp/View/ShareInvoicePage/share_invoice_page.dart';
import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';
import 'package:repeoplecp/Widget/horizontal_divider_widget.dart';
import 'package:timelines/timelines.dart';

class EarningsPage extends StatefulWidget {
  const EarningsPage({super.key});

  @override
  State<EarningsPage> createState() => _EarningsPageState();
}

class _EarningsPageState extends State<EarningsPage> {
  EarningsController cntEarning = Get.put(EarningsController());
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  GlobalKey<ScaffoldState> globalEarningPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    cntEarning.getEarningFilterListData();
    cntEarning.getEarningData();
    // check.value=globalEarningPageKey;
    BottomNavigationBarPage().selectedIndex = 2;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BottomNavigationBarPage().selectedIndex = 2;
        Get.offAll(const HomePage());
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.pageBackgroundColor,
        key: globalEarningPageKey,
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
                    SizedBox(height: 70.w),
                    lastUpdateWidget(
                        titleText: 'Last Update: ',
                        subText: "28 Jul, 2024 11:30 AM",
                      refreshIcon: refreshSvgIcons,
                      refreshOnTap: (){

                      }
                    ),
                    const SizedBox(height: 12),
                    totalCountData(),
                    const SizedBox(height: 12),
                    leadFilterListData(),
                    const SizedBox(height: 20),
                    earningListData(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              cntCommonHeader.commonAppBar(
                "Earning",
                globalEarningPageKey,
                  isMenuIconHide: true
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBarPage(selectedIndex: 2),
      ),
    );
  }

  Widget lastUpdateWidget(
      {String? titleText,
      String? subText,
      String? refreshIcon,
      GestureTapCallback? refreshOnTap}) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 12, top: 12),
      decoration: BoxDecoration(
        color: AppColors.lightYellowColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
                text: titleText,
                style: mediumTextStyle(
                    txtColor: AppColors.newBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
                children: [
                  TextSpan(
                      text: subText ?? "",
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      style: boldTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          txtColor: AppColors.newBlack))
                ]),
          ),
          GestureDetector(
            onTap: refreshOnTap,
            child: SvgPicture.asset(
              refreshIcon ?? "",
              height: 24,
              width: 24,
            ),
          )
        ],
      ),
    );
  }

  Widget totalCountWidget({String? title,String? totalCount,Color? textColor}){
    return Padding(
      padding: const EdgeInsets.only(right: 8,left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title??"",style: mediumTextStyle(txtColor: textColor??AppColors.newBlack,fontWeight: FontWeight.w500,fontSize: 14),),
          Text(totalCount??"",style: boldTextStyle(txtColor: textColor??AppColors.newBlack,fontWeight: FontWeight.w700,fontSize: 14),),
        ],
      ),
    );
  }

  Widget totalCountData(){
    return  Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(left: 20,right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
          color: AppColors.green.withOpacity(0.3)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          totalCountWidget(
              totalCount: "₹ 9,25,000",
              title: "Total Earning"
          ),
          SizedBox(height: 10.w),
          totalCountWidget(
              totalCount: "₹ 8,50,000",
              title: "Received"
          ),
          SizedBox(height: 10.w),
          totalCountWidget(
              totalCount: "₹ 75,000",
              title: "Due",
              textColor: AppColors.appThemeColor
          ),
        ],
      ),
    );
  }

  Widget leadFilterListData() {
    return SizedBox(
      height: 50.w,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 10),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: cntEarning.arrEarningFilterList.length,
        itemBuilder: (context, index) {
          return Obx(() => _generateFilterLeadsData(index));
        },
      ),
    );
  }

  Widget _generateFilterLeadsData(int index){
    EarningFilterModel objFilter = cntEarning.arrEarningFilterList[index];
    return GestureDetector(
      onTap: (){
        cntEarning.filterIndex.value=index;
      },
      child: Container(
        width: 85.w,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: cntEarning.filterIndex.value==index?AppColors.appThemeColor:AppColors.whiteColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.lightGreyColor,width: 1)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(objFilter.totalCount??"",style: boldTextStyle(fontSize: 16,fontWeight: FontWeight.w700,txtColor: cntEarning.filterIndex.value==index?AppColors.whiteColor:AppColors.newBlack),),
            Text(objFilter.title??"",style: mediumTextStyle(fontSize: 10,fontWeight: FontWeight.w500,txtColor: cntEarning.filterIndex.value==index?AppColors.whiteColor:AppColors.newBlack),)
          ],
        ),

      ),
    );
  }

  Widget earningListData(){
    return ListView.builder(
         shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: cntEarning.arrEarningList.length,
        itemBuilder: (context, index) {
          return Obx(() => _generateEarningList(index));
        },
    );
  }

  Widget _generateEarningList(int index){
    EarningModel objEarning = cntEarning.arrEarningList[index];
    return Container(
      padding:  const EdgeInsets.only(right: 20,bottom:20,top: 20,left: 20),
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
          Text(objEarning.name??"",style: boldTextStyle(txtColor: AppColors.newBlack,fontWeight: FontWeight.w700,fontSize: 14),),
          const SizedBox(height: 2),
          Text(objEarning.address ??"",style: mediumTextStyle(txtColor: AppColors.appThemeColor,fontWeight: FontWeight.w700,fontSize: 12),),
          Container(
            height: 50.w,
            width: Get.width,
            alignment: Alignment.topLeft,
              child: Timeline.tileBuilder(
              shrinkWrap: true,

              padding: EdgeInsets.zero,
              theme: TimelineThemeData(
                indicatorPosition: 0,
                direction: Axis.horizontal,
                connectorTheme: const ConnectorThemeData(
                    space: 9.0, thickness: 2.0),
              ),
              physics: const NeverScrollableScrollPhysics(),
              builder: TimelineTileBuilder.connected(
                connectionDirection: ConnectionDirection.before,
                itemCount: objEarning.earningCountList!.length,
                contentsAlign: ContentsAlign.basic,
                itemExtentBuilder: (_, __) {
                  return (MediaQuery.of(context).size.width-36)/5;
                },
                oppositeContentsBuilder: (context, index1) {
                  return Container();
                },
                contentsBuilder: (context, index2) {
                  return  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        objEarning.earningCountList![index2].earningText??"",
                        style: mediumTextStyle(fontSize: 8,fontWeight: FontWeight.w600,txtColor: objEarning.earningCountList![index2].isEarningCount=="1"?AppColors.green:AppColors.lightGreyColor),
                      ),
                    ),
                  );
                },
                indicatorBuilder: (_, index3) {
                  if (objEarning.earningCountList![index3].isEarningCount=="1") {
                    return const DotIndicator(
                      size: 14.0,
                      color: Colors.green,
                    );
                  } else {
                    return OutlinedDotIndicator(
                      borderWidth: 2.5,
                      color: AppColors.lightGreyColor,
                    );
                  }
                },
                connectorBuilder: (_, index4, type) {
                  if (index4 > 0) {
                    return SolidLineConnector(
                      thickness: 2.8,
                      color: objEarning.earningCountList![index4].isEarningCount=="1"
                          ? AppColors.green
                          : AppColors.lightGreyColor,
                    );
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          HorizontalDivider(color: AppColors.lightGreyColor, height: 1),
          const SizedBox(height: 20),
          if(objEarning.earningDateList!=null)
          for(int i=0;i<objEarning.earningDateList!.length;i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      objEarning.earningDateList![i].title??"",
                    style: mediumTextStyle(txtColor: AppColors.labelGreyColor,fontWeight: FontWeight.w600,fontSize: 12),
                  ),
                  Text(
                      objEarning.earningDateList![i].earningValue??"",
                    style: boldTextStyle(txtColor: AppColors.newBlack,fontWeight: FontWeight.w700,fontSize: 14),
                  ),
                ],
              ),
            ),
          if(objEarning.invoiceText!=null||objEarning.receiptText!=null)
          HorizontalDivider(color: AppColors.lightGreyColor, height: 1),
          if(objEarning.invoiceText!=null||objEarning.receiptText!=null)
          const SizedBox(height: 20),
        objEarning.invoiceText=="1"?GestureDetector(
            onTap: (){
              if(objEarning.invoiceText=="1"){
                Get.to(()=>ShareInvoicePage(objEarning: objEarning));
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(objEarning.invoiceText!=null)
                Text(
                  "Share Invoice".toUpperCase(),
                  // textAlign: TextAlign.center,
                  style: mediumTextStyle(txtColor: objEarning.isShareTextColor=="1"?AppColors.lightGreyColor:AppColors.appThemeColor,fontWeight: FontWeight.w600,fontSize: 12),
                ),

              ],
            ),
          ):const SizedBox(),
          objEarning.isInvoiceText=="1"?GestureDetector(
            onTap: (){
              // if(objEarning.invoiceText=="1"){
              //   Get.to(()=>ShareInvoicePage(objEarning: objEarning));
              // }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(objEarning.isInvoiceText!=null)
                  Text(
                    "View Invoice".toUpperCase(),
                    // textAlign: TextAlign.center,
                    style: mediumTextStyle(txtColor: AppColors.appThemeColor,fontWeight: FontWeight.w600,fontSize: 12),
                  ),

              ],
            ),
          ):const SizedBox(),
          objEarning.receiptText=="1"?GestureDetector(
            onTap: (){
              // if(objEarning.invoiceText=="1"){
              //   Get.to(()=>ShareInvoicePage(objEarning: objEarning));
              // }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(objEarning.isInvoiceText!=null)
                  Text(
                    "View Invoice".toUpperCase(),
                    // textAlign: TextAlign.center,
                    style: mediumTextStyle(txtColor: AppColors.appThemeColor,fontWeight: FontWeight.w600,fontSize: 12),
                  ),
                Text(
                    "Receipt".toUpperCase(),
                    // textAlign: TextAlign.center,
                    style: mediumTextStyle(txtColor: AppColors.appThemeColor,fontWeight: FontWeight.w600,fontSize: 12),
                  ),

              ],
            ),
          ):const SizedBox(),
          // const SizedBox(height: 20),
        ],
      ),
    );
  }

}
