
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/images.dart';

class MyAccountController extends GetxController{
  RxString userImage = "".obs;
  RxBool isWhatsAppEnable = false.obs;


  @override
  void onInit() {
    super.onInit();
    getLoginDetailData();
  }

  RxList<LoginDetailsModel> arrLoginDetailsList = RxList([]);

  Future<RxList<LoginDetailsModel>> getLoginDetailData()async{
    arrLoginDetailsList=RxList([]);
    arrLoginDetailsList.add(LoginDetailsModel(icon: reportSvgIcons,name: "RERA Details", count: "3",onTap: (){}));
    arrLoginDetailsList.add(LoginDetailsModel(icon: reportSvgIcons,name: "PAN Details", count: "",onTap: (){}));
    arrLoginDetailsList.add(LoginDetailsModel(icon: reportSvgIcons,name: "GST Details", count: "3",onTap: (){}));
    arrLoginDetailsList.add(LoginDetailsModel(icon: buildingBankSvgIcons,name: "Bank Account Details", count: "3",onTap: (){}));
    arrLoginDetailsList.add(LoginDetailsModel(icon: reportSvgIcons,name: "Contact Details", count: "",onTap: (){}));
    arrLoginDetailsList.add(LoginDetailsModel(icon: reportSvgIcons,name: "Marketing Information", count: "",onTap: (){}));
    arrLoginDetailsList.add(LoginDetailsModel(icon: logOutSvgIcons,name: "Logout", count: "",onTap: (){}));
    return arrLoginDetailsList;
  }

}

class LoginDetailsModel{
  String? icon;
  String? name;
  String? count;
  GestureTapCallback? onTap;
  LoginDetailsModel({this.count,this.name,this.icon,this.onTap});
}