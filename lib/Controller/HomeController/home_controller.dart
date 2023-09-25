
import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Model/ProjectListModel/project_list_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class HomeController extends GetxController{

  GlobalKey<ScaffoldState> scaffoldHomeKey = GlobalKey<ScaffoldState>();
  RxList<DashBoardCountModel> arrCountList = RxList([]);
  RxList<ProjectListModel> arrProjectList = RxList([]);
  Rx<Future<List<ProjectListModel>>> futureArrProjectList =
      Future.value(<ProjectListModel>[]).obs;

  ScreenshotController screenshotController = ScreenshotController();

  CarouselController controllerEvent = CarouselController();

  RxInt current = 0.obs;

  Future <RxList<DashBoardCountModel>> getDashBoardCount()async{
    arrCountList = RxList([]);
    arrCountList.add(DashBoardCountModel(title: "Site Visit",color: AppColors.naviBlueColor,icons: mapPinSvgIcons,count: "118"));
    arrCountList.add(DashBoardCountModel(title: "EOI",color: AppColors.paleGreenColor,icons: creditCardSvgIcons,count: "2"));
    return arrCountList;
  }
  Future<RxList<ProjectListModel>> getProjectList()async{
    arrProjectList = RxList([]);
    arrProjectList.add(ProjectListModel(
      address: "White Field, Bengaluru",
      projectImageList: [
        projectPngImage,
        projectPngImage,
        projectPngImage
      ],
        configureList: [
          ConfigureModel(totalBHK: "1 BHK",totalRS: "₹ 40 Lac",onWords: "onwards"),
          ConfigureModel(totalBHK: "2 BHK",totalRS: "₹ 50 Lac",onWords: "onwards"),
          ConfigureModel(totalBHK: "3 BHK",totalRS: "₹ 60 Lac",onWords: "onwards"),
          ConfigureModel(totalBHK: "4 BHK",totalRS: "₹ 80 Lac",onWords: "onwards"),
          ConfigureModel(totalBHK: "5 BHK",totalRS: "Price On",onWords: "Request"),
        ],
      projectLogo: projectLogoPngImage,
      projectTitle: "WorldHome Superstar"
    ));
    arrProjectList.add(ProjectListModel(
        address: "White Field, Bengaluru",
        projectImageList: [
          projectPngImage,
          projectPngImage,
          projectPngImage
        ],
        configureList: [
          ConfigureModel(totalBHK: "1 BHK",totalRS: "₹ 40 Lac",onWords: "onwards"),
          ConfigureModel(totalBHK: "2 BHK",totalRS: "₹ 50 Lac",onWords: "onwards"),
          ConfigureModel(totalBHK: "3 BHK",totalRS: "₹ 60 Lac",onWords: "onwards"),
          ConfigureModel(totalBHK: "4 BHK",totalRS: "₹ 80 Lac",onWords: "onwards"),
          ConfigureModel(totalBHK: "5 BHK",totalRS: "Price On",onWords: "Request"),
        ],
        projectLogo: projectLogoPngImage,
        projectTitle: "WorldHome Superstar"
    ));
   return arrProjectList;
  }

  Future saveAndShare(Uint8List bytes, String title) async {
    final directory = await getApplicationSupportDirectory();
    final image = File('${directory.path}/logo.png');
    image.writeAsBytesSync(bytes);
    Share.share("Hello Repeople");
  }

  Widget shareBuildImage() => Screenshot(
      controller: screenshotController,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.0),
          color: Colors.white,
          border: Border.all(width: 1.0, color: Colors.white),
        ),
        child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
      ));

  Future shareData() async {
    final image = await screenshotController.captureFromWidget(shareBuildImage());
    saveAndShare(image, 'Repeople CP');
  }

}

class DashBoardCountModel{
  String? icons;
  Color? color;
  String? title;
  String? count;
  DashBoardCountModel({this.count,this.title,this.color,this.icons});
}