import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/OfferController/offer_controller.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/bottom_navigationbar_page.dart';
import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  OfferController cntOffers = Get.put(OfferController());
  GlobalKey<ScaffoldState> globalAddTeamPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    BottomNavigationBarPage().selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: globalAddTeamPageKey,
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
                  const SizedBox(height: 80),
                  offerList(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            cntCommonHeader.commonAppBar("Offers", globalAddTeamPageKey,
                isMenuIconHide: true),
          ],
        ),
      ),
    );
  }

  Widget offerList(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider.builder(
          itemCount: cntOffers.offerList.length,
          itemBuilder: (context, index, realIndex) {
            return
              Padding(
                padding: const EdgeInsets.only(top: 0.0,right: 15),
                child: InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: (){

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1.5,color: AppColors.lightGreyColor)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:
                      CachedNetworkImage(
                        // placeholder: (context, url) => leadShimmerWidget(),
                        fadeInDuration: Duration.zero,
                        fadeOutDuration: Duration.zero,
                        placeholderFadeInDuration: Duration.zero,
                        imageUrl: cntOffers.offerList[index].toString(),
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return
                            Image.asset(
                              cntOffers.offerList[index].toString(),
                              width: Get.width,
                              fit: BoxFit.cover,
                            );
                        },
                      ),
                    ),
                  ),
                ),
              );
          },
          options: CarouselOptions(
              height: Get.height/1.5,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 2.0,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              // autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
              scrollDirection: Axis.horizontal,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index,_){
                cntOffers.current.value=index;
                cntOffers.current.refresh();
              }
          ),
          carouselController: cntOffers.controllerOffers,
        ),
        const SizedBox(height: 45),
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.appThemeColor.withOpacity(0.2)
            ),
            child: Center(child: SvgPicture.asset(homeShareSvgIcons)))
      ],
    );
  }
}
