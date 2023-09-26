import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';

class AppUpgradePage extends StatefulWidget {
  String msg="";
  String versioncode="";
  bool forceUpdate=false;
  AppUpgradePage({super.key, required this.msg,required this.forceUpdate,required this.versioncode});

  @override
  State<AppUpgradePage> createState() => _AppUpgradePageState();
}

class _AppUpgradePageState extends State<AppUpgradePage> {
  String playStoreUrl = '';
  // _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: () async {
          if (widget.forceUpdate) {
            exit(0);
          } else {
            Navigator.pop(context);
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body:  SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 120.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // SizedBox(),
                      widget.forceUpdate!=true?InkWell(onTap: () {
                        setState(() {

                        });
                        Navigator.pop(context);
                      },child: SvgPicture.asset(closeSvgIcons,height: 24.w,width: 24.w,)):const SizedBox(),
                      const SizedBox(width: 20),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(child: 
                  SvgPicture.asset(rePeopleAppLogo,width: 200,height: 30,)
                  ),
                  const SizedBox(height: 30.0,),
                  SizedBox(width:250,child: Text(widget.msg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      fontSize: 17.0,
                    ),)) ,
                  const SizedBox(height: 20.0,),
                  const SizedBox(height: 180.0,child:   Center(child: Image(
                    image: AssetImage("assets/images/upgrade.png"),fit: BoxFit.scaleDown, height: 180,)),
                  ),
                  const SizedBox(height: 20.0,),
                  SizedBox(width:250,child: Text(
                    widget.versioncode,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      color: AppColors.black,
                      fontSize: 20.0,
                    ),)) ,



                  const SizedBox(height: 30.0,),
                  InkWell(onTap: (){
                    // _launchURL(RateApp());
                    print("app update");
                  },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF636363),
                              width: 2.0),
                          borderRadius: const BorderRadius.all(Radius.circular(13))
                      ),
                      height: 50.0,
                      width: 150.0,
                      child: Center(
                        child: Text('UPDATE NOW',style: TextStyle(
                            color: AppColors.black,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0
                        ),),
                      ),
                    ),
                  ),


                ],
              ),

            ),
          ),

        ));
  }
}
