import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:repeoplecp/Config/Utils/SizeConfig.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/BottomNavigationBarController/BottomNavigationBarController.dart';
import 'package:repeoplecp/Model/DrawerModal/DrawerModal.dart';
import 'package:repeoplecp/View/EarningsPage/EarningsPage.dart';
import 'package:repeoplecp/View/FavoritePage/FavoritePage.dart';
import 'package:repeoplecp/View/HomePage/HomePage.dart';
import 'package:repeoplecp/View/LeadsPage/LeadsPage.dart';
import 'package:repeoplecp/View/OffersPage/OffersPage.dart';
import 'package:repeoplecp/View/PrivacyPolicyPage/PrivacyPolicyPage.dart';
import 'package:repeoplecp/View/PropertiesPage/PropertiesPage.dart';
import 'package:repeoplecp/View/SendOTPPage/SendOTPPage.dart';
import 'package:repeoplecp/View/TeamPage/TeamPage.dart';
import 'package:repeoplecp/Widget/CustomBoxDecoration.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef void OnTaplogoutbutton();

class CustomDrawerController extends GetxController {


  RxList<DrawerModal> arrNewDrawerList_1 = RxList<DrawerModal>();
  RxList<DrawerModal> arrNewDrawerList_2 = RxList<DrawerModal>();
  RxList<DrawerModal> arrNewDrawerOtherList = RxList<DrawerModal>();

  RxString lblVersion = "".obs;
  RxBool  isRegistered = false.obs;

  @override
  void onInit() async {
    super.onInit();
    NewDrawerListData_1();
    NewDrawerListData_2();
    OtherListData();
  }


  navigateScreen_1(int i){
    if(i==1){
       Get.to(()=>const HomePage());
    }else if(i==2){
      Get.to(()=>const FavoritePage());
    }else if(i==3){
      Get.to(()=>const OffersPage());
    }
  }

  navigateScreen_2(int i){
    if(i==0){
      Get.to(()=>const LeadsPage());
    }else if(i==1){
      Get.to(()=>const TeamPage());
    }else if(i==2){
      Get.to(()=>const PropertiesPage());
    }
  }

  navigateProjectScreen_1(int i){
    if(i==0){
      Get.to(()=>const PropertiesPage());
    }
  }

  navigateEmiCalculatorScreen_1(int i){
    if(i==3){
      Get.to(()=>const EarningsPage());
    }
  }

  String? loginClickData(){
    if(Is_Login.value==false) {
      "Login";
    }else if(isRegistered.value){
      "Link My Properties";
    }else{
      "My Properties";
    }
    return null;
  }
  
  NewDrawerListData_1() {
    arrNewDrawerList_1 = RxList([
      DrawerModal(
          title: "Projects",
          backColor: AppColors.whiteColor,
          images: projectImage,
          onTap: () {}),
      DrawerModal(
          title: "Dashboard",
          backColor: AppColors.dashBoardColor,
          images: dashBoardSvgIcon,
          onTap: () {Get.to(()=>const HomePage());}),
      DrawerModal(
          title: "Favourites",
          backColor: AppColors.favouriteColor,
          images: heartIconSvgIcons,
          onTap: () {}),
      DrawerModal(
          title: "Offers",
          backColor: AppColors.offersColor,
          images: offersSvgIcons,
          onTap: () { }),
    ]);
  }

  NewDrawerListData_2() {
    arrNewDrawerList_2 = RxList([
      DrawerModal(
          title: "Leads",
          backColor: AppColors.leadsColor,
          images: user2IconSvgIcons,
          onTap: () {}),
      DrawerModal(
          title: "Team",
          backColor: AppColors.teamsColor,
          images: heartHandshakeSvgIcons,
          onTap: () {}),
      DrawerModal(
          title: "Account",
          backColor: AppColors.accountColor,
          images: userSvgIcon,
          onTap: () {}),
      DrawerModal(
          title: "Earnings",
          backColor: AppColors.whiteColor,
          images: earningsImage,
          onTap: () {}),
    ]);
  }

