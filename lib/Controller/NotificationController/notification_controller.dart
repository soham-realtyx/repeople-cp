import 'package:get/get.dart';

class NotificationController extends GetxController{

  RxList<NotificationModel> arrNotificationList = RxList([]);

  Future<RxList<NotificationModel>> getNotificationListData() async {
    arrNotificationList = RxList([]);
    arrNotificationList.add(NotificationModel(
        date:  "",
        userName: "Johane White",
        mobileNo: "+91 9876543210",
        invitationStatus: "1",
        isStatus: "",
        userRole: "Admin"));
    arrNotificationList.add(NotificationModel(
        date:  "",
        userName: "Winter White",
        mobileNo: "+91 9876543277",
        invitationStatus: "2",
        isStatus: "",
        userRole: "Associate"));
    arrNotificationList.add(NotificationModel(
        date:  "17 Jun, 2023",
        userName: "Congratulations 🎉",
        mobileNo: "",
        invitationStatus: "0",
        isStatus: "You are now empanelled with Prestige Group. Welcome to Prestige Partner App.",
        userRole: ""));
    return arrNotificationList;
  }

}

class NotificationModel{
  String? date;
  String? userName;
  String? mobileNo;
  String? userRole;
  String? invitationStatus;
  String? isStatus;
  NotificationModel({this.mobileNo,this.invitationStatus,this.isStatus,this.date,this.userName,this.userRole});
}