import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Helper/HexColor.dart';
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
import 'package:repeoplecp/View/HomePage/HomePage.dart';
import 'package:repeoplecp/View/PropertiesDetailsPage/PropertiesDetailsPage.dart';
import 'package:repeoplecp/Widget/CustomBoxDecoration.dart';
import 'package:repeoplecp/Widget/ShimmerWidget/ShimmerWidget.dart';

class PropertiesPage extends StatefulWidget {
  const PropertiesPage({super.key});

  @override
  State<PropertiesPage> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  PropertiesController cntProperties = Get.put(PropertiesController());
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  GlobalKey<ScaffoldState> globalPropertiesPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    cntProperties.trendingData();

    cntProperties.getProjectList();
    cntProperties.getProjectDetailsList();
    cntProperties.isTrending.value=cntProperties.arrTrendingList.length;
    BottomNavigationBarPage().selectedIndex=3;
  }
  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
      onWillPop: ()async{
        BottomNavigationBarPage().selectedIndex=3;
        Get.offAll(const HomePage());
        return false;
      },
      child:
      Scaffold(
        backgroundColor: AppColors.whiteColor,
        key: globalPropertiesPageKey,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: appBarHeight),
                    projectListLabel(),
                    const SizedBox(height: 16),
                    searchProjectTextField(),
                    const SizedBox(height: 16),
                    trendingData(),
                    const SizedBox(height: 60),
                    projectListData(),
                  ],
                ),
              ),
              cntCommonHeader.commonAppBar(
                  "Projects", globalPropertiesPageKey,
                  isMenuIconHide: true
              )
            ],
          ),

        ),
        bottomNavigationBar:  BottomNavigationBarPage(selectedIndex: 3),
      ),
    );
  }

  Widget projectListLabel() {
    return Container(
      // color: LIGHT_GRAY_COLOR,
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
      child: RichText(
        text: TextSpan(
            text: "Hello,",
            style: regularTextStyle(txtColor: AppColors.newBlack, fontSize: 21),
            children: <TextSpan>[
              TextSpan(
                  text: '\n$lblProjectListLabel ',
                  style:
                  boldTextStyle(txtColor: AppColors.newBlack, fontSize: 24)),
            ] // children:
        ),
      ),
    );
  }

  Widget searchProjectTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Autocomplete<ProjectListModel>(
        optionsBuilder: (value) {
          List<ProjectListModel> filter = [];
          if (value.text.isNotEmpty) {
            cntProperties.onSearchTextChanged(value.toString());
            filter = cntProperties.arrProjectList
                .where((element) => element.projectTitle!
                .toLowerCase()
                .contains(value.text.toLowerCase()))
                .toList();
          }
          return filter;
        },
        displayStringForOption: (ProjectListModel value) => value.projectTitle!,
        initialValue: TextEditingValue.empty,
        onSelected: (value) {
          cntProperties.onSearchTextChanged(value.projectTitle.toString());
        },
        optionsMaxHeight: Get.height / 3,
        fieldViewBuilder: (context, textController, focusNode, onSubmit) {
          return Container(
            decoration: BoxDecoration(boxShadow: [newContainerBoxShadow]),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              child: TextField(
                controller: textController,
                focusNode: cntProperties.fcmSearch,
                onSubmitted: (value) {
                  cntProperties.onSearchTextChanged(value);
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onChanged: (value) {
                  cntProperties.onSearchTextChanged(value);
                },
                onEditingComplete: () {
                  cntProperties.onSearchTextChanged(textController.text);
                },
                onTap: () {
                  cntProperties.onSearchTextChanged(textController.text);
                },
                decoration: InputDecoration(
                    hintText: 'Search here',
                    hintStyle: regularTextStyle(
                        txtColor: HexColor("#333333"),
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                        left: 10, right: 20, top: 15, bottom: 15),
                    suffixIcon: InkWell(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          MediaQuery.of(context).viewInsets.bottom != 0.0
                              ? FocusManager.instance.primaryFocus?.unfocus()
                              : FocusManager.instance.primaryFocus
                              ?.requestFocus(cntProperties.fcmSearch);
                          cntProperties.onSearchTextChanged(textController.text);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            height: 28,
                            width: 28,
                            decoration: CustomDecorations().backgroundLocal(
                                AppColors.appThemeColor,
                                6,
                                0,
                                AppColors.appThemeColor),
                            child: SvgPicture.asset(
                              searchSvgIcons,
                              color: AppColors.whiteColor,
                            )))),
                cursorColor: Colors.black54,
              ),
            ),
          );
        },
        optionsViewBuilder: (context, function, list) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              child: Container(
                // padding: EdgeInsets.only(top: 0),
                height: Get.height / 3,
                width: Get.width - 40,
                decoration: BoxDecoration(
                  // boxShadow: [boxShadow],
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.whiteColor),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        list.elementAt(index).projectTitle!,
                        style: regularTextStyle(
                            txtColor: HexColor("#b4b4b4"), fontSize: 14),
                      ),
                      onTap: () {
                        function(list.elementAt(index));
                        cntProperties.onSearchTextChanged(list.elementAt(index).projectTitle!);
                      },
                    );
                  },
                  itemCount: list.length,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget trendingData() {
    return Container(
      padding: const EdgeInsets.only(top: 16,bottom: 11,left: 20,right: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Obx(() => Wrap(
          spacing: 8.0,
          runSpacing: 5.0,
          direction: Axis.horizontal,
          children: List.generate(
            cntProperties.arrTrendingList.length+1,
                (i) {

              if(i==0){
                return  GestureDetector(
                  onTap: (){
                    cntProperties.isTrending.value = i-1;
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(mapSearchSvgIcons),
                      Text(
                        "Trending",
                        style: TextStyle(
                            color: AppColors.labelGreyColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                            fontFamily: fontFamily),
                      ),
                      const SizedBox(width: 0),
                    ],
                  ),
                );
              }else{
                return _trendingChildList(i-1);
              }
            },

          ),
        )),
      ),
    );
  }

  Widget _trendingChildList(int i){
    return GestureDetector(
      onTap: (){
        cntProperties.isTrending.value = i;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          color: cntProperties.isTrending.value==i?AppColors.appThemeColor:null,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border:  Border.all(
            color: AppColors.labelGreyColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                cntProperties.arrTrendingList[i].title??"",
                style: TextStyle(
                    color: cntProperties.isTrending.value==i?AppColors.whiteColor:AppColors.labelGreyColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    fontFamily: fontFamily),
              ),
            ),
            SvgPicture.asset(rightArrowSvgIcons,color: cntProperties.isTrending.value==i?AppColors.whiteColor:AppColors.labelGreyColor,)
          ],
        ),
      ),
    );
  }

  Widget projectListData() {
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
                    itemCount: cntProperties.arrProjectList.length,
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
      future: cntProperties.futureArrProjectList.value,
    ));
  }

  Widget _generateProjectListData1(int index) {
    ProjectListModel obj = cntProperties.arrProjectList[index];
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
                      carouselController: cntProperties.controllerEvent,
                      itemCount: obj.projectImageList?.length,
                      itemBuilder: (context, index2, realIndex) {
                        return InkWell(
                          onTap: () {
                          },
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
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: Get.width,
                      height: 136.w,
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
                                      horizontal: 8.h, vertical: 6.w),
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
                          Positioned(
                            bottom: 0,
                            // alignment: Alignment.bottomCenter,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -45,
            // alignment: Alignment.topCenter,
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
              child: CachedNetworkImage(
                width: 60.w,
                height: 47.w,
                placeholder: (context, url) => shimmerWidget(
                    width: 60.w,
                    height: 47.w, radius: 10),
                fadeInDuration: Duration.zero,
                fadeOutDuration: Duration.zero,
                placeholderFadeInDuration: Duration.zero,
                imageUrl: obj.projectLogo ?? "",
                fit: BoxFit.fill,
                errorWidget: (context, url, error) {
                  return Image.asset(obj.projectLogo ?? "",
                      width: 60.w,
                      height: 47.w,
                      fit: BoxFit.fill);
                },
              ),
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
