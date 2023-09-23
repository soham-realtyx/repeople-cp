import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Model/TeamsModel/teams_model.dart';
import 'package:repeoplecp/Widget/select_dailog.dart';

class TeamController extends GetxController {
  RxList<TeamsModel> arrTeamsList = RxList([]);
  RxList<TeamStatModel> arrStatsList = RxList([]);

  @override
  void onInit() {
    super.onInit();
    getStatsListData();
    getTeamsListData();
  }

  var formKey = GlobalKey<FormState>();

  Rxn<TextEditingController> txtFirstName = Rxn(TextEditingController());
  Rxn<TextEditingController> txtLastName = Rxn(TextEditingController());
  Rxn<TextEditingController> txtContactNew = Rxn(TextEditingController());
  Rxn<TextEditingController> txtEmail = Rxn(TextEditingController());
  TextEditingController txtUserRole = TextEditingController();

  Rx<RoleModel> objRoleType = RoleModel().obs;
  RxList<RoleModel> arrRoleList = RxList([]);

  clearFormData(){
    txtFirstName.value?.text='';
    txtLastName.value?.text='';
    txtContactNew.value?.text='';
    txtEmail.value?.text='';
    txtUserRole.text='';
  }

  roleTypeData(){
    arrRoleList = RxList([
      RoleModel(label: "User"),
      RoleModel(label: "Admin"),
    ]);
    objRoleType.value = arrRoleList[0];
  }
  selectRoleType() {
    selectRoleTypeDialog((value) {
      objRoleType.value=value;
      txtUserRole.text = objRoleType.value.label??"";
    });
  }

  Future<dynamic> selectRoleTypeDialog(ValueChanged<RoleModel> onChange) {
    return SelectDialog1.showModal<RoleModel>(

      Get.context!,
      label: "Select Role Type",
      items: arrRoleList,
      onChange: onChange,
      searchBoxDecoration: InputDecoration(prefixIcon: Icon(Icons.search,color: AppColors.greyColor), hintText: "Search",hintStyle: TextStyle(color: AppColors.greyColor)),
    );
  }


  Future<RxList<TeamStatModel>> getStatsListData() async {
    arrStatsList = RxList([]);
    arrStatsList.add(TeamStatModel(
        totalCount: "92", statsIcon: mapPinSvgIcons, statsName: "Site Visit",statsIconColor: hex("00A5A1")));
    arrStatsList.add(TeamStatModel(
        totalCount: "20", statsIcon: creditCardSvgIcons, statsName: "EOI",statsIconColor:AppColors.paleGreenColor ));
    arrStatsList.add(TeamStatModel(
        totalCount: "10",
        statsIcon: homeHeartSvgIcons,
        statsName: "Registration",statsIconColor: AppColors.brightGreenColor));
    arrStatsList.add(TeamStatModel(
        totalCount: "10",
        statsIcon: homeCancel2SvgIcons,
        statsName: "Cancelled",statsIconColor: hex("E17055")));
    return arrStatsList;
  }

  Future<RxList<TeamsModel>> getTeamsListData() async {
    arrTeamsList = RxList([]);
    arrTeamsList.add(TeamsModel(
        userImage: userPngImage1,
        userName: "Alice Doe",
        mobileNo: "+91 9876543210",
        invitationStatus: "1",
        isStatus: "",
        userRole: "Admin"));
    arrTeamsList.add(TeamsModel(
        userImage: userPngImage2,
        userName: "Foray White",
        mobileNo: "+91 9876543277",
        invitationStatus: "2",
        isStatus: "",
        userRole: "Associate"));
    arrTeamsList.add(TeamsModel(
        userImage: "",
        userName: "Johane White",
        mobileNo: "+91 9876543241",
        invitationStatus: "3",
        isStatus: "",
        userRole: "Associate"));
    arrTeamsList.add(TeamsModel(
        userImage: "",
        userName: "Winter White",
        mobileNo: "+91 9876543274",
        invitationStatus: "4",
        isStatus: "",
        userRole: "Associate"));
    return arrTeamsList;
  }
}
class RoleModel{
  String? label;
  RoleModel({this.label});
}