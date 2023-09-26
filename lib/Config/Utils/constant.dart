
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:package_info/package_info.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
const googleMapKey="AIzaSyCPYLUPMcdMC45LWtPTKdOd19eQ4ia5dXU";

BuildContext contextCommon = Get.context!;
const appName = "RepeopleCP";
double appBarHeight = 70.w;
RxBool isBadgeShow=false.obs;

RxString isFavourite = "0".obs;
// RxInt selectedIndex = 0.obs;

// Rxn<dynamic> check=Rxn();

Rx<Country> countryIndia = const Country(
  name: "India",
  flag: "🇮🇳",
  code: "IN",
  dialCode: "91",
  minLength: 10,
  maxLength: 10, nameTranslations: {},
).obs;

RxString isRegistered = "0".obs;

RxBool isLogin = false.obs;
RxBool isWhatsAppActive = false.obs;
RxString username = "".obs;
RxString profilePic = "".obs;
RxString email = "".obs;
RxString firstname = "".obs;
RxString lastname = "".obs;
RxString mobile = "".obs;
RxString alternateMobile = "".obs;
RxString customerId = "".obs;
RxString userLoginType = "".obs;
RxString customerID = "".obs;
RxString isWhatsApp = "".obs;
RxString isAlternateWSwitch = "".obs;
RxString userProfessionName = "".obs;
RxInt redeemPoints = 0.obs;

const notificationCount = "notification_count";

const notification = "Notifications";
const notificationList = "Notification_List";

const homeMenu = "home";
const secondMenu = "second";
const earningMenu = "earning";
const favMenu = "favorite";
const accountMenu = "account";
const profile = "Profile";
const keyMenu = "key";
const leadsMenu = "leads";
const propertiesMenu = "properties";
const notificationMenu = "notification";
const editProfile = "Edit Profile";
const addHome = "Add New Property";

bool isBottomPageNavigate = false;


RxString updateMessage = "There is a newer version of app available please update it now.".obs;
RxString version = ''.obs;
RxBool forceUpdate = false.obs;
RxBool showHideDlg=false.obs;
PackageInfo packageInfo = PackageInfo(
  appName: 'Unknown',
  packageName: 'Unknown',
  version: 'Unknown',
  buildNumber: 'Unknown',
);
