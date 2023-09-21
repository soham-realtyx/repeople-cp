
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Model/ProjectListModel/ProjectListModel.dart';

class HomeController extends GetxController{

  GlobalKey<ScaffoldState> scaffoldHomeKey = GlobalKey<ScaffoldState>();
  RxList<DashBoardCountModel> arrCountList = RxList([]);
  RxList<ProjectListModel> arrProjectList = RxList([]);
  Rx<Future<List<ProjectListModel>>> futureArrProjectList =
      Future.value(<ProjectListModel>[]).obs;

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
}

class DashBoardCountModel{
  String? icons;
  Color? color;
  String? title;
  String? count;
  DashBoardCountModel({this.count,this.title,this.color,this.icons});
}