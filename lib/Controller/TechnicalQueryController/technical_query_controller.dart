import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';

class TechnicalQueryController extends GetxController{

  var formKey = GlobalKey<FormState>();
  TextEditingController txtSubject = TextEditingController();
  TextEditingController txtFile = TextEditingController();
  TextEditingController txtMassage = TextEditingController();
  Rxn<TextEditingController> txtMassageNew = Rxn(TextEditingController());
  int fileType = (-1);
  File? fileValue;
  //FirebaseMessaging? firebaseMessaging;
  List<PlatformFile> arrFileList = [];
  List<PlatformFile> arrImageList = [];
  List<PlatformFile> arrImageAndFileList = [];

  // SelectSubject() {
  //   SelectSubjectDialog((value) {
  //     obj_subject.value=value;
  //     txtSubject.text = obj_subject.value.name??"";
  //   });
  // }
  //
  // Future<dynamic> SelectSubjectDialog(ValueChanged<dynamic> onChange) {
  //   return SelectDialog1.showModal(
  //     Get.context!,
  //     label: "Select subject",
  //     items: arrsubjectList,
  //     onChange: onChange,
  //     searchBoxDecoration:
  //     const InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Search"),
  //   );
  // }

  onSelectDialog(){
    showCupertinoModalPopup(context: Get.context!, builder: (context){
      return CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          child: const Text("Close"),
          onPressed: (){
            Get.back();
          },
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: (){
              Get.back();
              cameraSelect();

            },
            child: Text("Camera",style:
            TextStyle(color: AppColors.appFontColor,fontSize: 16, fontWeight:FontWeight.normal),),
          ),
          CupertinoActionSheetAction(
            onPressed: (){
              Get.back();
              chooseImage();
            },
            child: Text("Choose Photo",style:
            TextStyle(color: AppColors.appFontColor,fontSize: 16, fontWeight:FontWeight.normal),),
          ),
          CupertinoActionSheetAction(
            onPressed: (){
              Get.back();
              fileChoose();
            },
            child: Text("File",style: TextStyle(color: AppColors.appFontColor,fontSize: 16, fontWeight:FontWeight.normal),),
          ),
        ],
      );
    });
  }

  ImagePicker imagePicker = ImagePicker();

  // Camera file type = 1;
  void cameraSelect()async{
    try{
      var response = await imagePicker.pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.front
      );
      if(response != null){
        fileType= 1;
        arrFileList.clear();
        PlatformFile platformFile = PlatformFile(name: response.path, size: 50,path: response.path);
        arrImageList.add(platformFile);
        arrImageAndFileList = arrImageList;
        update();
      }
      else{
        print("No image selected");
      }
    }
    catch(e){
      print("Error :--- \n $e");
    }

  }

  // Storage photo file type = 1
  void chooseImage() async
  {
    try{
      var response = await imagePicker.pickMultiImage(
        imageQuality: 50,

      );
      if(response!=null){
        fileType = 1;
        arrFileList.clear();
        List<PlatformFile> arrImageTempList = [];
        arrImageTempList= response.map((e) =>PlatformFile(name: e.path, size: 50,path: e.path) ).toList();
        arrImageList.addAll(arrImageTempList);
        //PlatformFile platformFile = PlatformFile(name: response.path, size: 50,path: response.path);
        //arrImageList.add(platformFile);
        arrImageAndFileList = arrImageList;
        update();
      }
      else{
        print("No Image Selected");
      }
    }
    catch(e){
      print("Error :--- \n $e");
    }
  }

  // Storage file type = 0
  void fileChoose()async{
    try{
      FilePickerResult? response = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: [
          'txt',
          'pdf',
          'xls',
          'xlsx',
          'docx',
          'ppt',
          'doc',
          'ppt',
          'pptx'
        ],
      );

      if(response!=null){
        fileType = 0;
        arrImageList.clear();
        arrFileList.addAll(response.files);
        arrImageAndFileList = arrFileList;
        update();
      }
      else{
        print("No Selected any File");
      }
    }catch(e){
      print("Error :--- \n $e");
    }

  }


  String _setImage(String extension) {
    if (extension == "txt") {
      return fileIcons;
    } else if (extension == "pdf") {
      return pdfIcons;
    } else if (extension == "xls" || extension == "xlsx") {
      return xlxIcons;
    } else if (extension == "doc" || extension == "docx") {
      return documentIcon;
    } else if (extension == "ppt" || extension == "pptx") {
      return pptIcons;
    } else {
      return fileIcons;
    }
  }

  //</editor-fold>

  //<editor-fold desc = "File Picker Widget">
  File? fileImage;
  String? imgPdf;



  Widget fileBlock(int index){

    if (fileType == 1) {
      fileImage = File(arrImageList[index].path!);
    } else {
      fileImage = File(arrFileList[index].path!);
      imgPdf = _setImage(arrFileList[index].extension!);
    }

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: AppColors.appFontColor,width: 0.5,style: BorderStyle.solid)
          ),
          clipBehavior: Clip.hardEdge,
          child: fileType == 1
              ? Image.file(
            fileImage!,
            height: 80,
            width: 80,
            fit: BoxFit.fill,
          ) : Image.asset(imgPdf!, height: 100, width: 100),
        ),
        Positioned(
          top: 0.0,
          right: 0.0,
          child: IconButton(
              padding: const EdgeInsets.all(0.0),
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.cancel,
              ),
              onPressed: () {
                if (fileType == 1) {
                  arrImageList.removeAt(index);
                  if (arrImageList.isEmpty) {
                    fileType= -1;
                  }
                } else if (fileType == 0) {
                  arrFileList.removeAt(index);
                  if (arrFileList.isEmpty) {
                    fileType = -1;
                  }
                }
                update();
              }),
        )
      ],
    );
  }

}