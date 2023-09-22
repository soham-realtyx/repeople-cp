import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Model/TeamsModel/TeamsModel.dart';

class TeamController extends GetxController {
  RxList<TeamsModel> arrTeamsList = RxList([]);
  RxList<TeamStatModel> arrStatsList = RxList([]);

  @override
  void onInit() {
    super.onInit();
    getStatsListData();
    getTeamsListData();
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
