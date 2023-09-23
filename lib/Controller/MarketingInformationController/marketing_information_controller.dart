import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';

class MarketingInformationController extends GetxController{

  Rxn<TextEditingController> txtMobile = Rxn(TextEditingController());
  Rxn<TextEditingController> txtWhatsAppMobile = Rxn(TextEditingController());
  Rxn<TextEditingController> txtEmail = Rxn(TextEditingController());
  Rxn<TextEditingController> txtWebsite = Rxn(TextEditingController());
  Rxn<TextEditingController> txtAddress = Rxn(TextEditingController());

  final marketingInfoKey = GlobalKey<FormState>();

  RxString emailText = ''.obs;
  RxString whatsAppMobileText = ''.obs;
  RxString websiteText = ''.obs;
  RxString addressText = ''.obs;
  RxString companyImage = ''.obs;

  ImagePicker imagePicker = ImagePicker();
  RxString companyLogoImage = "".obs;
  companyLogoImagePicker(){
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
      companyLogoImage.value='';

      if(companyLogoImage.value=="") {
        companyLogoImage.value = croppedFile.path;
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