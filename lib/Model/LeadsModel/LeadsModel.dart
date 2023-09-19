import 'package:flutter/material.dart';

class LeadsModel {
  String? name;
  String? mobileNo;
  String? projectName;
  String? configure;
  String? price;
  String? address;
  String? date;
  String? time;
  String? leadsName;
  String? leadsIcon;
  MaterialColor? leadsTextColor;
  Color? leadsColor;

  LeadsModel(
      {this.name,
      this.mobileNo,
      this.projectName,
      this.address,
      this.date,
      this.time,
      this.configure,
      this.price,
      this.leadsIcon,
      this.leadsName,
      this.leadsTextColor,
      this.leadsColor});
}

class LeadsFilterModel{
  String? title;
  String? totalCount;
  LeadsFilterModel({this.title,this.totalCount});
}
