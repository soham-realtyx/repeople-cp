
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/SizeConfig.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Model/MenuItemModel/MenuItemModel.dart';
import 'package:repeoplecp/View/EarningsPage/EarningsPage.dart';
import 'package:repeoplecp/View/HomePage/HomePage.dart';
import 'package:repeoplecp/View/LeadsPage/LeadsPage.dart';
import 'package:repeoplecp/View/PropertiesPage/PropertiesPage.dart';
import 'package:repeoplecp/View/PropfilePage/ProfilePage.dart';

class BottomNavigationBarController extends GetxController{

  RxList<MenuItemModel> arrBottomNavigationList = RxList<MenuItemModel>([]);


  @override
  void onInit() {
    super.onInit();
    bottomMenuData();
  }

  Future<RxList<MenuItemModel>> bottomMenuData()async{
    arrBottomNavigationList = RxList([]);
    arrBottomNavigationList.add(MenuItemModel(id: '1',name: "Dashboard",icon: dashBoardSvgIcon,alias: "home"));
    arrBottomNavigationList.add(MenuItemModel(id: '1',name: "Leads",icon: leadsSvgIcon,alias: "leads"));
    arrBottomNavigationList.add(MenuItemModel(id: '1',name: "earning",icon: leadsSvgIcon,alias: "earning"));
    arrBottomNavigationList.add(MenuItemModel(id: '1',name: "Properties",icon: propertiesSvgIcon,alias: "properties"));
    arrBottomNavigationList.add(MenuItemModel(id: '1',name: "Account",icon: userSvgIcon,alias: "account"));
    return arrBottomNavigationList;
  }
  RxInt selectedIndex = 0.obs;

  selectIndex(int index){
    if(index!=4){
      selectedIndex.value = index;
      selectedIndex.update((val) { });
      selectedIndex.refresh();
      selectedIndex.value = index;
      onInit();
    }
    else{
      if(Is_Login.isTrue){
        selectedIndex.value = index;
        selectedIndex.obs;
        selectedIndex.refresh();
        selectedIndex.value = index;
        onInit();
      }
    }

    onNavigation(index);
    arrBottomNavigationList.refresh();
    update();
  }

  onNavigation(int index){
    MenuItemModel obj = arrBottomNavigationList[index];
    switch(obj.alias){
      case homeMenu:
        Get.offAll(() => const HomePage(),
          duration: const Duration(milliseconds: 0),
        );
        break;
      case leadsMenu:
        isBottomPageNavigate = true;
        gotoLeadsPage();
        break;
      case propertiesMenu:
        gotoPropertiesPage();
        break;
      case earningMenu:
          isBottomPageNavigate = true;
          gotoEarningPage();
          break;
      case accountMenu:
          isBottomPageNavigate = true;
        // if(Is_Login.isTrue){
          gotoProfile();
          break;
        // }
        // else{
          // LoginDialog();
        // }
    }
  }

  gotoLeadsPage() async {

      var index = await Get.to(
        const LeadsPage(),
        duration: Duration.zero,
      )?.then((value) => selectedIndex.value=0);

      if (index != null) {
        selectIndex(index);
      }

  }
  gotoEarningPage() async {

      var index = await Get.to(
        const EarningsPage(),
        duration: Duration.zero,
      )?.then((value) => selectedIndex.value=0);

      if (index != null) {
        selectIndex(index);
      }

  }
  gotoPropertiesPage() async {

      var index = await Get.to(
        const PropertiesPage(),
        duration: Duration.zero,
      )?.then((value) => selectedIndex.value=0);

      if (index != null) {
        selectIndex(index);
      }

  }
  gotoProfile() async {
      var index = await Get.to(
        const ProfilePage(),
        duration: Duration.zero,
      )?.then((value) => selectedIndex.value=0);

      if (index != null) {
        selectIndex(index);
      }

  }


}