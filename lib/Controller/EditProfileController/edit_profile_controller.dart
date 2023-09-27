
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Widget/select_dailog.dart';

class EditProfileController extends GetxController{

  @override
  void onInit() {
    super.onInit();
  }

  GlobalKey<ScaffoldState> globalEditProfilePageKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  FocusNode mobileFocusNode = FocusNode();

  Rxn<TextEditingController> txtFirstName = Rxn(TextEditingController());
  Rxn<TextEditingController> txtLastName = Rxn(TextEditingController());
  Rxn<TextEditingController> txtContactNew = Rxn(TextEditingController());
  Rxn<TextEditingController> txtEmail = Rxn(TextEditingController());
  Rxn<TextEditingController> txtAlternateContactNew = Rxn(TextEditingController());
  Rxn<TextEditingController> txtEmailNew = Rxn(TextEditingController());
  TextEditingController txtUserRole = TextEditingController();

  ImagePicker imagePicker = ImagePicker();
  RxString image = "".obs;
  Rx<RoleModel> objRoleType = RoleModel().obs;
  RxList<RoleModel> arrRoleList = RxList([]);

 Future<RxList<RoleModel>> roleTypeData() async {
   arrRoleList = RxList([]);
   arrRoleList.add(RoleModel(label: "User"));
   arrRoleList.add(RoleModel(label: "Admin"));
   for(int i = 0; i < arrRoleList.length; i++) {
     objRoleType.value = arrRoleList[i];
   }
   return arrRoleList;
 }

 selectRoleType() {
    selectRoleTypeDialog((value) {
      objRoleType.value=value;
      txtUserRole.text = objRoleType.value.label??"";
    });
  }

  Future<dynamic> selectRoleTypeDialog(ValueChanged<RoleModel> onChange) {
    return SelectDialog1.showModal<RoleModel>(
      Get.context!,
      label: "Select Role Type",
      items: arrRoleList,
      onChange: onChange,
      searchBoxDecoration: InputDecoration(prefixIcon: Icon(Icons.search,color: AppColors.greyColor), hintText: "Search",hintStyle: TextStyle(color: AppColors.greyColor)),
    );
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
  Future<void> _cropImage(File _pickedFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: _pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
    );
    if (croppedFile != null) {
      image.value=croppedFile.path;
      print("photo update successful");
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
        // SendUpdatedProfile(file);
      } else {
        print("No Image Selected");
      }
    } catch (e) {
      print("Error :--- \n $e");
    }
  }
}

class RoleModel{
  String? label;
  RoleModel({this.label});
}