  OtherListData(){
    arrNewDrawerOtherList = RxList([
      DrawerModal(
        onTap: (){NavigatePrivacyPolicy();},
        images: privacyPolicySvgIcons,
        title: "Privacy Policy",
      ),
      DrawerModal(
        onTap: (){NavigateTermCondition();},
        images: reportSvgIcons,
        title: "Terms & Conditions",
      ),
      DrawerModal(
        onTap: (){},
        images: contactSvgIcons,
        title: "Technical Query",
      ),
      DrawerModal(
        onTap: (){

        },
        images: versionSvgIcons,
        // title:  "v" + lblVersion.value,
          lblVersion: Obx(() => Text(
            "${"v"} ${lblVersion.value.toString()}",
            style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black
            ),
          ))
      ),
      DrawerModal(
        onTap: (){
          },
        images: logOutSvgIcons,
        title: "Logout",
      )
    ]);
  }

  //</editor-fold>

  //<editor-fold desc = "Navigation Handler">

 /* NavigationHandler(int index) {
    Get.back();
    MenuItemModel obj = arrDrawerListTile[index];
    switch (obj.alias) {
      case LOGIN_SIGNUP_APPMENUNAME:
        NavigateLoginSignupPage();
        break;
      case PROJECTMENU:
        NavigateProjectPage();
        break;
      case FAVORITE_APPMENUNAME:
        NavigateFavoritePage();
        break;
      case REFER_FRIEND_APPMENUNAME:
        NavigateReferAFriendPage();
        break;
      case OFFER_APPMENUNAME:
        NavigateOfferPage();
        break;
      case SCHEDULE_SITE_VISIT_APPMENUNAME:
        NavigateScheduleASiteVistPage();
        break;
      case EMI_CALCULATOR_APPMENUNAME:

        NavigateEMICalculatorPage();
        break;
      case NEWS_APPMENUNAME:
        NavigateNewsPage();
        break;
      case AWARDS_APPMENUNAME:
        NavigateAwardsPage();
        break;
      case REFERRAL_APPMENUNAME:
        NavigateReferralPage();
        break;
      case TECHNICAL_QUERY_APPMENUNAME:
        NavigateTechnicalQueryPage();
        break;
      case ABOUT_APPMENUNAME:
        NavigateAboutPage();
        break;
      case CONTACT_APPMENUNAME:
        NavigateContactPage();
        break;
      case MANAGER_ACCOUNT:
        NavigateManagerAccount();
        break;
      case MANAGER_LOGIN:
        NavigateManagerLogin();
        break;
      case CUSTOMER_LOGIN:
        NavigateCustomerLogin();
        break;
      case CUSTOMER_SWITCH:
        SwitchtoCustomer();
        break;
      case MANAGER_SWITCH:
        SwitchtoManager();
        break;
    }
  }*/

 /* NavigationDrawerHandler(int index) {
    Get.back();
    UserrightListClass obj = arrDrawerFooterListTile[index];

    switch (obj.appmenuname) {
      case TECHNICAL_QUERY_APPMENUNAME:
        NavigateTechnicalQueryPage();
        break;
      case ABOUT_APPMENUNAME:
        NavigateAboutPage();
        break;
      case CONTACT_APPMENUNAME:
        NavigateContactPage();
        break;
    }
  }*/

  //</editor-fold>
  // <editor-fold desc="Navigation Method">

  BottomNavigationBarController cnt_bottom = Get.put(BottomNavigationBarController());

  navigateLoginSignupPage() {
    Get.to(const SendOTPPage());
  }

  NavigateTechnicalQueryPage() {
    // Get.to(TechnicalQueryPage());
  }




  NavigatePrivacyPolicy() {
    Get.back();
    Get.to(()=>
        const PrivacyPolicyPage(
          // title: "Privacy Policy",
        ),
        preventDuplicates: false);
  }

  NavigateProjectPage() {
    // Get.to(ProjectListPage());
    // int index = cnt_bottom.arrBottomnavigationList
    //     .indexWhere((element) => element.uniquename == PROJECTMENU);
    // cnt_bottom.selectedIndex.value = index;
  }

  NavigateFavoritePage() {
    // Get.to(FavoritePage());
    // int index = cnt_bottom.arrBottomnavigationList
    //     .indexWhere((element) => element.uniquename == FAVMENU);
    // cnt_bottom.selectedIndex.value = index;
  }

  NavigateReferAFriendPage() {
    // Get.to(ReferAFriendFormPage());
  }

  NavigateOfferPage() {
    // Get.to(OffersPage());
  }





  NavigateAwardsPage() {
    // Get.to(AwardsPage());
  }

  NavigateTechnicalPage() {
    Get.back();
    // Get.to(TechnicalQueryPage());
  }

  NavigatecontactUsPage() {
    Get.back();
    // Get.to(ContactUsPage());
  }

  NavigateTermCondition() {
    Get.back();
  //   Get.to(
  //       PrivacyTermPage(
  //         title: "Terms & Conditions",
  //       ),
  //       preventDuplicates: false);
  }




  // Close Button
  Widget CloseIcon() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
          height: 24,
          width: 24,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white.withOpacity(0.20),),
          child: SvgPicture.asset(
            closeSvgIcons,
            color: AppColors.whiteColor,
            fit: BoxFit.cover,
            height: 24,
            width: 24,
          )
      ),
    );
  }

  Widget CloseButton(MaterialColor color, MaterialColor iconColor,
      [MaterialColor? borderColor, double borderWidth = 0]) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        height: 30,
        width: 30,
        decoration: CustomDecorations().backgroundLocal(
            color, 20, borderWidth, borderColor ?? AppColors.black),
        child: Icon(
          Icons.clear,
          color: iconColor,
          size: 25,
        ),
      ),
    );
  }



