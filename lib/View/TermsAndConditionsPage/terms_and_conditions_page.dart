import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/TermsAndConditionsController/terms_and_condition_controller.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/bottom_navigationbar_page.dart';
import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  TermsAndConditionsController cntTAndC = Get.put(TermsAndConditionsController());
  GlobalKey<ScaffoldState> globalTAndCPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // check.value = globalMyAccountPageKey;
      BottomNavigationBarPage().selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: globalTAndCPageKey,
      endDrawer: const CustomDrawer(
        animatedOffset: Offset(1.0, 0),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: appBarHeight),

                  const SizedBox(height: 20),

                ],
              ),
            ),
            cntCommonHeader.commonAppBar("Terms & Conditions", globalTAndCPageKey,
                isMenuIconHide: true)
          ],
        ),
      ),

    );
  }
}
