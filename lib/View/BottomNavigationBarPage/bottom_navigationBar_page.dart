import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/BottomNavigationBarController/bottom_navigationBar_controller.dart';
import 'package:repeoplecp/Model/MenuItemModel/menu_item_model.dart';

class BottomNavigationBarPage extends StatefulWidget {
  late int? selectedIndex = 0;
   BottomNavigationBarPage({super.key,this.selectedIndex});

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  BottomNavigationBarController cntBottom = Get.put(BottomNavigationBarController());
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return bottomNavigationList();
  }


  Widget bottomNavigationList() {
    return   Container(
        height: 75,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow:
          [
            BoxShadow(color:
            hex("266CB5").withOpacity(0.1),offset: const Offset(1,1),blurRadius: 5,spreadRadius: 3),],
        ),
        width: Get.width,
        child: Obx((){
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(left: 10,right: 20),
            itemBuilder: (context, i) {
              return  Obx(() => _generateNavigation(i));
            },
            itemCount: cntBottom.arrBottomNavigationList.isNotEmpty ? cntBottom.arrBottomNavigationList.length : 0,
          );
        })
    );
  }

  Widget _generateNavigation(int index) {
    MenuItemModel obj = cntBottom.arrBottomNavigationList[index];
    return obj.alias == "earning"
        ?Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: (){
          cntBottom.selectIndex(index);
          // if(Is_Login.isTrue){
          //   cntBottom.selectedIndex=(-1).obs;
          //   Get.to(()=>const EarningsPage());
          // }
          // else{
            // LoginDialog();
          // }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 16),
          child: SizedBox(
            height: Get.height,
            child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 0),
                decoration: BoxDecoration(
                    color: AppColors.black,
                   borderRadius: BorderRadius.circular(24)
                ),
                child:
                Center(
                  child: SvgPicture.asset(ruppeySvgIcon,width: 24,height: 24,color: AppColors.whiteColor),
                )
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
              width: Get.width / 5.2,
              height: 40,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 0,right: 0,top: 20),
              child: Column(
                children: [
                  obj.icon.toString().contains("svg") ?
                  SvgPicture.asset(
                    obj.icon??"",
                    height: 25,
                    width: 25,
                    color: cntBottom.selectedIndex.value == index ? AppColors.appThemeColor : AppColors.newBlack,
                  ):
                  Image.asset(
                    obj.icon??"",
                    color: cntBottom.selectedIndex.value == index ? AppColors.appThemeColor : AppColors.newBlack,
                    fit: BoxFit.contain,
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(height: 5,),
                  Text(
                   obj.name??"",
                    style: TextStyle(
                        fontSize: 7.sp, color:
                    cntBottom.selectedIndex.value == index ? AppColors.newBlack:
                    AppColors.newBlack,fontFamily: fontFamily,
                        fontWeight:
                        FontWeight.w700),
                  )
                ],
              )),
        ));


  }
}
