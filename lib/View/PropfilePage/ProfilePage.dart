import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/CommenHeaderController.dart';
import 'package:repeoplecp/Controller/MyAccountController/MyAccountController.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/BottomNavigationBarPage.dart';
import 'package:repeoplecp/View/HomePage/HomePage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  MyAccountController cntAccount = Get.put(MyAccountController());
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  GlobalKey<ScaffoldState> globalMyAccountPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    BottomNavigationBarPage().selectedIndex=4;
  }
  @override
  Widget build(BuildContext context) {
    return
      // WillPopScope(
      // onWillPop: ()async{
      //   BottomNavigationBarPage().selectedIndex=4;
      //   Get.offAll(const HomePage());
      //   return false;
      // },
      // child:
      Scaffold(
        backgroundColor: AppColors.whiteColor,
        key: globalMyAccountPageKey,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: appBarHeight),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
              cntCommonHeader.commonAppBar(
                "Profile", globalMyAccountPageKey,
                isMenuIconHide: true
              )
            ],
          ),

        ),
        bottomNavigationBar:  BottomNavigationBarPage(selectedIndex: 4),
      );
    // );
  }
}
