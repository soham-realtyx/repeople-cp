
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
    roleTypeData();
  }

  GlobalKey<ScaffoldState> globalEditProfilePageKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();


  Rxn<TextEditingController> txtFirstName = Rxn(TextEditingController());
  Rxn<TextEditingController> txtLastName = Rxn(TextEditingController());
  Rxn<TextEditingController> txtContactNew = Rxn(TextEditingController());
  Rxn<TextEditingController> txtEmail = Rxn(TextEditingController());
  Rxn<TextEditingController> txtAlternateContactNew = Rxn(TextEditingController());
  Rxn<TextEditingController> txtEmailNew = Rxn(TextEditingController());
  TextEditingController txtUserRole = TextEditingController();

  ImagePicker imagePicker = ImagePicker();
  RxString image="".obs;
 Rx<RoleModel> objRoleType = RoleModel().obs;
 RxList<RoleModel> arrRoleList = RxList([]);
 roleTypeData(){
   arrRoleList = RxList([
     RoleModel(label: "User"),
     RoleModel(label: "Admin"),
   ]);
   objRoleType.value = arrRoleList[0];
 }
  selectEmailType() {
    selectEmailTypeDialog((value) {
      objRoleType.value=value;
      txtUserRole.text = objRoleType.value.label??"";
    });
  }

  Future<dynamic> selectEmailTypeDialog(ValueChanged<RoleModel> onChange) {
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
                  ChooseImage();
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
  Future<void> _cropImage(File _pickedFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: _pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      // uiSettings: buildUiSettings(context),
    );
    if (croppedFile != null) {
      image.value=croppedFile.path;
      print(image.value);
      // SendUpdatedProfile(croppedFile);
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
      ChooseImage();
    }
  }

  void ChooseImage() async {
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

class RoleModel{
  String? label;
  RoleModel({this.label});
}