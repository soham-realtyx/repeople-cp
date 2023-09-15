
import 'package:flutter/material.dart';
import 'package:repeoplecp/Config/Helper/HexColor.dart';

class AppColors {
  static Color black = const Color(0xff000000);
  static Color appThemeColor = const Color(0xff006CB5);
  static Color whiteColor = const Color(0xffFFFFFF);
  static Color lightGreen = const Color(0xff2CB741);
  static Color lightRed = const Color(0xffD63031);
  static Color red = const Color(0xffE20000);
  static Color lightGrey = const Color(0xffC2C2C2);
  static Color greyColor = const Color(0xff323232);
  static Color labelGreyColor = const Color(0xff898989);
  static Color appGreyColor = const Color(0xffF8F8F8);
  static Color transParent = HexColor("#00FFFFFF");
  static Color appFontColor = HexColor("#000000");

}

MaterialColor hex(String hex) => _factoryColor(_getColorHexFromStr(hex));
MaterialColor _factoryColor(int color) {
  return MaterialColor(color, <int, Color>{
    50: Color(color),
    100: Color(color),
    200: Color(color),
    300: Color(color),
    400: Color(color),
    500: Color(color),
    600: Color(color),
    700: Color(color),
    800: Color(color),
    900: Color(color),
  });



}
int _getColorHexFromStr(String colorStr) {
  colorStr = "FF" + colorStr;
  colorStr = colorStr.replaceAll("#", "");
  int val = 0;
  int len = colorStr.length;
  for (int i = 0; i < len; i++) {
    int hexDigit = colorStr.codeUnitAt(i);
    if (hexDigit >= 48 && hexDigit <= 57) {
      val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 65 && hexDigit <= 70) {
// A..F
      val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 97 && hexDigit <= 102) {
// a..f
      val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    } else {
      val = 0xFFFFFFFF;
    }
  }
  return val;
}