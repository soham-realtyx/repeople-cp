import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/NotificationController/notification_controller.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/bottom_navigationbar_page.dart';
import 'package:repeoplecp/Widget/horizontal_divider_widget.dart';


class NotificationPage extends StatefulWidget {
  final Offset? animatedOffset;
  const NotificationPage({super.key,this.animatedOffset});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  NotificationController cntNotification = Get.put(NotificationController());
  GlobalKey<ScaffoldState> globalNotificationPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    BottomNavigationBarPage().selectedIndex = 0;
    cntNotification.getNotificationListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: globalNotificationPageKey,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: notificationData(),
            ),
            Positioned(top: 0,child: drawerHeader(),)
          ],
        ),
      ),
    );
  }

  Widget notificationData() {
    return Align(
      alignment: Alignment.centerRight,
      child: Stack(
        children: [
          Container(
            // width: 320.w,
            width: Get.width,
            height: Get.height,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                const SizedBox(height: 120),
                notificationListData()
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget notificationListData(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cntNotification.arrNotificationList.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(right: 20,left: 20),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return _generateNotificationList(index);
      },
    );
  }

  Widget _generateNotificationList(int index){
    NotificationModel objNotification = cntNotification.arrNotificationList[index];
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightGreyColor,width: 1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(objNotification.userName??"",style: boldTextStyle(fontSize: 14,fontWeight: FontWeight.w700,txtColor: AppColors.newBlack),),
                  SizedBox(height:  objNotification.userName!="Congratulations 🎉"?2:0),
                  Text(objNotification.mobileNo??"",style: boldTextStyle(fontSize: 12,fontWeight: FontWeight.w500,txtColor: AppColors.newBlack),),
                  if(objNotification.isStatus!="")
                  SizedBox(width: 263,child: Text(objNotification.isStatus??"",style: boldTextStyle(fontSize: 10,fontWeight: FontWeight.w500,txtColor: AppColors.maiGreyColor),)),
                  SizedBox(height:  objNotification.userName!="Congratulations 🎉"?2:0),
                  Text(objNotification.userRole??"",style: boldTextStyle(fontSize: 10,fontWeight: FontWeight.w500,txtColor: AppColors.appThemeColor),),

                ],
              )
            ],
          ),
          SizedBox(height:  objNotification.userName!="Congratulations 🎉"?12:0),
          objNotification.userName!="Congratulations 🎉"?
          HorizontalDivider(color: AppColors.lightGreyColor, height: 1):const SizedBox(),
          SizedBox(height:  objNotification.userName!="Congratulations 🎉"?12:0),
          if(objNotification.invitationStatus=="1")
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
          if(objNotification.invitationStatus=="2")
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

  Widget drawerHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
      decoration: BoxDecoration(
          color: AppColors.appThemeColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
          )),
      height: 88.h,
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Notifications",
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 14.sp,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w700,
            ),
          ),
          closeIcon()
        ],
      ),
    );
  }
  Widget closeIcon() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
          height: 24,
          width: 24,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white.withOpacity(0.20),),
          child: SvgPicture.asset(
            closeSvgIcons,
            color: AppColors.whiteColor,
            fit: BoxFit.cover,
            height: 24,
            width: 24,
          )
      ),
    );
  }
}
