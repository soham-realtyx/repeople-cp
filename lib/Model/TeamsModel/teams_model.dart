import 'package:flutter/material.dart';

class TeamsModel{
  String? userImage;
  String? userName;
  String? mobileNo;
  String? userRole;
  String? invitationStatus;
  String? isStatus;
  TeamsModel({this.mobileNo,this.invitationStatus,this.isStatus,this.userImage,this.userName,this.userRole});
}

class TeamStatModel{
  String? totalCount;
  String? statsName;
  String? statsIcon;
  Color? statsIconColor;
  TeamStatModel({this.totalCount,this.statsIcon,this.statsName,this.statsIconColor});
}