/*  LoginDialog() {
    LoginDialoge(
        dialogtext: "You should login first to proceed further.",
        // stackicon: Icon(Icons.exit_to_app,size: 40.0,color:Colors.white,),
        stackicon: SvgPicture.asset(
          IMG_APPLOGO1_SVG,
          width: 40,
          height: 40,
          fit: BoxFit.fill,
          color: white,
        ),
        firstbuttontap: () {
          Get.back();
        },
        secondbuttontap: () {
          Get.back();
          Get.to(LoginPage());
        },
        secondbuttontext: "Yes",
        firstbuttontext: "No");
  }*/

  ImagePicker imagePicker = ImagePicker();
  RxString image = "".obs;

  profileimagepicker() {
    showCupertinoModalPopup(
        context: Get.context!,
        builder: (context) {
          return CupertinoActionSheet(
            cancelButton: CupertinoActionSheetAction(
              child: const Text("Close"),
              onPressed: () {
                Get.back();
              },
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Get.back();
                  CheckCameraPermission();
                },
                child: Text(
                  "Camera",
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Get.back();
                  ChooseImage();
                },
                child: Text(
                  "Choose Photo",
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          );
        });
  }

  Future<void> CheckCameraPermission() async {
    if (Platform.isAndroid) {
      bool status = await Permission.camera.isGranted;
      if (status) {
        // further process
        CameraSelect();
      } else if (await Permission.camera.isDenied) {
        await Permission.camera.request().then((value) {
          if (value == PermissionStatus.granted) {
            // further process
            CameraSelect();
          } else if (value == PermissionStatus.denied) {
            print("you can not access camera");
          }
        });
      }
    } else {
      CameraSelect();
    }
  }

  void CameraSelect() async {
    print("reached camera select");
    try {
      var response = await imagePicker.pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.front);
      if (response != null) {
        print("response not null");
        File file = File(response.path);
        print("file path");
        print(file);
        _cropImage(file);
      } else {
        print("No image selected");
      }
    } catch (e) {
      print("Error :--- \n $e");
    }
  }

  Future<void> _cropImage(File _pickedFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: _pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      // uiSettings: buildUiSettings(context),
    );
    if (croppedFile != null) {
      image.value = croppedFile.path;
      print("photo update succesfully");
    }
  }

  Future<void> CheckStoargePermission() async {
    if (Platform.isAndroid) {
      bool status = await Permission.storage.isGranted;
      if (status) {
        // further process
        ChooseImage();
      } else if (await Permission.storage.isDenied) {
        await Permission.storage.request().then((value) {
          if (value == PermissionStatus.granted) {
            // further process
            ChooseImage();
          } else if (value == PermissionStatus.denied) {
            print("you can not access gallery");
          }
        });
      }
    } else {
      ChooseImage();
    }
  }

  void ChooseImage() async {
    try {
      var response = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (response != null) {
        File file = File(response.path);
        _cropImage(file);
        // SendUpdatedProfile(file);
      } else {
        print("No Image Selected");
      }
    } catch (e) {
      print("Error :--- \n $e");
    }
  }
}
