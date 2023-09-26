import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Helper/AppUpgrade/app_upgrade.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/HomeController/home_controller.dart';
import 'package:repeoplecp/Model/ProjectListModel/project_list_model.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/bottom_navigationbar_page.dart';
import 'package:repeoplecp/View/PropertiesDetailsPage/properties_details_page.dart';
import 'package:repeoplecp/Widget/CustomAppBar/custom_appbar.dart';
import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';
import 'package:repeoplecp/Widget/ShimmerWidget/shimmer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController cntHome = Get.put(HomeController());
  CommonHeaderController cntDashHeader = Get.put(CommonHeaderController());
  GlobalKey<ScaffoldState> scaffoldHomeKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cntHome.arrCountList.refresh();
      cntHome.getDashBoardCount();
      cntHome.getProjectList();
      cntDashHeader.check.value=scaffoldHomeKey;
      BottomNavigationBarPage().selectedIndex = 0;
      isFavourite.value="0";
        // check.refresh();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldHomeKey,
      backgroundColor: AppColors.pageBackgroundColor,
      bottomNavigationBar: BottomNavigationBarPage(selectedIndex: 0),
      endDrawer: const CustomDrawer(
        animatedOffset: Offset(1.0, 0),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
                child: Column(
                  children: [
                      SizedBox(height: 85.w),
                      companyDetails(),
                      dashBoardCountDetails(),
                      const SizedBox(height: 20),
                      projectListData(),
                      const SizedBox(height: 20),
                  ],
            )),
            const DashBoardHeader()
          ],
        ),
      ),
    );
  }

  Widget companyDetails() {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
                color: AppColors.newBlack.withOpacity(0.1),
                offset: const Offset(0, 3),
                blurRadius: 4,
            spreadRadius: 0)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  companyPngImage,
                  width: 117.w,
                  height: 28.w,
                ),
                GestureDetector(
                    onTap: (){
                      Get.to(()=>AppUpgradePage(forceUpdate: true, msg: 'helloooooooooooo', versioncode: '10100',));
                    },
                    child: SvgPicture.asset(homeShareSvgIcons, height: 24.w, width: 24.w))
              ],
            ),
          ),
          SizedBox(height: 14.w),
          contactDetailsData(),
          SizedBox(height: 14.w),
          companyDetailsData(),
          SizedBox(height: 14.w),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding:
                  const EdgeInsets.only(right: 20, left: 20, bottom: 4, top: 4),
              decoration: BoxDecoration(
                  color: AppColors.appThemeColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: Row(
                children: [
                  Text('MAHARERA Reg. No.:',
                      style: mediumTextStyle(
                          txtColor: AppColors.newBlack,
                          fontWeight: FontWeight.w500,
                          fontSize: 10)),
                  Text(' A51800035827',
                      style: boldTextStyle(
                          txtColor: AppColors.newBlack,
                          fontWeight: FontWeight.w700,
                          fontSize: 10))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget contactDetailsData() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10.w, bottom: 10.w),
      decoration: BoxDecoration(
        color: AppColors.appThemeColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //    border: Border.all(color: AppColors.whiteColor, width: 0),
            ),
            child: CachedNetworkImage(
              width: 84.w,
              height: 84.w,
              placeholder: (context, url) =>
                  shimmerWidget(width: 84.w, height: 84.w, radius: 12),
              fadeInDuration: Duration.zero,
              fadeOutDuration: Duration.zero,
              placeholderFadeInDuration: Duration.zero,
              imageUrl: userPngImage,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return Image.asset(userPngImage,
                    width: 84.w, height: 84.w, fit: BoxFit.cover);
              },
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: 130.w,
                  child: Text(
                    'Yash Goswami'.toUpperCase(),
                    style: extraBoldTextStyle(
                        height: 0.9,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        txtColor: AppColors.whiteColor),
                  )),
              const SizedBox(height: 4),
              Text(
                '+91 9876543210',
                style: mediumTextStyle(
                    txtColor: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 10),
              ),
              Text(
                'yash@brikkin.com',
                style: mediumTextStyle(
                    txtColor: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 10),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget companyDetailsData() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Brikkin Martech Private Limited",
            style: boldTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                txtColor: AppColors.newBlack),
          ),
          SizedBox(height: 10.w),
          Text(
            "203, 2nd Floor, Ackruti Star, MIDC Central Road, Andheri East, Mumbai-400093",
            style: mediumTextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                txtColor: AppColors.newBlack),
          ),
        ],
      ),
    );
  }

  Widget dashBoardCountDetails() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(bottom: 20,top: 20,left: 20,right: 20),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20,),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
                color: AppColors.newBlack.withOpacity(0.1),
                offset: const Offset(0, 3),
                blurRadius: 6,
                spreadRadius: 0
            )
          ]),
      child: Obx(() =>Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          for (int i = 0; i < cntHome.arrCountList.length; i++)
             dashBoardCountWidget(
              color: cntHome.arrCountList[i].color,
              count: cntHome.arrCountList[i].count,
              icons: cntHome.arrCountList[i].icons,
              title: cntHome.arrCountList[i].title,
              border: Border.all(color: AppColors.lightGreyColor, width: 1)
            ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.green.withOpacity(0.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dashBoardCountWidget(
                  color: AppColors.brightGreenColor,
                  count: "8",
                  icons: homeHeartSvgIcons,
                  title: "Registration",
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8,right: 8),
                  height: 1,
                  color: AppColors.black.withOpacity(0.5),
                ),
                SizedBox(height: 10.w),
                totalCountWidget(
                  totalCount: "₹ 9,25,000",
                  title: "Total Earning"
                ),
                SizedBox(height: 10.w),
                totalCountWidget(
                    totalCount: "₹ 8,50,000",
                    title: "Received"
                ),
                SizedBox(height: 10.w),
                totalCountWidget(
                    totalCount: "₹ 75,000",
                    title: "Due",
                  textColor: AppColors.appThemeColor
                ),
                const SizedBox(height: 8),
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget totalCountWidget({String? title,String? totalCount,Color? textColor}){
    return Padding(
      padding: const EdgeInsets.only(right: 8,left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title??"",style: mediumTextStyle(txtColor: textColor??AppColors.newBlack,fontWeight: FontWeight.w500,fontSize: 14),),
          Text(totalCount??"",style: boldTextStyle(txtColor: textColor??AppColors.newBlack,fontWeight: FontWeight.w700,fontSize: 14),),
        ],
      ),
    );
  }

  Widget dashBoardCountWidget(
      {String? icons, String? title, Color? color, String? count,BoxBorder? border}) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
          // color: AppColors.whiteColor,
          border: border
          // Border.all(color: AppColors.lightGreyColor, width: 1)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: color,
                ),
                child: CachedNetworkImage(
                  width: 24.w,
                  height: 24.w,
                  placeholder: (context, url) =>
                      shimmerWidget(width: 24.w, height: 24.w, radius: 8),
                  fadeInDuration: Duration.zero,
                  fadeOutDuration: Duration.zero,
                  placeholderFadeInDuration: Duration.zero,
                  imageUrl: icons ?? "",
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return SvgPicture.asset(icons ?? "",
                        width: 24.w, height: 24.w, fit: BoxFit.cover);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title ?? "",
                style: mediumTextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    txtColor: AppColors.newBlack),
              )
            ],
          ),
          Text(
            count ?? "",
            style: boldTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                txtColor: AppColors.newBlack),
          )
        ],
      ),
    );
  }

  Widget projectListData() {
    return Obx(() => FutureBuilder(
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          if (cntHome.arrProjectList.isNotEmpty) {
            return SizedBox(
              height: 365.w,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: cntHome.arrProjectList.length,
                    itemBuilder: (context, i) {
                      return _generateProjectListData1(i);
                    }),
              ),
            );
          } else {
            return const SizedBox();
          }
        } else {
          return projectShimmerWidget();

        }
      },
      future: cntHome.futureArrProjectList.value,
    ));
  }

  Widget _generateProjectListData1(int index) {
    ProjectListModel obj = cntHome.arrProjectList[index];
    return GestureDetector(
      onTap: () {
        Get.to(()=>const PropertiesDetailsPage());
      },
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 322.w,
              width: Get.width,
              margin: const EdgeInsets.only(bottom: 10),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: CarouselSlider.builder(
                      carouselController: cntHome.controllerEvent,
                      itemCount: obj.projectImageList?.length,
                      itemBuilder: (context, index2, realIndex) {
                        return InkWell(
                          onTap: () {},
                          child: CachedNetworkImage(
                            height: 211.w,
                            width: Get.width,
                            placeholder: (context, url) => shimmerWidget(
                              height: 211.w,
                              width: Get.width,
                            ),
                            fadeInDuration: Duration.zero,
                            fadeOutDuration: Duration.zero,
                            placeholderFadeInDuration: Duration.zero,
                            imageUrl:
                            obj.projectImageList?[index2] ?? "",
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return Image.asset(
                                // IMG_BUILD4,
                                obj.projectImageList?[index2]?? "",
                                // height: 250,
                                width: Get.width,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        );
                      },
                      options: CarouselOptions(
                          autoPlay: true,
                          height: 211.w,
                          viewportFraction: 1,
                          onPageChanged: (index, _) {
                            cntHome.current.value = index;
                            cntHome.current.refresh();
                          }),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      children: [
                        Container(
                          width: Get.width,
                          height: 138.w,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          // padding: EdgeInsets.only(top: 10.w,bottom: 10.w,right: 8.w,left: 8.w),
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [newContainerBoxShadow]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10.w,right: 8.w,left: 8.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(obj.projectTitle ?? "",
                                            style: boldTextStyle(
                                                fontSize: 15, txtColor: AppColors.appThemeColor)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(obj.address ?? "",
                                            style: mediumTextStyle(
                                                fontSize: 10, txtColor: AppColors.newBlack)),
                                      ],
                                    ),
                                   Obx(() =>  GestureDetector(
                                      onTap: () {
                                        isFavourite.value="1";
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: AppColors.whiteColor.withOpacity(0.8),
                                        ),
                                        child: isFavourite.value == "1"
                                            ? SvgPicture.asset(isFavouriteTrueIcons)
                                            : SvgPicture.asset(
                                          favouriteSvgIcons,
                                        )
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8.w,
                              ),
                              obj.configureList!=null?SizedBox(
                                height: 55.w,
                                // alignment: Alignment.centerLeft,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:  obj.configureList?.length,
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.only(right: 8.w,left: 8.w),
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (BuildContext context, int i) {
                                    return Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 6.w),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              offset: const Offset(0, 0),
                                              color:
                                              AppColors.appThemeColor.withOpacity(0.1),
                                              spreadRadius: 0
                                          )
                                        ],
                                        color: hex("F5F6FA"),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            obj.configureList![i].totalBHK??"",
                                            style: boldTextStyle(
                                                fontSize: 10, txtColor: AppColors.appThemeColor),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            obj.configureList![i].totalRS??"",
                                            style: boldTextStyle(
                                                fontSize: 10,
                                                txtColor: hex("707070")),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            obj.configureList![i].onWords??"",
                                            style: regularTextStyle(
                                                fontSize: 10,
                                                txtColor: hex("707070")),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    );
                                    // :SizedBox();
                                  },
                                ),
                              ):const SizedBox(),
                              //  const SizedBox(
                              //   height: 9.3,
                              // ),

                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 20,
                          right: 20,
                          // alignment: Alignment.bottomCenter,
                          child: Center(
                            child: Container(
                              padding:
                              const EdgeInsets.only(right: 8, left: 8, bottom: 4, top: 4),
                              decoration: BoxDecoration(
                                  color: AppColors.appThemeColor.withOpacity(0.2),
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              child: Row(
                                children: [
                                  Text('MAHARERA Reg. No.:',
                                      style: mediumTextStyle(
                                          txtColor: AppColors.newBlack,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10)),
                                  Text(' A51800035827',
                                      style: boldTextStyle(
                                          txtColor: AppColors.newBlack,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 16,bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    offset: const Offset(0, 3),
                    blurRadius: 6,
                    spreadRadius: 0
                  )
                ]
              ),
              child:
              // CachedNetworkImage(
              //   width: 60.w,
              //   height: 47.w,
              //   placeholder: (context, url) => shimmerWidget(
              //       width: 60.w,
              //       height: 47.w, radius: 10),
              //   fadeInDuration: Duration.zero,
              //   fadeOutDuration: Duration.zero,
              //   placeholderFadeInDuration: Duration.zero,
              //   imageUrl: obj.projectLogo ?? "",
              //   fit: BoxFit.fill,
              //   errorWidget: (context, url, error) {
              //     return
                    Image.asset(obj.projectLogo ?? "",
                      width: 60.w,
                      height: 47.w,
                      fit: BoxFit.fill)
              //   },
              // ),
            ),
          ),

        ],
      ),
    );
  }

  Widget projectShimmerWidget(){
    return Container();
  }

}
