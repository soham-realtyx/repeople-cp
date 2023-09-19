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
    BottomNavigationBarPage().selectedIndex=1;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        BottomNavigationBarPage().selectedIndex=0;
        Get.offAll(const HomePage());
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        key: cntLeads.globalLeadsPageKey,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 90),
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
        bottomNavigationBar:  BottomNavigationBarPage(selectedIndex: 1),
      ),
    );
  }

  Widget leadListData(){
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 20,right: 20),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: cntLeads.arrLeadsList.length,
        itemBuilder: (context, index) {
          return Obx(() => _generateLeadsData(index));
        },
    );
  }

  Widget _generateLeadsData(int index){
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
            spreadRadius: 0
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            // width: 22,
            height: 194.w,
            decoration:  BoxDecoration(
              color: objLeads.leadsColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
            ),
            child:
                RotatedBox(
                  quarterTurns: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0,bottom: 5,right: 8,left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if(objLeads.leadsName=="Site Visit"||objLeads.leadsName=="EOI"||objLeads.leadsName=="Registration"||objLeads.leadsName=="Cancelled")
                          SvgPicture.asset(
                              objLeads.leadsIcon ?? "", width: 12.w,
                              height: 12.w,
                              color: objLeads.leadsTextColor),
                        if(objLeads.leadsName=="Site Visit"||objLeads.leadsName=="EOI"||objLeads.leadsName=="Registration"||objLeads.leadsName=="Cancelled")
                          Text(objLeads.leadsName ?? "", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                              color: objLeads.leadsTextColor)),
                        if(objLeads.leadsName=="Site Visit"||objLeads.leadsName=="EOI"||objLeads.leadsName=="Registration"||objLeads.leadsName=="Cancelled")
                          SvgPicture.asset(
                              objLeads.leadsIcon ?? "", width: 12.w,
                              height: 12.w,
                              color: objLeads.leadsTextColor),
                        if(objLeads.leadsName=="Site Visit"||objLeads.leadsName=="EOI"||objLeads.leadsName=="Registration"||objLeads.leadsName=="Cancelled")
                          Text(objLeads.leadsName ?? "", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                              color: objLeads.leadsTextColor)),

                        if(objLeads.leadsName=="Site Visit"||objLeads.leadsName=="EOI"||objLeads.leadsName=="Registration"||objLeads.leadsName=="Cancelled")
                          SvgPicture.asset(
                              objLeads.leadsIcon ?? "", width: 12.w,
                              height: 12.w,
                              color: objLeads.leadsTextColor),



                        if(objLeads.leadsName=="EOI")
                          Text(objLeads.leadsName ?? "", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                              color: objLeads.leadsTextColor)),

                        if(objLeads.leadsName=="EOI")
                          SvgPicture.asset(
                              objLeads.leadsIcon ?? "", width: 12.w,
                              height: 12.w,
                              color: objLeads.leadsTextColor),

                      ],
                    ),
                  ),
                ),

          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(objLeads.name??"",style: boldTextStyle(fontWeight: FontWeight.w700,fontSize: 14,txtColor: AppColors.newBlack),),
                const SizedBox(height: 2),
                Text(objLeads.mobileNo??"",style: mediumTextStyle(fontWeight: FontWeight.w500,fontSize: 12,txtColor: AppColors.newBlack),),
                const SizedBox(height: 6),
                HorizontalDivider(color: AppColors.lightGreyColor, height: 1),
                const SizedBox(height: 6),
                leadsDetailWidget(
                  icon: propertiesSvgIcon,
                  text: "WorldHome Superstar"
                ),
                const SizedBox(height: 6),
                leadsDetailWidget(
                    icon: layOutBoardSvgIcons,
                    text: "3 BHK"
                ),
                const SizedBox(height: 6),
                leadsDetailWidget(
                    icon: coinRupeeSvgIcons,
                    text: "1.25 - 1.5 Cr."
                ),
                const SizedBox(height: 6),
                leadsDetailWidget(
                    icon: mapPinSvgIcons,
                    text: "White Field, Bengaluru"
                ),
                const SizedBox(height: 6),
                Container(color: AppColors.black, height: 1),
                const SizedBox(height: 6),
                Text(objLeads.date??"",style: mediumTextStyle(fontWeight: FontWeight.w500,fontSize: 10,txtColor: AppColors.newBlack),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget leadsDetailWidget({String? icon,String? text}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(icon??"",height: 20,width: 20,color: AppColors.labelGreyColor,),
        const SizedBox(width: 4),
        Text(text??"",style: mediumTextStyle(txtColor: AppColors.labelGreyColor,fontSize: 12,fontWeight: FontWeight.w500),)
      ],
    );
  }

}
