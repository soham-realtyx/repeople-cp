import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/functions.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/HomeController/home_controller.dart';

class DashBoardHeader extends StatefulWidget {
  const DashBoardHeader({super.key});

  @override
  _DashBoardHeaderState createState() => _DashBoardHeaderState();
}

class _DashBoardHeaderState extends State<DashBoardHeader> {
  HomeController cntHome = Get.put(HomeController());
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());

  @override
  void initState() {
    super.initState();
    // cnt_DashboardHeader.ListOfHedaer();
  }

  @override
  Widget build(BuildContext context) {
    return appBarHeader();
  }

  void openDrawer() {
    // _scaffoldKey.currentState?.openDrawer();
    cntCommonHeader.check.value.currentState?.openEndDrawer();
  }

  Widget appBarHeader() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          //color: APP_GRAY_COLOR,
          height: 70.w,
          width: Get.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.0),
              boxShadow: [fullcontainerboxShadow]),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 20,
                        top: 5,
                        bottom: 5,
                        child: Row(
                          children: [leadingIconOfAppbar()],
                        ),
                      ),
                      Positioned(
                        right: 7,
                        top: 5,
                        bottom: 5,
                        child: Row(
                          children: [
                            trailingIconNotification(AppColors.appFontColor,
                                notificationIcon: notificationSvgIcons),
                            const SizedBox(width: 12),
                            trailingIconDrawer(imgMenu, AppColors.appFontColor,
                                () => cntCommonHeader.check.value.currentState?.openEndDrawer())
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDetailsAppBar extends StatefulWidget {
   final String title;
   final double height;
  final Color? color;
  final List<Widget>? leadingWidget;
  final List<Widget>? trillingWidget;

  const CustomDetailsAppBar(
      {super.key, required this.title,
      required this.height,
      this.leadingWidget,
      this.trillingWidget,
      this.color});

  @override
  _CustomDetailsAppBarState createState() => _CustomDetailsAppBarState();
}

class _CustomDetailsAppBarState extends State<CustomDetailsAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [fullcontainerboxShadow],
        color: widget.color/*== null ? Colors.white : widget.color*/,
      ),
      height: widget.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: widget.leadingWidget!,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: widget.trillingWidget!,
            ),
          )
        ],
      ),
    );
  }
}
