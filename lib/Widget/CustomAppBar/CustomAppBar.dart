
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Functions.dart';
import 'package:repeoplecp/Config/Utils/SizeConfig.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';

class dashBoardHeader extends StatefulWidget {
  const dashBoardHeader({super.key});

  @override
  _dashBoardHeaderState createState() => _dashBoardHeaderState();
}

class _dashBoardHeaderState extends State<dashBoardHeader> {
  // DashboardHeaderController cnt_DashboardHeader = Get.put(DashboardHeaderController());
  Rxn<dynamic> check=Rxn();
  @override
  void initState() {
    super.initState();
    // cnt_DashboardHeader.ListOfHedaer();
  }

  @override
  Widget build(BuildContext context) {
    return appBarHeader();
  }
  Widget appBarHeader(){
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
              boxShadow: [
                fullcontainerboxShadow
              ]
          ),
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
                          children:[
                            leadingIconOfAppbar()
                          ],
                        ),
                      ),
                      Positioned(
                        right: 7,
                        top: 5,
                        bottom: 5,
                        child: Row(
                          children: [
                            TrallingIconNotification(AppColors.appFontColor,

                            ),
                            SizedBox(width: 12,),
                            TrallingIconDrawer(imgMenu,AppColors.appFontColor,
                                    () => check.value.currentState!.openEndDrawer()
                            )
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
  late final String title;
  late final double height;
  Color? color;
  List<Widget>? leadingWidget;
  List<Widget>? trillingWidget;

  CustomDetailsAppBar(
      {required this.title,
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
        color: widget.color /*== null ? Colors.white : widget.color*/,
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