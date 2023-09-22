import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/CommenHeaderController.dart';
import 'package:repeoplecp/Controller/OfferController/OfferController.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/BottomNavigationBarPage.dart';
import 'package:repeoplecp/Widget/CustomDrawer/CustomDrawer.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  OfferController cntTeam = Get.put(OfferController());
  GlobalKey<ScaffoldState> globalAddTeamPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    BottomNavigationBarPage().selectedIndex = 0;
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
            cntCommonHeader.commonAppBar("Offers", globalAddTeamPageKey,
                isMenuIconHide: true),
          ],
        ),
      ),
    );
  }
}
