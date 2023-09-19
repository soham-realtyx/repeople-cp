import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/CommenHeaderController.dart';
import 'package:repeoplecp/Controller/EarningsController/EarningsController.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/BottomNavigationBarPage.dart';
import 'package:repeoplecp/View/HomePage/HomePage.dart';

class EarningsPage extends StatefulWidget {
  const EarningsPage({super.key});

  @override
  State<EarningsPage> createState() => _EarningsPageState();
}

class _EarningsPageState extends State<EarningsPage> {
  EarningsController cntEarning = Get.put(EarningsController());
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  @override
  void initState() {
    super.initState();
    BottomNavigationBarPage().selectedIndex=2;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        BottomNavigationBarPage().selectedIndex=2;
        Get.offAll(const HomePage());
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        key: cntEarning.globalEarningPageKey,
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
                "Earning", cntEarning.globalEarningPageKey,
              )
            ],
          ),
        ),
        bottomNavigationBar:  BottomNavigationBarPage(selectedIndex: 2),
      ),
    );
  }
}
