import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/PrivacyPolicyController/privacy_policy_controller.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/bottom_navigationbar_page.dart';
import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  PrivacyPolicyController cntPrivacyPolicy = Get.put(PrivacyPolicyController());
  GlobalKey<ScaffoldState> globalPrivacyPolicyPageKey = GlobalKey<ScaffoldState>();
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
        key: globalPrivacyPolicyPageKey,
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
              cntCommonHeader.commonAppBar("Privacy Policy", globalPrivacyPolicyPageKey,
                  isMenuIconHide: true)
            ],
          ),
        ),

      );
  }
}
