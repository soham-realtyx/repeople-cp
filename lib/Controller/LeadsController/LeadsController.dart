import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Model/LeadsModel/LeadsModel.dart';

class LeadsController extends GetxController{

  GlobalKey<ScaffoldState> globalLeadsPageKey = GlobalKey<ScaffoldState>();

  RxList<LeadsModel> arrLeadsList = RxList([]);
  RxList<LeadsFilterModel> arrLeadFilterList = RxList([]);

  Future<RxList<LeadsModel>> getLeadsListData()async{
    arrLeadsList = RxList([]);
    arrLeadsList.add(LeadsModel(
      address: "White Field, Bengaluru",
      name: "Alice Doe",
      time: "",
      date: "Wed, Mar 15, 2023  11:00 AM",
      configure: "3 BHK",
      mobileNo: "+91 9876543210",
      price: "1.25 - 1.5 Cr.",
      projectName: "WorldHome Superstar",
      leadsName: "Site Visit",
      leadsIcon: mapPinSvgIcons,
      leadsColor: AppColors.lightCynColor,
      leadsTextColor: hex("00A5A1")
    ));
    arrLeadsList.add(LeadsModel(
        address: "White Field, Bengaluru",
        name: "Alice Doe",
        time: "",
        date: "Wed, Mar 15, 2023  11:00 AM",
        configure: "3 BHK",
        mobileNo: "+91 9876543210",
        price: "1.25 - 1.5 Cr.",
        projectName: "WorldHome Superstar",
        leadsName: "EOI",
        leadsIcon: creditCardSvgIcons,
      leadsColor: AppColors.paleGreenColor,
        leadsTextColor: hex("597C2D")
    ));
    arrLeadsList.add(LeadsModel(
        address: "White Field, Bengaluru",
        name: "Alice Doe",
        time: "",
        date: "Wed, Mar 15, 2023  11:00 AM",
        configure: "3 BHK",
        mobileNo: "+91 9876543210",
        price: "1.25 - 1.5 Cr.",
        projectName: "WorldHome Superstar",
        leadsName: "Registration",
        leadsIcon: homeHeartSvgIcons,
        leadsColor: AppColors.brightGreenColor,
        leadsTextColor: hex("D9F3E3")
    ));
    arrLeadsList.add(LeadsModel(
        address: "White Field, Bengaluru",
        name: "Alice Doe",
        time: "",
        date: "Wed, Mar 15, 2023  11:00 AM",
        configure: "3 BHK",
        mobileNo: "+91 9876543210",
        price: "1.25 - 1.5 Cr.",
        projectName: "WorldHome Superstar",
        leadsName: "Cancelled",
        leadsIcon: homeCancelSvgIcons,
        leadsColor: AppColors.pinkRedColor,
        leadsTextColor: hex("A50000")
    ));
    return arrLeadsList;
  }


}