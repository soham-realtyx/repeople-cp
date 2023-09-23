import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Model/EarngingModel/earning_model.dart';

class EarningsController extends GetxController {
  RxList<EarningFilterModel> arrEarningFilterList = RxList([]);
  RxList<EarningModel> arrEarningList = RxList([]);

  RxInt filterIndex = 0.obs;

  Future<RxList<EarningFilterModel>> getEarningFilterListData() async {
    arrEarningFilterList = RxList([]);
    arrEarningFilterList
        .add(EarningFilterModel(title: "Data", totalCount: "All"));
    arrEarningFilterList
        .add(EarningFilterModel(title: "Paid", totalCount: "6"));
    arrEarningFilterList
        .add(EarningFilterModel(title: "Invoiced", totalCount: "7"));
    arrEarningFilterList
        .add(EarningFilterModel(title: "Registration", totalCount: "8"));
    return arrEarningFilterList;
  }

  Future<RxList<EarningModel>> getEarningData() async {
    arrEarningList = RxList([]);
    arrEarningList.add(EarningModel(
        name: "Yash Goswami",
        address: "101, Tower-A, WorldHome Superstar",
        invoiceText: "Share Invoice",
        isInvoiceText: "1",
        earningCountList: [
          EarningCountModel(earningText: "Site Visit",isEarningCount: "1"),
          EarningCountModel(earningText: "EOI",isEarningCount: "1"),
          EarningCountModel(earningText: "Registration",isEarningCount: "0"),
          EarningCountModel(earningText: "Invoiced",isEarningCount: "0"),
          EarningCountModel(earningText: "Paid",isEarningCount: "0"),
        ],
        earningDateList: [
          EarningDateModel(title: "Site Visit",earningValue: "18 Jun, 2023"),
          EarningDateModel(title: "EOI",earningValue: "20 Jun, 2023"),
          EarningDateModel(title: "Registration",earningValue: "-"),
          EarningDateModel(title: "Agreement Value",earningValue: "-"),
          EarningDateModel(title: "Brokerage Slab",earningValue: "-"),
          EarningDateModel(title: "Brokerage Amount",earningValue: "-"),
          EarningDateModel(title: "Brokerage Paid",earningValue: "-"),
        ]));
    arrEarningList.add(EarningModel(
        name: "Harshil Chauhan",
        address: "809, Tower-C, WorldHome Superstar",
        invoiceText: "Share Invoice",
        isInvoiceText: "0",
        earningCountList: [
          EarningCountModel(earningText: "Site Visit",isEarningCount: "1"),
          EarningCountModel(earningText: "EOI",isEarningCount: "1"),
          EarningCountModel(earningText: "Registration",isEarningCount: "1"),
          EarningCountModel(earningText: "Invoiced",isEarningCount: "0"),
          EarningCountModel(earningText: "Paid",isEarningCount: "0"),
        ],
        earningDateList: [
          EarningDateModel(title: "Site Visit",earningValue: "18 Jun, 2023"),
          EarningDateModel(title: "EOI",earningValue: "19 Jun, 2023"),
          EarningDateModel(title: "Registration",earningValue: "28 Sep, 2023"),
          EarningDateModel(title: "Agreement Value",earningValue: "₹ 50,00,000"),
          EarningDateModel(title: "Brokerage Slab",earningValue: "2%"),
          EarningDateModel(title: "Brokerage Amount",earningValue: "₹ 1,00,000"),
          EarningDateModel(title: "Brokerage Paid",earningValue: "0"),
        ]));
    arrEarningList.add(EarningModel(
        name: "Vimal Patel",
        address: "702, Tower-B, WorldHome Superstar",
        invoiceText: "View Invoice",
        isInvoiceText: "0",
        earningCountList: [
          EarningCountModel(earningText: "Site Visit",isEarningCount: "1"),
          EarningCountModel(earningText: "EOI",isEarningCount: "1"),
          EarningCountModel(earningText: "Registration",isEarningCount: "1"),
          EarningCountModel(earningText: "Invoiced",isEarningCount: "1"),
          EarningCountModel(earningText: "Paid",isEarningCount: "0"),
        ],
        earningDateList: [
          EarningDateModel(title: "Site Visit",earningValue: "21 May, 2023"),
          EarningDateModel(title: "EOI",earningValue: "23 May, 2023"),
          EarningDateModel(title: "Registration",earningValue: "23 Jun, 2023"),
          EarningDateModel(title: "Agreement Value",earningValue: "₹ 60,00,000"),
          EarningDateModel(title: "Brokerage Slab",earningValue: "2%"),
          EarningDateModel(title: "Brokerage Amount",earningValue: "₹ 1,20,000"),
          EarningDateModel(title: "Brokerage Paid",earningValue: "0"),
        ]));
    arrEarningList.add(EarningModel(
        name: "Vimal Patel",
        address: "702, Tower-B, WorldHome Superstar",
        invoiceText: "View Invoice",
        isInvoiceText: "0",
        receiptText: "Receipt",
        earningCountList: [
          EarningCountModel(earningText: "Site Visit",isEarningCount: "1"),
          EarningCountModel(earningText: "EOI",isEarningCount: "1"),
          EarningCountModel(earningText: "Registration",isEarningCount: "1"),
          EarningCountModel(earningText: "Invoiced",isEarningCount: "1"),
          EarningCountModel(earningText: "Paid",isEarningCount: "1"),
        ],
        earningDateList: [
          EarningDateModel(title: "Site Visit",earningValue: "3 Feb, 2023"),
          EarningDateModel(title: "EOI",earningValue: "10 Mar, 2023"),
          EarningDateModel(title: "Registration",earningValue: "22 May, 2023"),
          EarningDateModel(title: "Agreement Value",earningValue: "₹ 45,50,000"),
          EarningDateModel(title: "Brokerage Slab",earningValue: "2%"),
          EarningDateModel(title: "Brokerage Amount",earningValue: "₹ 91,000"),
          EarningDateModel(title: "Brokerage Paid",earningValue: "₹ 91,000"),
        ]));
    arrEarningList.add(EarningModel(
        name: "Vimal Patel",
        address: "702, Tower-B, WorldHome Superstar",
        earningCountList: [
          EarningCountModel(earningText: "Site Visit",isEarningCount: "1"),
          EarningCountModel(earningText: "EOI",isEarningCount: "1"),
          EarningCountModel(earningText: "Registration",isEarningCount: "1"),
          EarningCountModel(earningText: "Invoiced",isEarningCount: "0"),
          EarningCountModel(earningText: "Paid",isEarningCount: "0"),
        ],
        earningDateList: [
          EarningDateModel(title: "Site Visit",earningValue: "19 Jun, 2023"),
          EarningDateModel(title: "EOI",earningValue: "19 Jun, 2023"),
          EarningDateModel(title: "Cancelled",earningValue: "28 Jul, 2023"),
        ]));
    return arrEarningList;
  }

  ImagePicker imagePicker = ImagePicker();
  RxString invoiceImage = "".obs;
  invoiceImagePicker(){
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
      invoiceImage.value='';
      
      if(invoiceImage.value=="") {
        invoiceImage.value = croppedFile.path;
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
