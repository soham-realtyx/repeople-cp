import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Model/ProjectListModel/project_list_model.dart';

class FavouriteController extends GetxController{

  RxList<ProjectListModel> arrFavoriteList = RxList([]);
  Rx<Future<List<ProjectListModel>>> futureFavourite =
      Future.value(<ProjectListModel>[]).obs;

  CarouselController controllerEvent = CarouselController();

  RxInt current = 0.obs;
  
  Future<RxList<ProjectListModel>> getFavouriteList()async{
    arrFavoriteList = RxList([]);
    arrFavoriteList.add(ProjectListModel(
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
    arrFavoriteList.add(ProjectListModel(
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
    return arrFavoriteList;
  }
}