import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/SizeConfig.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/BottomNavigationBarController/BottomNavigationBarController.dart';
import 'package:repeoplecp/Model/MenuItemModel/MenuItemModel.dart';
import 'package:repeoplecp/View/EarningsPage/EarningsPage.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  BottomNavigationBarController cntBottom = Get.put(BottomNavigationBarController());
  @override
  Widget build(BuildContext context) {
    return wd_BottomNavigation1();
  }


  Widget wd_BottomNavigation1() {
    return   Container(
        height: 65,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow:
          [
            BoxShadow(color:
            hex("266CB5").withOpacity(0.1),offset: Offset(1,1),blurRadius: 5,spreadRadius: 3),],
        ),
        width: Get.width,
        // color: WHITE,
        child: Obx((){
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return  Obx(() => _generateNavigationCell1(i));
              // return  Obx(() => _generateNavigationCellnew(i));
            },
            itemCount: cntBottom.arrBottomNavigationList.isNotEmpty ? cntBottom.arrBottomNavigationList.length : 0,
          );
        })
    );
  }

  Widget _generateNavigationCell1(int index) {
    MenuItemModel obj = cntBottom.arrBottomNavigationList[index];
    return obj.alias == "referral"
        ?Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: (){
          if(Is_Login.isTrue){
            cntBottom.selectedIndex=(-1).obs;
            Get.to(()=>const EarningsPage());
          }
          else{
            // LoginDialog();
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            height: Get.height,
            child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: AppColors.black,
                    shape: BoxShape.circle
                ),
                child:
                Center(
                  child: SvgPicture.asset(ruppeySvgIcon,width: 24,height: 24,color: AppColors.whiteColor),
                )
              // Center(child: Text('\u{20B9}',style: TextStyle(color: Colors.white,fontSize: 21,fontWeight: FontWeight.w500),),
              // ),
            ),
          ),
        ),
      ),
    ): Obx(() =>
        GestureDetector(
          onTap: () {
            cntBottom.selectIndex(index);
          },
          child: Container(
              width: Get.width / 5,
              height: 40,
              padding: EdgeInsets.only(left: 13,right: 13,top: 15),
              child: Column(
                children: [
                  obj.icon.toString().contains("svg") ?
                  SvgPicture.network(
                    obj.icon??"",
                    height: 25,
                    width: 25,
                    color: cntBottom.selectedIndex.value == index ? AppColors.appThemeColor : AppColors.newBlack,
                  ):
                  Image.network(
                    obj.icon??"",
                    color: cntBottom.selectedIndex.value == index ? AppColors.appThemeColor : AppColors.newBlack,
                    fit: BoxFit.contain,
                    height: 25,
                    width: 25,
                  ),
                  SizedBox(height: 5,),
                  Text(
                    cntBottom.selectedIndex.value == index?obj.name!.toUpperCase():obj.name??"",
                    style: TextStyle(
                        fontSize: 7.sp, color:
                    // selectedIndex.value == index?BLACK:
                    // gray_color_1,
                    cntBottom.selectedIndex.value == index ? AppColors.newBlack:
                    AppColors.newBlack,fontFamily: fontFamily,
                        fontWeight:
                        FontWeight.w700),
                  )
                  // : Container()
                ],
              )),
        ));


  }
}
