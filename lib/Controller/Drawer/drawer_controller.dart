
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/BottomNavigationBarController/bottom_navigationbar_controller.dart';
import 'package:repeoplecp/Model/DrawerModal/drawer_modal.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/bottom_navigationbar_page.dart';
import 'package:repeoplecp/View/EarningsPage/earnings_page.dart';
import 'package:repeoplecp/View/FavoritePage/favorite_page.dart';
import 'package:repeoplecp/View/HomePage/home_page.dart';
import 'package:repeoplecp/View/LeadsPage/leads_page.dart';
import 'package:repeoplecp/View/OffersPage/offers_page.dart';
import 'package:repeoplecp/View/PrivacyPolicyPage/privacy_policy_page.dart';
import 'package:repeoplecp/View/ProfilePage/profile_page.dart';
import 'package:repeoplecp/View/PropertiesPage/properties_page.dart';
import 'package:repeoplecp/View/SendOTPPage/send_otp_page.dart';
import 'package:repeoplecp/View/TeamPage/team_page.dart';
import 'package:repeoplecp/View/TechnicalQueryPage/technical_query_page.dart';
import 'package:repeoplecp/View/TermsAndConditionsPage/terms_and_conditions_page.dart';
import 'package:repeoplecp/Widget/CustomBottomSheet/custom_bottom_sheet.dart';
import 'package:repeoplecp/Widget/LogOutDialogue/logout_dialogue.dart';
import 'package:repeoplecp/Widget/custom_boxDecoration.dart';

typedef OnTapLogoutButton = void Function();

class CustomDrawerController extends GetxController {


  RxList<DrawerModal> arrNewDrawerList_1 = RxList<DrawerModal>();
  RxList<DrawerModal> arrNewDrawerList_2 = RxList<DrawerModal>();
  RxList<DrawerModal> arrNewDrawerOtherList = RxList<DrawerModal>();

  RxString lblVersion = "".obs;
  RxBool  isRegistered = false.obs;

  @override
  void onInit() async {
    super.onInit();
    newDrawerListData_1();
    newDrawerListData_2();
    otherListData();
  }


  navigateScreen_1(int i){
    if(i==1){
       Get.to(()=>const HomePage());
    }else if(i==2){
      Get.to(()=>const FavoritePage());
      // NavigateFavoritePage();
    }else if(i==3){
      Get.to(()=>const OffersPage());
    }
  }

  navigateScreen_2(int i){
    if(i==0){
      Get.to(()=>const LeadsPage());
      BottomNavigationBarPage().selectedIndex=1;
    }else if(i==1){
      Get.to(()=>const TeamPage());
    }else if(i==2){
      Get.to(()=>const ProfilePage())?.whenComplete(() => BottomNavigationBarPage().selectedIndex=4);
    }
  }

  navigateProjectScreen_1(int i){
    if(i==0){
      Get.to(()=>const PropertiesPage())?.whenComplete(() => BottomNavigationBarPage().selectedIndex=3);
    }
  }

  navigateEarningScreen_1(int i){
    if(i==3){
      BottomNavigationBarPage().selectedIndex=2;
      Get.to(()=>const EarningsPage());
    }
  }

  String? loginClickData(){
    if(isLogin.value==false) {
      "Login";
    }else if(isRegistered.value){
      "Link My Properties";
    }else{
      "My Properties";
    }
    return null;
  }
  
