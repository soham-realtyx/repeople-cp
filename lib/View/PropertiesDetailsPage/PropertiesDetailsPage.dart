import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:repeoplecp/Config/Utils/SizeConfig.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/string.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/CommenHeaderController.dart';
import 'package:repeoplecp/Controller/PropertiestController/PropertiesController.dart';
import 'package:repeoplecp/Model/ProjectListModel/ProjectListModel.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/BottomNavigationBarPage.dart';
import 'package:repeoplecp/Widget/CustomBoxDecoration.dart';
import 'package:repeoplecp/Widget/CustomButton/CustomButton.dart';
import 'package:repeoplecp/Widget/CustomDrawer/CustomDrawer.dart';
import 'package:repeoplecp/Widget/CustomTextField.dart';
import 'package:repeoplecp/Widget/HorizontalDividerWidget.dart';
import 'package:repeoplecp/Widget/ShimmerWidget/ShimmerWidget.dart';

class PropertiesDetailsPage extends StatefulWidget {
  const PropertiesDetailsPage({super.key});

  @override
  State<PropertiesDetailsPage> createState() => _PropertiesDetailsPageState();
}

class _PropertiesDetailsPageState extends State<PropertiesDetailsPage> {
  PropertiesController cntProperties = Get.put(PropertiesController());
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  GlobalKey<ScaffoldState> globalPropertiesDetailsPageKey =
      GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    cntProperties.getProjectList();
    cntProperties.getProjectDetailsList();
    cntProperties.projectHeaderBlocData();
    cntProperties.overViewData();
    cntProperties.getGalleryData();
    cntProperties.getAmenitiesData();
    cntProperties.getSiteProgressData();
    cntProperties.getProjectDetailsList();
    check.value=globalPropertiesDetailsPageKey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      key: globalPropertiesDetailsPageKey,
      endDrawer: CustomDrawer(
        animatedOffset: const Offset(1.0, 0),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: appBarHeight),
                  projectHeaderData(),
                  const SizedBox(height: 20),
                  projectDetailsBlockHeader(),
                  const SizedBox(height: 20),
                  projectDescriptionData(),
                  const SizedBox(height: 20),
                  overViewSectionListData(),
                  const SizedBox(height: 20),
                  connectivityData(),
                  const SizedBox(height: 20),
                  gallerySection(),
                  const SizedBox(height: 20),
                  locationSection(),
                  const SizedBox(height: 20),
                  amenitiesSection(),
                  const SizedBox(height: 20),
                  siteProgressSection(),
                  const SizedBox(height: 20),
                  planLayoutSection(),
                  const SizedBox(height: 20),
                  siteVisitData(false),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            cntCommonHeader.commonAppBar("", globalPropertiesDetailsPageKey,
                isMenuIconHide: true)
          ],
        ),
      ),
      // bottomNavigationBar:  BottomNavigationBarPage(selectedIndex: 3),
    );
  }

  Widget projectHeaderData() {
    return Obx(() => FutureBuilder(
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                !snapshot.hasError) {
              if (cntProperties.arrProjectList.isNotEmpty) {
                return SizedBox(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: cntProperties.arrProjectDetailsList.length,
                        itemBuilder: (context, i) {
                          return _generateProjectListData(i);
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
          future: cntProperties.futureArrProjectList.value,
        ));
  }

  Widget _generateProjectListData(int index) {
    ProjectListModel obj = cntProperties.arrProjectDetailsList[index];
    return GestureDetector(
      onTap: () {},
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 323.w,
          width: Get.width,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    CarouselSlider.builder(
                      carouselController: cntProperties.controllerEvent,
                      itemCount: obj.projectImageList?.length,
                      itemBuilder: (context, index2, realIndex) {
                        return InkWell(
                          onTap: () {},
                          child: ClipRRect(
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
                            imageUrl: obj.projectImageList?[index2] ?? "",
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return Image.asset(
                                // IMG_BUILD4,
                                obj.projectImageList?[index2] ?? "",
                                // height: 250,
                                width: Get.width,
                                fit: BoxFit.cover,
                              );
                            },
                          )),
                        );
                      },
                      options: CarouselOptions(
                          autoPlay: true,
                          height: 211.w,
                          viewportFraction: 1,
                          onPageChanged: (index, _) {
                            cntProperties.current.value = index;
                            cntProperties.current.refresh();
                          }),
                    ),
                    Container(
                      height: 211.w,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor.withOpacity(0.9),
                          border: Border.all(
                              color: AppColors.lightWhite, width: 3),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.black.withOpacity(0.1),
                                offset: const Offset(0, 3),
                                blurRadius: 6,
                                spreadRadius: 0)
                          ]),
                      child: Container(
                        width: 93.w,
                        height: 73.w,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 140, vertical: 64),
                        child: CachedNetworkImage(
                          width: 93.w,
                          height: 73.w,
                          placeholder: (context, url) => shimmerWidget(
                              width: 93.w, height: 73.w, radius: 10),
                          fadeInDuration: Duration.zero,
                          fadeOutDuration: Duration.zero,
                          placeholderFadeInDuration: Duration.zero,
                          imageUrl: obj.projectLogo ?? "",
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) {
                            return Image.asset(obj.projectLogo ?? "",
                                width: 93.w,
                                height: 73.w,
                                fit: BoxFit.fill);
                          },
                        ),
                      ),
                    ),
                  ],
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
                            padding: EdgeInsets.only(
                                top: 10.w, right: 8.w, left: 8.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(obj.projectTitle ?? "",
                                        style: boldTextStyle(
                                            fontSize: 15,
                                            txtColor: AppColors.appThemeColor)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(obj.address ?? "",
                                        style: mediumTextStyle(
                                            fontSize: 10,
                                            txtColor: AppColors.newBlack)),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      height: 35,
                                      width: 35,
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.whiteColor
                                            .withOpacity(0.8),
                                      ),
                                      child: /* obj.isfavorite.toString() == "1"
                                        ? SvgPicture.asset(IMG_FAVORITE_SVG_2)
                                        : */
                                          SvgPicture.asset(
                                        favouriteSvgIcons,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8.w,
                          ),
                          obj.configureList != null
                              ? SizedBox(
                                  height: 55.w,
                                  // alignment: Alignment.centerLeft,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: obj.configureList?.length,
                                    scrollDirection: Axis.horizontal,
                                    padding:
                                        EdgeInsets.only(right: 8.w, left: 8.w),
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (BuildContext context, int i) {
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.h, vertical: 6.w),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                offset: const Offset(0, 0),
                                                color: AppColors.appThemeColor
                                                    .withOpacity(0.1),
                                                spreadRadius: 0)
                                          ],
                                          color: hex("F5F6FA"),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              obj.configureList![i].totalBHK ??
                                                  "",
                                              style: boldTextStyle(
                                                  fontSize: 10,
                                                  txtColor:
                                                      AppColors.appThemeColor),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              obj.configureList![i].totalRS ??
                                                  "",
                                              style: boldTextStyle(
                                                  fontSize: 10,
                                                  txtColor: hex("707070")),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              obj.configureList![i].onWords ??
                                                  "",
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
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 9.2,
                          ),

                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.only(
                            right: 8, left: 8, bottom: 4, top: 4),
                        decoration: BoxDecoration(
                            color:
                            AppColors.appThemeColor.withOpacity(0.2),
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
    );
  }

  Widget projectDetailsBlockHeader() {
    return Obx(
      () => FutureBuilder(
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return cntProperties.arrProjectHeaderBlocList.isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    itemBuilder: (context, i) {
                      return _generateProjectBlock1(i);
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.8,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0),
                    itemCount: cntProperties.arrProjectHeaderBlocList.isNotEmpty
                        ? cntProperties.arrProjectHeaderBlocList.length
                        : 0,
                  )
                : const SizedBox();
          } else {
            return ShimmerEffect(
                child: GridView.builder(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.only(left: 20, right: 20),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return Container(
                  padding: const EdgeInsets.only(top: 0, left: 20, right: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.greyColor,
                  ),
                  width: 50,
                  height: 100,
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2),
              itemCount: 4,
            ));
          }
        },
        future: cntProperties.futureHeaderBlockList.value,
      ),
    );
  }

  Widget _generateProjectBlock1(int index) {
    return Container(
      width: 120.w,
      height: 120.h,
      decoration: CustomDecorations().backgroundLocal(
          AppColors.whiteColor, 6, 1, AppColors.lightGreyColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(cntProperties.arrProjectHeaderBlocList[index].title ?? "",
              style: boldTextStyle(
                  txtColor: AppColors.maiGreyColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 10)),
          const SizedBox(
            height: 3,
          ),
          Text(cntProperties.arrProjectHeaderBlocList[index].subTitle ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.newBlack,
                  fontSize: 12.sp,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w400))
        ],
      ),
    );
  }

  Widget projectDescriptionData() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Project Description",
                style: boldTextStyle(
                    txtColor: AppColors.labelGreyColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 12),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: HorizontalDivider(
                      color: AppColors.lightGreyColor, height: 1))
            ],
          ),
          const SizedBox(height: 12),
          Text(
            projectDescription,
            style: mediumTextStyle(
                txtColor: AppColors.newBlack,
                fontWeight: FontWeight.w400,
                fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget overViewSectionListData() {
    return ListView.builder(
      itemCount: cntProperties.arrOverViewList.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Obx(() => _overViewSectionList(index));
      },
    );
  }

  Widget _overViewSectionList(int index) {
    OverViewModel objOverView = cntProperties.arrOverViewList[index];
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Project Description",
                  style: boldTextStyle(
                      txtColor: AppColors.labelGreyColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 12),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: HorizontalDivider(
                        color: AppColors.lightGreyColor, height: 1))
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Text(
              "Home Loans",
              style: mediumTextStyle(
                  txtColor: AppColors.newBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 65,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(right: 10, left: 18),
              shrinkWrap: true,
              children: [
                for (int i = 0; i < objOverView.homeList!.length; i++)
                  Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: AppColors.black.withOpacity(0.05),
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: const Offset(0, 3))
                      ]),
                      child: Image.asset(objOverView.homeList![i].toString()))
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Construction Status",
                  style: mediumTextStyle(
                      txtColor: AppColors.newBlack,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  objOverView.constructionStatus ?? "",
                  style: mediumTextStyle(
                      txtColor: AppColors.newBlack,
                      fontWeight: FontWeight.w400,
                      fontSize: 10),
                ),
                const SizedBox(height: 12),
                Text(
                  "Project Location",
                  style: mediumTextStyle(
                      txtColor: AppColors.newBlack,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  objOverView.projectLocation ?? "",
                  style: mediumTextStyle(
                      txtColor: AppColors.newBlack,
                      fontWeight: FontWeight.w400,
                      fontSize: 10),
                ),
                const SizedBox(height: 12),
                Text(
                  "RERA",
                  style: mediumTextStyle(
                      txtColor: AppColors.newBlack,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
                const SizedBox(height: 8),
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (int i = 0; i < objOverView.reRaList!.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: RichText(
                          text: TextSpan(
                              text: objOverView.reRaList![i].toString(),
                              style: mediumTextStyle(
                                  txtColor: AppColors.newBlack,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10),
                              children: [
                                TextSpan(
                                  text: " (ReraCertificate)",
                                  style: mediumTextStyle(
                                      txtColor: AppColors.appThemeColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10),
                                ),
                              ]),
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Text(
              "Brochure",
              style: mediumTextStyle(
                  txtColor: AppColors.newBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 135,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(right: 10, left: 20),
              shrinkWrap: true,
              children: [
                for (int i = 0; i < objOverView.brochureList!.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                      children: [
                      Container(
                        height: 107.w,
                        width: 190.w,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                            BoxShadow(
                                color: AppColors.black.withOpacity(0.05),
                                spreadRadius: 0,
                                blurRadius: 6,
                                offset: const Offset(0, 3))
                          ]),
                          child:
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  objOverView.brochureList![i].toString(),
                                  height: 107.w,
                                  width: 190.w,
                                ),
                              ),

                            ),
                        Positioned(
                          top: 10,
                          right: 18,
                          child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(3.6),
                              ),
                              child: SvgPicture.asset(fileDownloadSvgIcons)),
                        )
                      ],
                      ),
                      const SizedBox(height: 5),
                      Text("${"Brochure "}${i.toString()}",style: mediumTextStyle(fontSize: 10,fontWeight: FontWeight.w400,txtColor: AppColors.newBlack),)
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget connectivityData(){
    return Padding(
      padding: const EdgeInsets.only(right: 20,left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Connectivity",
                style: boldTextStyle(
                    txtColor: AppColors.labelGreyColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 12),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: HorizontalDivider(
                      color: AppColors.lightGreyColor, height: 1))
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.whiteColor,width: 1.66),
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  offset: const Offset(0, 4.9),
                  blurRadius: 9.9,
                  spreadRadius: 0
                )
              ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                height: 185.w,
                width: Get.width,
                placeholder: (context, url) => shimmerWidget(
                  height: 185.w,
                  width: Get.width,
                ),
                fadeInDuration: Duration.zero,
                fadeOutDuration: Duration.zero,
                placeholderFadeInDuration: Duration.zero,
                imageUrl:projectPngImage,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return Image.asset(
                    projectPngImage,
                    height: 185.w,
                    width: Get.width,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget gallerySection() {
    return Obx(() => FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          if (cntProperties.arrGalleryList != "") {
            return Obx(() =>cntProperties.arrGalleryList.isNotEmpty
                ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 16),
                    child: Row(
                      children: [
                        Text(
                            "Gallery".toUpperCase(),
                            style: TextStyle(
                                color: AppColors.labelGreyColor,
                                fontSize: 12.sp,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Container(
                            height: 1.h,
                            width: Get.width,
                              color: AppColors.lightGreyColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  galleryDataGridView()
                ])
                : const SizedBox());
          } else {
            return const Text("No Data Found");
          }
        } else {
          return galleryShimmer();
          // return Container();
        }
      },
      future: cntProperties.futureGalleryProjectList.value,
    ));
  }

  Widget galleryDataGridView() {
    return Obx(() => cntProperties.arrGalleryList != null
        ? GridView.builder(
      itemCount:
      cntProperties.arrGalleryList.length >
              5
          ? 6
          : 0,
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 20, right: 20),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          focusColor: AppColors.transParent,
          highlightColor: AppColors.transParent,
          hoverColor: AppColors.transParent,
          splashColor: AppColors.transParent,
          onTap: () {
            if (index != 5) {
              // Get.to(() => FullImageViewPage(
              //     title: cntProjectDetails.obj_svprojectdetails.value
              //         .gallery?.gallerydata?[index].name,
              //     list: cntProjectDetails.gallerylist,
              //     index: index));
            }
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  width: 120.w,
                  height: 120.h,
                  fadeInDuration: Duration.zero,
                  fadeOutDuration: Duration.zero,
                  placeholderFadeInDuration: Duration.zero,
                  placeholder: (context, url) => shimmerWidget(
                      width: 120.w, height: 120.h, radius: 8),
                  imageUrl: cntProperties.arrGalleryList[index].image ??
                      "",
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      cntProperties.arrGalleryList[index].image ??
                          "",
                    );
                  },
                ),
              ),
              Positioned(
                  child: index == 5
                      ? InkWell(
                    onTap: () {
                      // Get.to(() => const ProjectGalleryScreen());
                    },
                    child: Container(
                      width: 120.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(6),
                          color: AppColors.appThemeColor.withOpacity(0.4)),
                      child: Center(
                          child: Text(
                            "${"+"}${cntProperties.arrGalleryList.length - 6}",
                            style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: fontFamily),
                          )),
                    ),
                  )
                      : const SizedBox())
            ],
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8,
      ),
    )
        : const SizedBox());
  }

  Widget locationSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Location",
                  style: TextStyle(
                      color: AppColors.labelGreyColor,
                      fontSize: 12.sp,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w700)),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Container(
                  height: 1.h,
                  width: Get.width,
                  color: AppColors.lightGreyColor,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              googleMap(),
            ],
          ),
        ],
      ),
    );
  }

  Widget googleMap() {
    cntProperties.currentLocation = LatLng(19.262224, 72.9565016);
    // print(currentLocation);
    // print("currentLocation123");
    return Container(
      height: 185.w,
      width: Get.width,
      decoration: CustomDecorations().backgroundLocal(AppColors.lightGreyColor, 6, 2.5, AppColors.whiteColor),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: GoogleMap(
          gestureRecognizers: Set()
            ..add(Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer()))
            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
            ..add(
                Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
            ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
            ..add(Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer())),
          initialCameraPosition: CameraPosition(
              target: cntProperties.currentLocation, zoom: 10),
          // markers: Set<Marker>.of(markerValue.values),
          markers: cntProperties.markers,
          zoomControlsEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            cntProperties.googleMapController = controller;
          },
        ),
      ),
    );
  }

  Widget amenitiesSection() {
    return Obx(() => FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return  Padding(
            padding:
            const EdgeInsets.only(left: 0, right: 0, top: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20,left: 20),
                  child: Row(
                    children: [
                      Text("Amenities",
                          style: TextStyle(
                              color: AppColors.labelGreyColor,
                              fontSize: 12.sp,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w700)),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Container(
                          height: 1.h,
                          // margin: EdgeInsets.only(right: 30),
                          width: Get.width,
                          color: AppColors.lightGreyColor,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                          "${cntProperties.arrAmenitiesList.length - 1}+",
                          style: TextStyle(
                              color: AppColors.labelGreyColor,
                              fontSize: 12.sp,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                amenitiesData()
              ],
            ),
          );
        } else {
          return ShimmerEffect(
            child: SizedBox(
              height: 185.h,
              width: Get.width,
              child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                padding:
                const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 150,
                    height: 50,
                    margin: const EdgeInsets.only(right: 10, bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.appGreyColor,
                    ),
                  );
                },
                physics: const ScrollPhysics(),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 0.4),
                itemCount: 12,
              ),
            ),
          );
          // return Container();
        }
      },
      future: cntProperties.futureArrAmenitiesList.value,
    ));
  }

  Widget amenitiesData() {
    return SizedBox(
      height: 185.h,
      width: Get.width,
      child: GridView.builder(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.only(right: 20,left: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Obx(() => _amenitiesData(index));
        },
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
            crossAxisCount: 3, childAspectRatio: 0.4),
        itemCount:
        cntProperties.arrAmenitiesList != null &&
            cntProperties.arrAmenitiesList != null &&
            cntProperties.arrAmenitiesList.length != 0
            ? cntProperties.arrAmenitiesList.length
            : 0,
      ),
    );
  }

  Widget _amenitiesData(int index) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 12),
      decoration:
      CustomDecorations().backgroundLocal(AppColors.whiteColor, 6, 1, AppColors.lightGreyColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 12.w),
          Container(
            alignment: Alignment.center,
            child: cntProperties.arrAmenitiesList[index].image
                .toString()
                .contains("svg")
                ? SvgPicture.asset(
              cntProperties.arrAmenitiesList[index].image ??
                  "",
              width: 28.w,
              height: 28.w,
            )
                : Image.network(
              cntProperties.arrAmenitiesList[index].image ??
                  "",
              width: 28.w,
              height: 28.w,
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: 100.h,
            child: Text(
              cntProperties.arrAmenitiesList[index].title ??
                  "",
              style: mediumTextStyle(fontSize: 11, txtColor: hex("707070")),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget siteProgressSection() {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 14, right: 20),
                  child: Row(
                    children: [
                      Text("Site Progress",
                          style: TextStyle(
                              color: AppColors.labelGreyColor,
                              fontSize: 12.sp,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w700)),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Container(
                          height: 1.h,
                          width: Get.width,
                          color: AppColors.lightGreyColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.w),
                siteProgressBlock(),
              ],
            );
        } else {
          return ShimmerEffect(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                height: 170,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  padding:
                  const EdgeInsets.only(left: 20, right: 8, bottom: 0, top: 0),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 8, bottom: 0, top: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(right: 8),
                              height: 128.h,
                              width: 190.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.appGreyColor,
                              ))
                        ],
                      ),
                    );
                  },
                ),
              ));
        }
      },
      future: cntProperties.futureHeaderBlockList.value,
    );
  }

  Widget siteProgressBlock() {
    return Container(
      margin: const EdgeInsets.only(
        top: 0,
      ),
      height: 130.w,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: cntProperties.arrSiteProgressList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
                left: index == 0 ? 20 : 10,
                right: (cntProperties.arrSiteProgressList.length)! -
                    1 ==
                    index
                    ? 20
                    : 0,
                bottom: 0,
                top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  focusColor: AppColors.transParent,
                  highlightColor: AppColors.transParent,
                  hoverColor: AppColors.transParent,
                  splashColor: AppColors.transParent,
                  onTap: () {},
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: CachedNetworkImage(
                          width: 190.w,
                          height: 107.w,
                          fadeInDuration: Duration.zero,
                          fadeOutDuration: Duration.zero,
                          placeholderFadeInDuration: Duration.zero,
                          imageUrl: cntProperties.arrSiteProgressList[index].image ?? "",
                          placeholder: (context, url) => shimmerWidget(
                              width: 190.w, height: 107.w, radius: 7),
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return Image.asset(
                              width: 190.w,
                              height: 107.w,
                              fit: BoxFit.cover,
                              cntProperties.arrSiteProgressList[index].image ?? "",
                            );
                          },
                        ),
                      ),
                      Positioned(
                          left: 8.w,
                          bottom: 10.w,
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                                color: AppColors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(6)),
                            child: Text(
                                  "12/12/2022",
                              style: TextStyle(
                                  fontFamily: fontFamily,
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 9.sp),
                            ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  cntProperties.arrSiteProgressList[index].title ?? "",
                  style: TextStyle(
                      fontFamily: fontFamily,
                      color: AppColors.newBlack,
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget planLayoutSection() {
    LayoutModal? layoutList;
    layoutList = cntProperties.obj_svprojectdetails.value.layout;
    final seen = <String>{};
    final unique = layoutList?.layoutdata
        ?.where((str) => seen.add(str.layouttype.toString()))
        .toList();
    return SizedBox(
        width: double.infinity,
        child: Obx(()=>FutureBuilder(
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                !snapshot.hasError &&
                snapshot.data != null) {
              if (cntProperties.obj_svprojectdetails.value.layout != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                                  "Layouts",
                              style: TextStyle(
                                  color: AppColors.labelGreyColor,
                                  fontSize: 12.sp,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Container(
                              height: 1.h,
                              // margin: EdgeInsets.only(right: 30),
                              width: Get.width,
                              color: AppColors.lightGreyColor,
                            ),
                          ),
                          Obx(() => SizedBox(
                            height: 40,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 1, left: 8, top: 8, bottom: 8),
                                child: ToggleButtons(
                                  borderColor: AppColors.appThemeColor,
                                  fillColor: AppColors.appThemeColor,
                                  borderWidth: 0,
                                  selectedBorderColor: AppColors.appThemeColor,
                                  selectedColor: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(5),
                                  onPressed: (int indexMain) {
                                    cntProperties.isSelected.value = [];
                                    unique
                                        .asMap()
                                        .forEach((index2, element) {
                                      if (indexMain == index2) {
                                        cntProperties.isSelected
                                            .add(true);
                                        cntProperties
                                            .layoutString.value =
                                            element.layouttype.toString();
                                      } else {
                                        cntProperties.isSelected
                                            .add(false);
                                      }
                                    });
                                  },
                                  isSelected: cntProperties.isSelected,
                                  children: unique!.map((e) {
                                    return Obx(() => Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 3.0),
                                      child: Text(
                                        e.layouttype ?? "",
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: cntProperties
                                                .layoutString
                                                .value ==
                                                e.layouttype
                                                ? AppColors.whiteColor
                                                : AppColors.appThemeColor,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: fontFamily),
                                      ),
                                    ));
                                  }).toList(),
                                )),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    planLayoutBlock(),
                  ],
                );
              } else {
                return const SizedBox();
              }
              //return LeadShimmerWidget();
            } else {
              return const SizedBox();
            }
          },
          future: cntProperties.futureArrProjectList.value,
        )));
  }

  Widget planLayoutBlock() {
    return Obx(() => SizedBox(
      height: 110.h,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: cntProperties
            .obj_svprojectdetails.value.layout?.layoutdata?.length,
        // plan_layout.length,
        itemBuilder: (context, index) {
          return Obx(() => cntProperties.layoutString.value ==
              cntProperties.obj_svprojectdetails.value.layout!
                  .layoutdata![index].layouttype
              ? Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 0, top: 0),
              child: InkWell(
                onTap: () {

                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: CachedNetworkImage(
                    height: 110.w,
                    width: 190.h,
                    fadeInDuration: Duration.zero,
                    fadeOutDuration: Duration.zero,
                    placeholderFadeInDuration: Duration.zero,
                    imageUrl: cntProperties.obj_svprojectdetails
                        .value.layout!.layoutdata![index].icon ??
                        "",
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return Image.network(
                        cntProperties.plan_layout[index].toString(),
                        height: 110.h,
                        width: 190.w,
                      );
                    },
                  ),
                ),
              ))
              : Container());
        },
      ),
    ));
  }

  Widget siteVisitData([bool isshow=false]) {
    return Obx(() =>  Padding(
      padding:  const EdgeInsets.only(left: 20.0,right: 20,top: 0,bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Schedule a Site Visit",
                  style: TextStyle(
                      color: AppColors.labelGreyColor,
                      fontSize: 12.sp,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w700)),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  height: 1.h,
                  width: Get.width,
                  color: AppColors.lightGreyColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 6,
                  offset: const Offset(
                      0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 0, right: 0),
                  child: Form(
                    key: cntProperties.siteVisitFormKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        simpleTextFieldNewWithCustomization(
                          inputFormat: [
                            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                            UpperCaseTextFormatter()],
                          hintText: "John",
                          // imageIcon: IMG_USER_SVG_NEW,
                          textCapitalization: TextCapitalization.sentences,
                          controller: cntProperties.txtFirstNameNew,
                          textInputType: TextInputType.name,
                          labelText: "First Name*",
                          maxLength: 72,
                          noAutoValidation: true,
                          validator: (value) =>
                              validation(value, "Please enter first name"),


                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        simpleTextFieldNewWithCustomization(
                            hintText: "Doe",
                            inputFormat: [
                              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                              UpperCaseTextFormatter()],
                            maxLength: 72,
                            noAutoValidation: true,
                            // imageIcon: IMG_USER_SVG_NEW,
                            textCapitalization: TextCapitalization.sentences,
                            controller: cntProperties.txtLastNameNew,
                            textInputType: TextInputType.name,
                            labelText: "Last Name*",
                            validator: (value) =>
                                validation(value, "Please enter last name")),
                        const SizedBox(height: 16,),
                        simpleTextFieldNewWithCustomization(
                            hintText: "email@example.com",
                            // imageIcon: IMG_EMAIL_SVG_NEW,
                            controller: cntProperties.txtEmailNew,
                            textInputType: TextInputType.emailAddress,
                            labelText: "Email*",
                            noAutoValidation: true,
                            inputFormat: [
                              FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@.]")),
                            ],
                            validator: (value) => emailvalidation(value)),
                        const SizedBox(
                          height: 16,
                        ),
                        //ContactTextField(txtContactNew),
                        phoneNumberTextField(cntProperties.txtContactNew),
                        const SizedBox(
                          height: 16,
                        ),
                        CommonDropDownTextField(
                          labelText: "Project*",

                          onTap: () {
                            if(isshow==true){
                              // SelectProject();
                            }
                          },
                          // imageIcon: IMG_PROJECT_SVG_DASHBOARD,
                          // imageIcon: IMG_PROJECT_SVG_NEW,
                          controller: cntProperties.txtProject,
                          hintText: "Select Project",
                        ),

                        const SizedBox(
                          height: 16,
                        ),
                        CommonDropDownTextField(
                          labelText: "Budget*",
                          onTap: () {
                            // SelectBudget();
                          },
                          // imageIcon: IMG_DOLLAR_SVG,
                          // imageIcon: IMG_BUDGET_SVG_NEW,
                          controller: cntProperties.txtBudget,
                          hintText: "Select Budget",
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ScheduleSiteVisite(
                            IMG_DATE_SVG_NEW,
                            "Schedule Date*", "Select", cntProperties.txtScheduleDateNew),
                        const SizedBox(
                          height: 16,
                        ),
                        CommonDropDownTextField(
                            labelText: "Schedule Time*",
                            onTap: () {
                              selectTime_with_no2(contextCommon, 0, cntProperties.txtScheduleTimeNew);
                            },
                            // imageIcon: IMG_DOLLAR_SVG,
                            validator: (value) => validation(value, "Please select time"),
                            // imageIcon: IMG_BUDGET_SVG_NEW,
                            controller: cntProperties.txtScheduleTimeNew.value,
                            hintText: cntProperties.txtScheduleTimeNew.value?.text==""?"Select Time":""
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        QueryTextField_1(cntProperties.txtQueryNew),
                        // SizedBox(
                        //   height: 60,
                        // ),
                        SizedBox(
                          height: isshow?40:0,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                submitButton(),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget QueryTextField_1(Rxn<TextEditingController>? controller) {
    return Obx(() =>TextFormField(
      maxLines: 2,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@. ]")),
      ],

      controller: controller?.value,
      onChanged: (value){
        controller?.update((val) { });
      },
      style: boldTextStyle(fontSize: 16, txtColor: AppColors.black),
      decoration: InputDecoration(
        enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: AppColors.labelGreyColor)),
        focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: AppColors.labelGreyColor)),
        errorBorder:
        const UnderlineInputBorder(borderSide:  BorderSide(color: Colors.red)),
        disabledBorder:
        const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder:
        const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        // border: InputBorder.none,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: "Message",
        hintText: "",
        labelStyle: TextStyle(
            fontSize: 14.sp,
            color:AppColors.labelGreyColor,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500),
        hintStyle: TextStyle(color: AppColors.labelGreyColor),
        // contentPadding: EdgeInsets.all(20),


      ),
    ));
  }

  Widget submitButton() {
    return OnTapButton(
        onTap: () {
          if (cntProperties.siteVisitFormKey.currentState!.validate() ) {

          }
        },
        height: 40,
        decoration: CustomDecorations().backgroundLocal(AppColors.appThemeColor, 6, 0, AppColors.appThemeColor),
        text: "Submit".toUpperCase(),
        style: TextStyle(color: AppColors.whiteColor, fontSize: 12.sp, fontWeight: FontWeight.w500));
  }

  Widget projectShimmerWidget() {
    return Container();
  }
  Widget galleryShimmer() {
    return Container();
  }
}
