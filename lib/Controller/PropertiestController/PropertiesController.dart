
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Model/ProjectListModel/ProjectListModel.dart';

class PropertiesController extends GetxController{


  RxList<TrendingModel> arrTrendingList = RxList<TrendingModel>();

  RxList<ProjectListModel> arrProjectList = RxList([]);
  RxList<ProjectListModel> arrProjectDetailsList = RxList([]);
  RxList<TrendingModel> arrProjectHeaderBlocList = RxList([]);
  RxList<TrendingModel> arrGalleryList = RxList([]);
  RxList<TrendingModel> arrSiteProgressList = RxList([]);
  RxList<OverViewModel> arrOverViewList = RxList([]);
  RxList<AmenitiesModel> arrAmenitiesList = RxList([]);
  Rx<Future<List<AmenitiesModel>>> futureArrAmenitiesList =
      Future.value(<AmenitiesModel>[]).obs;
  Rx<Future<List<ProjectListModel>>> futureArrProjectList =
      Future.value(<ProjectListModel>[]).obs;
  Rx<Future<List<ProjectListModel>>> futureArrProjectList2 =
      Future.value(<ProjectListModel>[]).obs;
  Rx<Future<List<TrendingModel>>> futureGalleryProjectList =
      Future.value(<TrendingModel>[]).obs;
  Rx<Future<List<TrendingModel>>> futureHeaderBlockList =
      Future.value(<TrendingModel>[]).obs;
  // Rx<Future<List<ProjectListModel>>> futureHeaderBlockList =
  //     Future.value(<ProjectListModel>[]).obs;

  Rx<ProjectListModel> obj_svprojectdetails = ProjectListModel().obs;

  CarouselController controllerEvent = CarouselController();
  TextEditingController txtSearch = TextEditingController();

  Rxn<TextEditingController> txtFirstNameNew = Rxn(TextEditingController());
  Rxn<TextEditingController> txtLastNameNew = Rxn(TextEditingController());
  Rxn<TextEditingController> txtEmailNew = Rxn(TextEditingController());
  Rxn<TextEditingController> txtContactNew = Rxn(TextEditingController());
  Rxn<TextEditingController> txtQueryNew = Rxn(TextEditingController());
  Rxn<TextEditingController> txtScheduleDateNew = Rxn(TextEditingController());
  Rxn<TextEditingController> txtScheduleTimeNew = Rxn(TextEditingController());
  TextEditingController txtProject = TextEditingController();
  TextEditingController txtBudget = TextEditingController();

  var siteVisitFormKey = GlobalKey<FormState>();
  FocusNode fcmSearch = FocusNode();

  RxInt current = 0.obs;

  RxInt isTrending = 0.obs;

  late LatLng currentLocation;
  MarkerId markerId = const MarkerId("Marker");
  bool smallScreen = Get.width <= 400;
  GoogleMapController? googleMapController;
  final Set<Marker> markers = Set();

  RxList<bool> isSelected=RxList();
  RxString layoutString='Initialized'.obs;

  Future<RxList<TrendingModel>> getGalleryData()async{
    arrGalleryList = RxList([]);
    arrGalleryList.add(TrendingModel(image: galleryPngImage));
    arrGalleryList.add(TrendingModel(image: galleryPngImage));
    arrGalleryList.add(TrendingModel(image: galleryPngImage));
    arrGalleryList.add(TrendingModel(image: galleryPngImage));
    arrGalleryList.add(TrendingModel(image: galleryPngImage));
    arrGalleryList.add(TrendingModel(image: galleryPngImage));
    return arrGalleryList;
  }

  Future<RxList<AmenitiesModel>> getAmenitiesData()async{
    arrAmenitiesList = RxList([]);
    arrAmenitiesList.add(AmenitiesModel(image: pavedWalkwaySvgIcons,title: "Paved Walkway"));
    arrAmenitiesList.add(AmenitiesModel(image: parkingSvgIcons,title: "Parking"));
    arrAmenitiesList.add(AmenitiesModel(image: fountainSvgIcons,title: "Fountain / Water Body at Entrance"));
    arrAmenitiesList.add(AmenitiesModel(image: acupressureSvgIcons,title: "Acupressure Walkway"));
    return arrAmenitiesList;
  }

  Future<RxList<TrendingModel>> getSiteProgressData()async{
    arrSiteProgressList = RxList([]);
    arrSiteProgressList.add(TrendingModel(image: projectPngImage,title: "2nd Phase Completed"));
    arrSiteProgressList.add(TrendingModel(image: projectPngImage,title: "2nd Phase Completed"));
    arrSiteProgressList.add(TrendingModel(image: projectPngImage,title: "1st Phase Completed"));
    arrSiteProgressList.add(TrendingModel(image: projectPngImage,title: "1st Phase Completed"));
    return arrSiteProgressList;
  }
  
