import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/FavouriteController/favourite_controller.dart';
import 'package:repeoplecp/Model/ProjectListModel/project_list_model.dart';
import 'package:repeoplecp/View/PropertiesDetailsPage/properties_details_page.dart';

import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  FavouriteController cntFavourite = Get.put(FavouriteController());
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  GlobalKey<ScaffoldState> globalFavouritePageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    cntFavourite.getFavouriteList();
    // check.value=globalFavouritePageKey;
    // selectedIndex.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: globalFavouritePageKey,
      endDrawer: const CustomDrawer(
        animatedOffset: Offset(1.0, 0),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 130),
                  favouriteProjectListData(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            cntCommonHeader.commonAppBar(
                "Favourites",
                globalFavouritePageKey,
                isMenuIconHide: true
            ),
          ],
        ),
      ),
    );
  }
  Widget favouriteProjectListData() {
    return Obx(() => FutureBuilder(
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          if (cntFavourite.arrFavoriteList.isNotEmpty) {
            return SizedBox(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: cntFavourite.arrFavoriteList.length,
                    itemBuilder: (context, i) {
                      return _generatefavouriteProjectListData(i);
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
      future: cntFavourite.futureFavourite.value,
    ));
  }

  Widget _generatefavouriteProjectListData(int index) {
    ProjectListModel obj = cntFavourite.arrFavoriteList[index];
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
              height: 328.w,
              width: Get.width,
              margin: const EdgeInsets.only(bottom: 60),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: CarouselSlider.builder(
                      carouselController: cntFavourite.controllerEvent,
                      itemCount: obj.projectImageList?.length,
                      itemBuilder: (context, index2, realIndex) {
                        return InkWell(
                          onTap: () {

                          },
                          child: ClipRRect(
                              child:
                              // CachedNetworkImage(
                              //   height: 211.w,
                              //   width: Get.width,
                              //   placeholder: (context, url) => shimmerWidget(
                              //     height: 211.w,
                              //     width: Get.width,
                              //   ),
                              //   fadeInDuration: Duration.zero,
                              //   fadeOutDuration: Duration.zero,
                              //   placeholderFadeInDuration: Duration.zero,
                              //   imageUrl:
                              //   obj.projectImageList?[index2] ?? "",
                              //   fit: BoxFit.cover,
                              //   errorWidget: (context, url, error) {
                              //     return

                              Image.asset(
                                // IMG_BUILD4,
                                obj.projectImageList?[index2]?? "",
                                // height: 250,
                                width: Get.width,
                                fit: BoxFit.cover,
                              )
                            //   },
                            // )
                          ),
                        );
                      },
                      options: CarouselOptions(
                          autoPlay: true,
                          height: 211.w,
                          viewportFraction: 1,
                          onPageChanged: (index, _) {
                            cntFavourite.current.value = index;
                            cntFavourite.current.refresh();
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
                                    GestureDetector(
                                      onTap: () {

                                      },
                                      child: Container(
                                          height: 35,
                                          width: 35,
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: AppColors.whiteColor.withOpacity(0.8),
                                          ),
                                          child:/* obj.isfavorite.toString() == "1"
                                            ? SvgPicture.asset(IMG_FAVORITE_SVG_2)
                                            : */SvgPicture.asset(
                                            favouriteSvgIcons,
                                          )
                                      ),
                                    ),
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
                              const SizedBox(
                                height: 9.2,
                              ),

                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 20,
                          left: 20,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -45,
            child: Container(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 16,bottom: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: AppColors.whiteColor,
                    border: Border.all(color: AppColors.lightWhite,width: 3),
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
                //       height: 47.w, radius: 98),
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