  newDrawerListData_1() {
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

  newDrawerListData_2() {
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

  otherListData(){
    arrNewDrawerOtherList = RxList([
      DrawerModal(
        onTap: (){navigatePrivacyPolicy();},
        images: privacyPolicySvgIcons,
        title: "Privacy Policy",
      ),
      DrawerModal(
        onTap: (){navigateTermCondition();},
        images: reportSvgIcons,
        title: "Terms & Conditions",
      ),
      DrawerModal(
        onTap: (){navigateTechnicalPage();},
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
        onTap: (){logoutDialog();},
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

  BottomNavigationBarController cntBottom = Get.put(BottomNavigationBarController());

  navigateLoginSignupPage() {
    Get.to(const SendOTPPage());
  }

  navigateTechnicalQueryPage() {
    // Get.to(TechnicalQueryPage());
  }




  navigatePrivacyPolicy() {
    Get.back();
    Get.to(()=>
        const PrivacyPolicyPage(
          // title: "Privacy Policy",
        ),
        preventDuplicates: false);
  }

  navigateProjectPage() {
    // Get.to(ProjectListPage());
    // int index = cnt_bottom.arrBottomnavigationList
    //     .indexWhere((element) => element.uniquename == PROJECTMENU);
    // cnt_bottom.selectedIndex.value = index;
  }

  navigateFavoritePage() {
    Get.to(()=>const FavoritePage());
    int index = cntBottom.arrBottomNavigationList
        .indexWhere((element) => element.name == favMenu);
    BottomNavigationBarPage().selectedIndex = index;
  }


  navigateOfferPage() {
    Get.to(()=>const OffersPage());
  }


  navigateTechnicalPage() {
    Get.back();
    Get.to(()=>const TechnicalQueryPage());
  }

  navigateContactUsPage() {
    Get.back();
    // Get.to(ContactUsPage());
  }

  navigateTermCondition() {
    Get.back();
    Get.to(()=>
        const TermsAndConditionsPage(),
        preventDuplicates: false);
  }

  // Close Button
  Widget closeIcon() {
    return GestureDetector(
      onTap: () {
        Get.back();
        // check.refresh();
        },
      child: Container(
          height: 24.w,
          width: 24.w,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white.withOpacity(0.20),),
          child: SvgPicture.asset(
            closeSvgIcons,
            color: AppColors.whiteColor,
            fit: BoxFit.cover,
            height: 24.w,
            width: 24.w,
          )
      ),
    );
  }

  Widget closeButton(MaterialColor color, MaterialColor iconColor,
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



  loginDialog() {
    loginDialogue(
        dialogText: "You should login first to proceed further.",
        // stackicon: Icon(Icons.exit_to_app,size: 40.0,color:Colors.white,),
        stackIcon: SvgPicture.asset(
            appLogoSvgIcons,
          width: 40,
          height: 40,
          fit: BoxFit.fill,
          color: AppColors.whiteColor,
        ),
        firstButtonTap: () {
          Get.back();
        },
        secondButtonTap: () {
          Get.back();
          Get.to(()=>const SendOTPPage());
        },
        secondButtonText: "Yes",
        firstButtonText: "No");
  }

  ImagePicker imagePicker = ImagePicker();
  RxString image = "".obs;

  profileImagePicker() {
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
                  checkCameraPermission();
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
                  chooseImage();
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

  Future<void> checkCameraPermission() async {
    if (Platform.isAndroid) {
      bool status = await Permission.camera.isGranted;
      if (status) {
        // further process
        cameraSelect();
      } else if (await Permission.camera.isDenied) {
        await Permission.camera.request().then((value) {
          if (value == PermissionStatus.granted) {
            // further process
            cameraSelect();
          } else if (value == PermissionStatus.denied) {
            print("you can not access camera");
          }
        });
      }
    } else {
      cameraSelect();
    }
  }

  void cameraSelect() async {
    try {
      var response = await imagePicker.pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.front);
      if (response != null) {

        File file = File(response.path);

        _cropImage(file);
      } else {
        print("No image selected");
      }
    } catch (e) {
      print("Error :--- \n $e");
    }
  }

  Future<void> _cropImage(File pickedFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      // uiSettings: buildUiSettings(context),
    );
    if (croppedFile != null) {
      image.value = croppedFile.path;
      print("photo update succesfully");
    }
  }

  Future<void> checkStoargePermission() async {
    if (Platform.isAndroid) {
      bool status = await Permission.storage.isGranted;
      if (status) {
        // further process
        chooseImage();
      } else if (await Permission.storage.isDenied) {
        await Permission.storage.request().then((value) {
          if (value == PermissionStatus.granted) {
            // further process
            chooseImage();
          } else if (value == PermissionStatus.denied) {
            print("you can not access gallery");
          }
        });
      }
    } else {
      chooseImage();
    }
  }

  void chooseImage() async {
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
