import 'dart:convert';

import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> getRemoveAnyParticularNotification(String notificationId) async{
  SharedPreferences sp = await SharedPreferences.getInstance();
  var pendingNotificationList=sp.getString(notificationList).toString();
  if(pendingNotificationList != ""){
    var pendingNotifications =json.decode(pendingNotificationList);
    for(int i=0;i<pendingNotifications.length;i++){
      if(i.toString().trim()==notificationId.toString().trim()){
        pendingNotifications.remove(i);
      }
    }
    var setNotificationList=json.encode(pendingNotifications);
    await sp.setString(notificationList, setNotificationList);
  }

}