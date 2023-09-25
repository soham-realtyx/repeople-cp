import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/View/SendOTPPage/send_otp_page.dart';
import 'package:repeoplecp/Widget/CustomBottomSheet/custom_bottom_sheet.dart';

logoutDialog() {
  loginDialogue(
      dialogText: "Are you sure you want to logout?",
      stackIcon:SvgPicture.asset(logOutSvgIcons,color: AppColors.whiteColor,height: 35,),
      firstButtonTap: () {
        Get.back();
      },
      secondButtonTap: () async{
        Get.to(()=>const SendOTPPage());
        // appLoader(contextCommon);
      },
      secondButtonText: "Yes",
      firstButtonText: "No");
}