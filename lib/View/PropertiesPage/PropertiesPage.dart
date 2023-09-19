import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/CommenHeaderController.dart';
import 'package:repeoplecp/Controller/PropertiestController/PropertiesController.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/BottomNavigationBarPage.dart';
import 'package:repeoplecp/View/HomePage/HomePage.dart';

class PropertiesPage extends StatefulWidget {
  const PropertiesPage({super.key});

  @override
  State<PropertiesPage> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  PropertiesController cntProperties = Get.put(PropertiesController());
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  GlobalKey<ScaffoldState> globalPropertiesPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    BottomNavigationBarPage().selectedIndex=3;
  }
  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
      onWillPop: ()async{
        BottomNavigationBarPage().selectedIndex=3;
        Get.offAll(const HomePage());
        return false;
      },
      child:
      Scaffold(
        backgroundColor: AppColors.whiteColor,
        key: globalPropertiesPageKey,
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
                  "Projects", globalPropertiesPageKey,
              )
            ],
          ),

        ),
        bottomNavigationBar:  BottomNavigationBarPage(selectedIndex: 3),
      ),
    );
  }
}
