
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Model/CertificatesModel/certificates_model.dart';
import 'package:repeoplecp/Model/EntityTypeModel/entity_type_model.dart';
import 'package:repeoplecp/Widget/select_dailog.dart';

class RegistrationController extends GetxController{

  RxBool isResisterMyCompany = false.obs;
  RxBool isMyCompanyIsRegister = false.obs;
  RxBool isInvitationSuccess = false.obs;
  RxBool isRERATextShow = false.obs;
  RxBool isRERAValidationShow = false.obs;
  RxBool isPanValidationShow = false.obs;
  RxBool isBankPassBookValidationShow = false.obs;
  RxBool isGSTValidationShow = false.obs;

  RxBool isResisterShowScreen = false.obs;
  RxBool isInvitationSuccessShowScreen = false.obs;


  RxBool isOpenReRaDetails=true.obs;
  RxBool isOpenPanDetails=true.obs;
  RxBool isOpenGSTDetails=true.obs;
  RxBool isOpenBankDetails=true.obs;

  GlobalKey<ScaffoldState> globalRegistrationPageKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> globalSuccessPageKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> globalReRaPageKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> globalPanPageKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> globalGSTDetailsPageKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> globalBankDetailsPageKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> globalContactDetailsPageKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();
  var reRaFormKey = GlobalKey<FormState>();
  var bankFormKey = GlobalKey<FormState>();
  var contactDetailsFormKey = GlobalKey<FormState>();
  var pointOfContactDetailsFormKey = GlobalKey<FormState>();
  Rx<RegistrationSelect>? registerOption = RegistrationSelect.registerMyCompany.obs;
  Rx<GSTCertificatesSelect>? gstCertificatesOption = GSTCertificatesSelect.gstCertificates.obs;
  RxList<CertificateModel> arrCertificateList = RxList([]);
  RxList<EntityTypeModel> arrEntityTypeList = RxList([]);
  RxList<EntityTypeModel> arrAccountTypeList = RxList([]);
  Rx<EntityTypeModel> objEntityType = EntityTypeModel().obs;
  Rx<EntityTypeModel> objAccountType = EntityTypeModel().obs;
  Rxn<TextEditingController> txtReRaNo = Rxn(TextEditingController());
  Rxn<TextEditingController> txtEntityType = Rxn(TextEditingController());
  Rxn<TextEditingController> txtAccountType = Rxn(TextEditingController());

// Check if my Company is registered TextEditingController
  Rxn<TextEditingController> txtMobileNo = Rxn(TextEditingController());
  Rxn<TextEditingController> txtCorrespondenceAddress = Rxn(TextEditingController());
  Rxn<TextEditingController> txtWebsite = Rxn(TextEditingController());

// Point of Contact Details TextEditingController
  Rxn<TextEditingController> txtFirstName = Rxn(TextEditingController());
  Rxn<TextEditingController> txtLastName = Rxn(TextEditingController());
  Rxn<TextEditingController> txtDesignation = Rxn(TextEditingController());
  Rxn<TextEditingController> txtPointOfMobile = Rxn(TextEditingController());
  Rxn<TextEditingController> txtPointOfEmail = Rxn(TextEditingController());

  @override
  void onInit() {
    super.onInit();
    certificateData();
  }

  certificateData(){
    arrCertificateList = RxList([
      CertificateModel(title: "RERA Certificate",isCheck: false.obs),
      CertificateModel(title: "PAN Card",isCheck: false.obs),
      CertificateModel(title: "Cancelled Cheque",isCheck: false.obs),
    ]);
  }

  selectEntityType() {
    selectEntityTypeDialog((value) {
      objEntityType.value=value;
      txtEntityType.value!.text = objEntityType.value.title??"";
    });
  }
  selectAccountType() {
    selectAccountTypeDialog((value) {
      objAccountType.value=value;
      txtAccountType.value!.text = objAccountType.value.title??"";
    });
  }

  Future<dynamic> selectEntityTypeDialog(ValueChanged<EntityTypeModel> onChange) {
    return SelectDialog1.showModal<EntityTypeModel>(
      Get.context!,
      label: "Select Role Type",
      items: arrEntityTypeList,
      onChange: onChange,
      searchBoxDecoration: InputDecoration(prefixIcon: Icon(Icons.search,color: AppColors.greyColor), hintText: "Search",hintStyle: TextStyle(color: AppColors.greyColor)),
    );
  }
  Future<dynamic> selectAccountTypeDialog(ValueChanged<EntityTypeModel> onChange) {
    return SelectDialog1.showModal<EntityTypeModel>(
      Get.context!,
      label: "Select Account Type",
      items: arrAccountTypeList,
      onChange: onChange,
      searchBoxDecoration: InputDecoration(prefixIcon: Icon(Icons.search,color: AppColors.greyColor), hintText: "Search",hintStyle: TextStyle(color: AppColors.greyColor)),
    );
  }

