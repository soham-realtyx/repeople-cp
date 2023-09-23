import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';

import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  GlobalKey<ScaffoldState> globalFavouritePageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
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
                  SizedBox(height: appBarHeight),

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
}
