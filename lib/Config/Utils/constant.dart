
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
BuildContext contextCommon = Get.context!;
const appName = "RepeopleCP";
double appBarHeight = 70;
RxBool isBadgeShow=false.obs;

Rxn<dynamic> check=Rxn();

Rx<Country> countryIndia = const Country(
  name: "India",
  flag: "🇮🇳",
  code: "IN",
  dialCode: "91",
  minLength: 10,
  maxLength: 10, nameTranslations: {},
).obs;

RxString isRegistered = "0".obs;

RxBool Is_Login = false.obs;
RxBool Is_WhatsApp_Active = false.obs;
RxString username = "".obs;
RxString profile_pic = "".obs;
RxString email = "".obs;
RxString firstname = "".obs;
RxString lastname = "".obs;
RxString mobile = "".obs;
RxString alternate_mobile = "".obs;
RxString customer_id = "".obs;
RxString userLoginType = "".obs;
RxString customerID = "".obs;
RxString isWhatsApp = "".obs;
RxString isAlternateWSwitch = "".obs;
RxString userProffessionName = "".obs;
RxInt redeemPoints = 0.obs;

const homeMenu = "home";
const SECONDMENU = "second";
const earningMenu = "earning";
const FAVMENU = "favorite";
const accountMenu = "account";
const PROFILE = "Profile";
const KEYMENU = "key";
const leadsMenu = "leads";
const propertiesMenu = "properties";
const NOTIFICTIONMENU = "notification";
const EDITPROFILE = "Edit Profile";
const ADDNEWHOME = "Add New Property";

bool isBottomPageNavigate = false;