import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/CommenHeaderController.dart';
import 'package:repeoplecp/Controller/TeamController/TeamController.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/BottomNavigationBarPage.dart';
import 'package:repeoplecp/Widget/CustomDrawer/CustomDrawer.dart';

class AddTeamsPage extends StatefulWidget {
  const AddTeamsPage({super.key});

  @override
  State<AddTeamsPage> createState() => _AddTeamsPageState();
}

class _AddTeamsPageState extends State<AddTeamsPage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  TeamController cntTeam = Get.put(TeamController());
  GlobalKey<ScaffoldState> globalAddTeamPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    BottomNavigationBarPage().selectedIndex = 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: globalAddTeamPageKey,
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

                  const SizedBox(height: 10),
                ],
              ),
            ),
            cntCommonHeader.commonAppBar("Add Team Member", globalAddTeamPageKey,
                isMenuIconHide: true),
          ],
        ),
      ),
    );
  }
}
