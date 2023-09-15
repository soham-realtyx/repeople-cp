
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';

const appName = "RepeopleCP";
double appBarHeight = 70;
RxBool isBadgeShow=false.obs;

Rx<Country> countryIndia = const Country(
  name: "India",
  flag: "🇮🇳",
  code: "IN",
  dialCode: "91",
  minLength: 10,
  maxLength: 10, nameTranslations: {},
).obs;

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