  Future<List<TrendingModel>> trendingData() async {
    arrTrendingList = RxList([]);
    arrTrendingList.refresh();
    // arrTrendingList
    //     .add(TrendingModel(title: "Trending", image: rightArrowSvgIcons));
    arrTrendingList.add(
        TrendingModel(title: "White Field", image: rightArrowSvgIcons));
    arrTrendingList.add(
        TrendingModel(title: "Naagarabhaavi", image: rightArrowSvgIcons));
    arrTrendingList.add(TrendingModel(
        title: "Chandra Layout", image: rightArrowSvgIcons));
    arrTrendingList.add(
        TrendingModel(title: "Yeswanthpur", image: rightArrowSvgIcons));
    arrTrendingList.add(
        TrendingModel(title: "Koramangala", image: rightArrowSvgIcons));
    return arrTrendingList;
  }

  Future<List<TrendingModel>> projectHeaderBlocData() async {
    arrProjectHeaderBlocList = RxList([]);
    arrProjectHeaderBlocList.refresh();
    arrProjectHeaderBlocList.add(TrendingModel(title: "Status",subTitle: "New Launch"));
    arrProjectHeaderBlocList.add(TrendingModel(title: "Construction Status",subTitle: "Completed"));
    arrProjectHeaderBlocList.add(TrendingModel(title: "Possession Date",subTitle: "09/12/2023"));
    arrProjectHeaderBlocList.add(TrendingModel(title: "Legal",subTitle: "Contract, RERA"));
    return arrProjectHeaderBlocList;
  }

  Future<List<OverViewModel>> overViewData() async {
    arrOverViewList = RxList([]);
    arrOverViewList.refresh();
    arrOverViewList.add(OverViewModel(
        title: "",
        brochureList: [
          projectPngImage,
          projectPngImage
        ],
        constructionStatus: "1st Phase Completed",
        homeList: [
          homeLoansPngImage1,
          homeLoansPngImage2
        ],
        projectLocation: "Mylapore, Chennai, Tamil nadu",
        reRaList: [
          "P51500009541",
          "P51500009541",
        ]
    ));
    return arrOverViewList;
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
        projectTitle: "WorldHome Superstar",
      overViewList: [
        OverViewModel(
          title: "",
          brochureList: [
            brochurePngImage,
            brochurePngImage
          ],
          constructionStatus: "1st Phase Completed",
          homeList: [
            homeLoansPngImage1,
            homeLoansPngImage2
          ],
          projectLocation: "",
          reRaList: [
            "P51500009541 ${"(ReraCertificate)"}",
            "P51500009541 ${"(ReraCertificate)"}",
          ]
        )
      ]
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
        projectTitle: "WorldHome Superstar",
        overViewList: [
          OverViewModel(
              title: "",
              brochureList: [
                brochurePngImage,
                brochurePngImage
              ],
              constructionStatus: "1st Phase Completed",
              homeList: [
                homeLoansPngImage1,
                homeLoansPngImage2
              ],
              projectLocation: "",
              reRaList: [
                "P51500009541 ${"(ReraCertificate)"}",
                "P51500009541 ${"(ReraCertificate)"}",
              ]
          )
        ]
    ));

    return arrProjectList;
  }

  Future<RxList<ProjectListModel>> getProjectDetailsList()async{
    arrProjectDetailsList = RxList([]);
    arrProjectDetailsList.add(ProjectListModel(
      layout: LayoutModal(
        lable: "Project Layout",
        layoutdata: [
          LayoutDataModal(
            icon: layoutImagePngImage,
            layoutname: "Floor Plan",
            layouttype:  "Floor Plan",
          ),
          LayoutDataModal(
            icon: layoutImagePngImage,
            layoutname: "Layout Plan",
            layouttype:  "Layout Plan",
          ),
          LayoutDataModal(
            icon: layoutImagePngImage,
            layoutname: "Unit Plan",
            layouttype:  "Unit Plan",
          )
        ]
      ),
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
    // for(int i=0;i<arrProjectDetailsList.length;i++) {
      obj_svprojectdetails.value=arrProjectDetailsList[0];
      print(obj_svprojectdetails.value.layout?.lable);
      print("obj_svprojectdetails.value.address");
    // }
    return arrProjectDetailsList;
  }

  List<String> plan_layout = [
    "https://www.livehome3d.com/assets/img/articles/how-to-draw-a-floor-plan/floor-plan-of-a-house-with-a-pool.jpg",
    "https://wpmedia.roomsketcher.com/content/uploads/2022/01/06145940/What-is-a-floor-plan-with-dimensions.png",
    "https://cdn.shopify.com/s/files/1/2829/0660/products/Wynnchester-First-Floor_M_1200x.jpg",
    "https://www.homeplansindia.com/uploads/1/8/8/6/18862562/hfp-4005-ground-floor_orig.jpg",
  ];

  onSearchTextChanged(String text) async {
    print("text" + text);
    arrProjectList = RxList([]);
    if (text.isEmpty) {
      futureArrProjectList.value = getProjectList();
      return;
    }
    futureArrProjectList.value = getProjectList();
  }


}

class TrendingModel {
  String? image;
  String? title;
  String? subTitle;
  TrendingModel({this.title, this.image,this.subTitle});
}

class AmenitiesModel {
  String? image;
  String? title;
  String? subTitle;
  AmenitiesModel({this.title, this.image,this.subTitle});
}

