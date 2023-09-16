
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';

class RegistrationController extends GetxController{

  RxBool isResisterMyCompany = false.obs;
  RxBool isMyCompanyIsRegister = false.obs;
  RxBool isInvitationSuccess = false.obs;
  RxBool isRERATextShow = false.obs;
  RxBool isRERAValidationShow = false.obs;

  GlobalKey<ScaffoldState> globalRegistrationPageKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> globalSuccessPageKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  Rx<RegistrationSelect>? registerOption = RegistrationSelect.registerMyCompany.obs;
  Rx<GSTCertificatesSelect>? gstCertificatesOption = GSTCertificatesSelect.gstCertificates.obs;
  RxList<CertificateModel> arrCertificateList = RxList([]);
  Rxn<TextEditingController> txtReraNo = Rxn(TextEditingController());

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


  ImagePicker imagePicker = ImagePicker();
  RxString reRaImage="".obs;

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
                  reRaImage.value='';
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
                  reRaImage.value='';
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
        // further process
        cameraSelect();
      } else if (await Permission.camera.isDenied) {
        await Permission.camera.request().then((value) {
          if (value == PermissionStatus.granted) {
            // further process
            cameraSelect();
          } else if (value == PermissionStatus.denied) {
            // dialog
            // ValidationMsg("you can not access camera");
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
        // ProfilePath.value=response.path;
        // ProfilePath.refresh();
        //
        // txt_image.text=ProfilePath.value.split("/").last.toString();
        File file = File(response.path);
        // SendUpdatedProfile(file);
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
      reRaImage.value=croppedFile.path;
      print(reRaImage.value);
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
            // dialog
            // ValidationMsg("you can not access gallery");
            print("you can not access gallery");
            // BottomSheetDialog(
            //     isDismissible: false,
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         ShowMessage("You can not access Gallery"),
            //       ],
            //     ),
            //     isHideAutoDialog: true,
            //     message: "error",
            //     backgroundColor: AppColors.RED);
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
        // ProfilePath.value=response.path;
        // ProfilePath.refresh();
        // txt_image.text=FilePath.value.split("/").last.toString();
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

enum RegistrationSelect { registerMyCompany, myCompanyIsRegistered }
enum GSTCertificatesSelect { gstCertificates, noGSTDeclaration }

class CertificateModel{
  String? title;
  RxBool? isCheck;
  CertificateModel({this.title,this.isCheck});
}