import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/SizeConfig.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/CommenHeaderController.dart';
import 'package:repeoplecp/Controller/LeadsController/LeadsController.dart';
import 'package:repeoplecp/Model/LeadsModel/LeadsModel.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/BottomNavigationBarPage.dart';
import 'package:repeoplecp/View/HomePage/HomePage.dart';
import 'package:repeoplecp/Widget/CustomAppBar/CustomAppBar.dart';
import 'package:repeoplecp/Widget/CustomDrawer/CustomDrawer.dart';
import 'package:repeoplecp/Widget/HorizontalDividerWidget.dart';

class LeadsPage extends StatefulWidget {
  const LeadsPage({super.key});

  @override
  State<LeadsPage> createState() => _LeadsPageState();
}

class _LeadsPageState extends State<LeadsPage> {
  LeadsController cntLeads = Get.put(LeadsController());
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  @override
  void initState() {
    super.initState();
    cntLeads.getLeadsListData();
    cntLeads.getLeadsFilterListData();
    cntLeads.filterIndex.value=0;
    cntLeads.filterIndex.value=cntLeads.arrLeadFilterList.length;
    check.value=cntLeads.globalLeadsPageKey;
    BottomNavigationBarPage().selectedIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BottomNavigationBarPage().selectedIndex = 0;
        Get.offAll(const HomePage());
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        key: cntLeads.globalLeadsPageKey,
        endDrawer: CustomDrawer(
          animatedOffset: const Offset(1.0, 0),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment:  CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 85),
                    leadFilterListData(),
                    const SizedBox(height: 20),
                    leadListData(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
              const DashBoardHeader()
              // cntCommonHeader.commonAppBar(
              //     "Leads", cntLeads.globalLeadsPageKey,
              // )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBarPage(selectedIndex: 1),
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
        itemCount: cntLeads.arrLeadsList.length,
        itemBuilder: (context, index) {
          return Obx(() => _generateFilterLeadsData(index));
        },
      ),
    );
  }

  Widget _generateFilterLeadsData(int index){
    LeadsFilterModel objFilter = cntLeads.arrLeadFilterList[index];
    return GestureDetector(
      onTap: (){
        cntLeads.filterIndex.value=index;
      },
      child: Container(
        width: 85.w,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: cntLeads.filterIndex.value==index?AppColors.appThemeColor:AppColors.whiteColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.lightGreyColor,width: 1)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(objFilter.totalCount??"",style: boldTextStyle(fontSize: 16,fontWeight: FontWeight.w700,txtColor: cntLeads.filterIndex.value==index?AppColors.whiteColor:AppColors.newBlack),),
            Text(objFilter.title??"",style: mediumTextStyle(fontSize: 10,fontWeight: FontWeight.w500,txtColor: cntLeads.filterIndex.value==index?AppColors.whiteColor:AppColors.newBlack),)
          ],
        ),

      ),
    );
  }

  Widget leadListData() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 20, right: 20),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: cntLeads.arrLeadFilterList.length,
      itemBuilder: (context, index) {
        return Obx(() => _generateLeadsData(index));
      },
    );
  }

  Widget _generateLeadsData(int index) {
    LeadsModel objLeads = cntLeads.arrLeadsList[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
              color: AppColors.black.withOpacity(0.1),
              offset: const Offset(0, 3),
              blurRadius: 6,
              spreadRadius: 0),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 194.w,
            decoration: BoxDecoration(
                color: objLeads.leadsColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Padding(
              padding:  EdgeInsets.only(
                  top: 9.w, bottom: 9.w, right: 5.w, left: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (objLeads.leadsName == "Site Visit" ||
                      objLeads.leadsName == "EOI" ||
                      objLeads.leadsName == "Registration" ||
                      objLeads.leadsName == "Cancelled")
                    SvgPicture.asset(objLeads.leadsIcon ?? "",
                        width: 12.w,
                        height: 12.w,
                        color: objLeads.leadsTextColor),
                  if (objLeads.leadsName == "Site Visit" ||
                      objLeads.leadsName == "EOI" ||
                      objLeads.leadsName == "Registration" ||
                      objLeads.leadsName == "Cancelled")
                    RotatedBox(
                      quarterTurns: 1,
                      child: Text(objLeads.leadsName ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 9.sp,
                              color: objLeads.leadsTextColor)),
                    ),
                  if (objLeads.leadsName == "Site Visit" ||
                      objLeads.leadsName == "EOI" ||
                      objLeads.leadsName == "Registration" ||
                      objLeads.leadsName == "Cancelled")
                    SvgPicture.asset(objLeads.leadsIcon ?? "",
                        width: 12.w,
                        height: 12.w,
                        color: objLeads.leadsTextColor),
                  if (objLeads.leadsName == "Site Visit" ||
                      objLeads.leadsName == "EOI" ||
                      objLeads.leadsName == "Registration" ||
                      objLeads.leadsName == "Cancelled")
                    RotatedBox(
                      quarterTurns: 1,
                      child: Text(objLeads.leadsName ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 9.sp,
                              color: objLeads.leadsTextColor)),
                    ),
                  if (objLeads.leadsName == "Site Visit" ||
                      objLeads.leadsName == "EOI" ||
                      objLeads.leadsName == "Registration" ||
                      objLeads.leadsName == "Cancelled")
                    SvgPicture.asset(objLeads.leadsIcon ?? "",
                        width: 12.w,
                        height: 12.w,
                        color: objLeads.leadsTextColor),
                  if (objLeads.leadsName == "EOI")
                    RotatedBox(
                      quarterTurns: 1,
                      child: Text(objLeads.leadsName ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 9.sp,
                              color: objLeads.leadsTextColor)),
                    ),
                  if (objLeads.leadsName == "EOI")
                    SvgPicture.asset(objLeads.leadsIcon ?? "",
                        width: 12.w,
                        height: 12.w,
                        color: objLeads.leadsTextColor),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  objLeads.name ?? "",
                  style: boldTextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      txtColor: AppColors.newBlack),
                ),
                SizedBox(height: 2.w),
                Text(
                  objLeads.mobileNo ?? "",
                  style: mediumTextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      txtColor: AppColors.newBlack),
                ),
                 SizedBox(height: 6.w),
                HorizontalDivider(color: AppColors.lightGreyColor, height: 1),
                SizedBox(height: 6.w),
                leadsDetailWidget(
                    icon: propertiesSvgIcon, text: "WorldHome Superstar"),
                SizedBox(height: 6.w),
                leadsDetailWidget(icon: layOutBoardSvgIcons, text: "3 BHK"),
                SizedBox(height: 6.w),
                leadsDetailWidget(
                    icon: coinRupeeSvgIcons, text: "1.25 - 1.5 Cr."),
                SizedBox(height: 6.w),
                leadsDetailWidget(
                    icon: mapPinSvgIcons, text: "White Field, Bengaluru"),
                SizedBox(height: 6.w),
                Container(color: AppColors.black, height: 1),
                SizedBox(height: 6.w),
                Text(
                  objLeads.date ?? "",
                  style: mediumTextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      txtColor: AppColors.newBlack),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget leadsDetailWidget({String? icon, String? text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          icon ?? "",
          height: 20,
          width: 20,
          color: AppColors.labelGreyColor,
        ),
        const SizedBox(width: 4),
        Text(
          text ?? "",
          style: mediumTextStyle(
              txtColor: AppColors.labelGreyColor,
              fontSize: 12,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