  Future<List<EntityTypeModel>> entityTypeData() async{
    arrEntityTypeList = RxList([]);
    arrEntityTypeList.add(EntityTypeModel(title: "Private Company Limited"));
    arrEntityTypeList.add(EntityTypeModel(title: "Public Limited Company"));
    arrEntityTypeList.add(EntityTypeModel(title: "Limited Partnership"));
    arrEntityTypeList.add(EntityTypeModel(title: "Unlimited Partnership"));
    arrEntityTypeList.add(EntityTypeModel(title: "Statutory Corporation"));
    arrEntityTypeList.add(EntityTypeModel(title: "Holding Company"));
    arrEntityTypeList.add(EntityTypeModel(title: "Subsidiary Company"));
    // for(int i=0;i<arrEntityTypeList.length;i++) {
    //   objEntityType.value=arrEntityTypeList[i];
    // }
    return arrEntityTypeList;
  }

  Future<void> accountTypeData() async{
    arrAccountTypeList = RxList([
      EntityTypeModel(title: "Current Account"),
      EntityTypeModel(title: "Salary Account"),
      EntityTypeModel(title: "Saving Account"),
      EntityTypeModel(title: "NRI Account"),
    ]);
  }

  ImagePicker imagePicker = ImagePicker();
  RxString reRaImage="".obs;
  RxString panImage="".obs;
  RxString gstImage="".obs;
  RxString banPassbookImage="".obs;

  Future  CameraSelect(DocumentType logotype) async {
    try {
      var response = await imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
          preferredCameraDevice: CameraDevice.rear);
      if (response != null) {
        print("response not null");
        if (DocumentType.reRaPhoto == logotype) {
          reRaImage.value = response.path;
          reRaImage.refresh();
          isRERAValidationShow.value=true;

        } else if (DocumentType.panPhoto == logotype) {
          panImage.value = response.path;
          panImage.refresh();
          isPanValidationShow.value=true;
        } else if (DocumentType.bankPassBookPhoto == logotype) {
          banPassbookImage.value = response.path;
          banPassbookImage.refresh();
          isBankPassBookValidationShow.value=true;
        } else if (DocumentType.gsTPhoto == logotype) {
          gstImage.value = response.path;
          gstImage.refresh();
          isGSTValidationShow.value=true;
        }
        update();
      } else {
        print("No image selected");
      }
    } catch (e) {
      print("Error :--- \n $e");
    }
  }

  profileImagePicker(){
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
                  // reRaImage.value='';
                  Get.back();
                  checkCameraPermission();
                },
                child: Text(
                  "Camera",
                  style: TextStyle(color: AppColors.appFontColor,fontSize: 16, fontWeight:FontWeight.normal),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  // reRaImage.value='';
                  Get.back();
                  chooseImage();
                },
                child: Text(
                  "Choose Photo",
                  style: TextStyle(color: AppColors.appFontColor,fontSize: 16, fontWeight:FontWeight.normal),
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
        cameraSelect();
      } else if (await Permission.camera.isDenied) {
        await Permission.camera.request().then((value) {
          if (value == PermissionStatus.granted) {
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
    );
    if (croppedFile != null) {
      reRaImage.value='';
      panImage.value='';
      isRERAValidationShow.value=true;
      isPanValidationShow.value=true;


      if(reRaImage.value=="") {
        reRaImage.value = croppedFile.path;
      }
      if(panImage.value=="") {
        panImage.value = croppedFile.path;
      }
    }
  }

  Future<void> checkStoragePermission() async {
    if (Platform.isAndroid) {
      bool status = await Permission.storage.isGranted;
      if (status) {
        chooseImage();
      } else if (await Permission.storage.isDenied) {
        await Permission.storage.request().then((value) {
          if (value == PermissionStatus.granted) {
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
      } else {
        print("No Image Selected");
      }
    } catch (e) {
      print("Error :--- \n $e");
    }
  }


}

enum RegistrationSelect { registerMyCompany, myCompanyIsRegistered }
enum GSTCertificatesSelect { gstCertificates, noGSTDeclaration }
enum DocumentType {
  reRaPhoto,
  panPhoto,
  gsTPhoto,
  bankPassBookPhoto,
}

