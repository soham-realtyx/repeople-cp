import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/TeamController/team_controller.dart';
import 'package:repeoplecp/Model/TeamsModel/teams_model.dart';
import 'package:repeoplecp/View/AddTeamsPage/add_teams_page.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/bottom_navigationBar_page.dart';
import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';
import 'package:repeoplecp/Widget/horizontal_divider_widget.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  TeamController cntTeam = Get.put(TeamController());
  GlobalKey<ScaffoldState> globalTeamPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    BottomNavigationBarPage().selectedIndex = 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: globalTeamPageKey,
      endDrawer: CustomDrawer(
        animatedOffset: const Offset(1.0, 0),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 90),
                  teamsStatsDetailsData(),
                  const SizedBox(height: 20),
                  teamDetailListData(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            cntCommonHeader.commonAppBar("Team", globalTeamPageKey,
                isMenuIconHide: true),
          ],
        ),
      ),
    );
  }

  Widget teamsStatsDetailsData() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            spreadRadius: 0,
            offset: const Offset(0, 3),
            blurRadius: 6
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Stats",
                style: boldTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    txtColor: AppColors.appThemeColor),
              ),
              Row(
                children: [
                  Text(
                    "All",
                    style: boldTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        txtColor: AppColors.newBlack),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(dropDownSvgIcons)
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          statsDetailsListData()
        ],
      ),
    );
  }

  Widget statsDetailsListData() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cntTeam.arrStatsList.length,
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            childAspectRatio: 2.2,
            crossAxisSpacing: 12
          ),
      itemBuilder: (context, index) {
        return _generateStatsDetailsListData(index);
      },
    );
  }

  Widget _generateStatsDetailsListData(int index){
    TeamStatModel objStats = cntTeam.arrStatsList[index];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.whiteColor,
        border: Border.all(color: AppColors.lightGreyColor,width: 1)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(objStats.totalCount??"",style: boldTextStyle(txtColor: AppColors.newBlack,fontWeight: FontWeight.w700,fontSize: 16),),
              const SizedBox(height: 5),
              Text(objStats.statsName??"",style: boldTextStyle(txtColor: AppColors.newBlack,fontWeight: FontWeight.w500,fontSize: 10),)
            ],
          ),
          SvgPicture.asset(objStats.statsIcon??"",width: 28,height: 28,color: objStats.statsIconColor,)
        ],
      ),
    );
  }

  Widget teamDetailListData(){
    return Container(
      padding: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 8),
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AppColors.black.withOpacity(0.08),
                spreadRadius: 0,
                offset: const Offset(0, 3),
                blurRadius: 6
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Team",
                style: boldTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    txtColor: AppColors.appThemeColor),
              ),
              GestureDetector(
                onTap: (){
                  Get.to(()=>const AddTeamsPage());
                },
                child: Row(
                  children: [
                    Text(
                      "ADD",
                      style: boldTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          txtColor: AppColors.newBlack),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(plusSvgIcons)
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          ListView.builder(

            itemBuilder: (context, index) {
              return _generateTeamListData(index);
            },
            shrinkWrap: true,
            itemCount: cntTeam.arrTeamsList.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
          ),
        ],
      ),
    );
  }

  Widget _generateTeamListData(int index){
    TeamsModel objTeam = cntTeam.arrTeamsList[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.whiteColor,
        border: Border.all(color: AppColors.lightGreyColor,width: 1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if(objTeam.userImage!="")
              Container(
                  height: 48.w,width: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.pageBackgroundColor,
                  border: Border.all(color: AppColors.pageBackgroundColor,width: 2),
                  borderRadius: BorderRadius.circular(10)
                ),
                  child: Image.asset(objTeam.userImage??"",height: 48.w,width: 48.w,fit: BoxFit.cover,)
              ),
              if(objTeam.userImage!="")
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(objTeam.userName??"",style: boldTextStyle(fontSize: 14,fontWeight: FontWeight.w700,txtColor: AppColors.newBlack),),
                  const SizedBox(height: 2),
                  Text(objTeam.mobileNo??"",style: boldTextStyle(fontSize: 12,fontWeight: FontWeight.w500,txtColor: AppColors.newBlack),),
                  const SizedBox(height: 2),
                  Text(objTeam.userRole??"",style: boldTextStyle(fontSize: 10,fontWeight: FontWeight.w500,txtColor: AppColors.appThemeColor),),

                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          HorizontalDivider(color: AppColors.lightGreyColor, height: 1),
          const SizedBox(height: 12),
          if(objTeam.invitationStatus=="1")
          Text("Invitation accepted on 02/06/2023",style: mediumTextStyle(fontSize: 10,fontWeight: FontWeight.w500,txtColor: AppColors.newBlack),),
          if(objTeam.invitationStatus=="2")
            Text("Invitation valid upto 23 Hrs 59 Min 11 Sec",style: mediumTextStyle(fontSize: 10,fontWeight: FontWeight.w500,txtColor: AppColors.newBlack),),
          if(objTeam.invitationStatus=="3")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Invitation expired",style: mediumTextStyle(fontSize: 10,fontWeight: FontWeight.w500,txtColor: AppColors.newBlack),),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: hex("FF8E00")
                  ),
                  child: Center(
                    child: Text("Reinvite".toUpperCase(),style: semiBoldTextStyle(fontSize: 10,fontWeight: FontWeight.w600,txtColor: AppColors.whiteColor),),
                  ),
                )
              ],
            ),
          if(objTeam.invitationStatus=="4")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Requested to join",style: mediumTextStyle(fontSize: 10,fontWeight: FontWeight.w500,txtColor: AppColors.newBlack),),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: hex("027F3A")
                      ),
                      child: Center(
                        child: Text("Accept".toUpperCase(),style: semiBoldTextStyle(fontSize: 10,fontWeight: FontWeight.w600,txtColor: AppColors.whiteColor),),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: hex("E17055")
                      ),
                      child: Center(
                        child: Text("Reject".toUpperCase(),style: semiBoldTextStyle(fontSize: 10,fontWeight: FontWeight.w600,txtColor: AppColors.whiteColor),),
                      ),
                    ),
                  ],
                )
              ],
            ),
        ],
      ),
    );
  }
}
