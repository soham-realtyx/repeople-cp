import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/RelationShipManagerController/relationship_manager_controller.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/bottom_navigationBar_page.dart';
import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';
import 'package:repeoplecp/Widget/ShimmerWidget/shimmer_widget.dart';

class RelationShipManagerPage extends StatefulWidget {
  const RelationShipManagerPage({super.key});

  @override
  State<RelationShipManagerPage> createState() => _RelationShipManagerPageState();
}

class _RelationShipManagerPageState extends State<RelationShipManagerPage> {
  RelationShipManagerController cntRelationShip = Get.put(RelationShipManagerController());
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  GlobalKey<ScaffoldState> globalRelationShipManagerPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // check.value = globalRelationShipManagerPageKey;
      BottomNavigationBarPage().selectedIndex = 0;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: globalRelationShipManagerPageKey,
      endDrawer: CustomDrawer(
        animatedOffset: const Offset(1.0, 0),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 90),
                  relationShipManagerData(),
                  const SizedBox(height: 20),

                  const SizedBox(height: 10),
                ],
              ),
            ),
            cntCommonHeader.commonAppBar(
                "Relationship Manager",
                globalRelationShipManagerPageKey,
                isMenuIconHide: true
            ),
          ],
        ),
      ),
    );
  }

  Widget relationShipManagerData(){
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(left: 20,right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.appThemeColor.withOpacity(0.2)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  width: 70.w,
                  height: 70.w,
                  placeholder: (context, url) =>
                      shimmerWidget(width: 70.w, height: 70.w, radius: 10),
                  fadeInDuration: Duration.zero,
                  fadeOutDuration: Duration.zero,
                  placeholderFadeInDuration: Duration.zero,
                  imageUrl: managerPngImage,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return Image.asset(managerPngImage,
                        width: 70.w, height: 70.w, fit: BoxFit.cover);
                  },
                ),
              ),
              const SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Jenevive".toUpperCase(),style: extraBoldTextStyle(fontSize: 22,fontWeight: FontWeight.w900,txtColor: AppColors.appThemeColor)),
                  Text("White".toUpperCase(),style: extraBoldTextStyle(fontSize: 22,fontWeight: FontWeight.w900,txtColor: AppColors.appThemeColor)),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          managerDetailsWidget(
              title: "+91 9876543210",
              icons: callSvgIcons
          ),
          const SizedBox(height: 20),
          managerDetailsWidget(
              title: "+91 9876543210",
              icons: newWhatsAppSvgIcons
          ),
          const SizedBox(height: 20),
          managerDetailsWidget(
              title: "jenevive@white.com",
              icons: mailForwardSvgIcons
          ),
        ],
      ),
    );
  }

  Widget managerDetailsWidget({String? title,String? icons}){
    return Container(
      padding: const EdgeInsets.only(right: 12,left: 12,bottom: 8,top: 8),
      decoration: BoxDecoration(
        color: AppColors.whiteColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.appThemeColor.withOpacity(0.3),width: 1)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title??"",style: mediumTextStyle(txtColor: AppColors.newBlack,fontWeight: FontWeight.w500,fontSize: 10),),
          SvgPicture.asset(icons??"",width: 20,height: 20,)
        ],
      ),
    );
  }

}
