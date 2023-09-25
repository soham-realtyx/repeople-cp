import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/TechnicalQueryController/technical_query_controller.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/bottom_navigationbar_page.dart';
import 'package:repeoplecp/Widget/CustomButton/custom_button.dart';
import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';
import 'package:repeoplecp/Widget/custom_boxDecoration.dart';
import 'package:repeoplecp/Widget/custom_textField.dart';

class TechnicalQueryPage extends StatefulWidget {
  const TechnicalQueryPage({super.key});

  @override
  State<TechnicalQueryPage> createState() => _TechnicalQueryPageState();
}

class _TechnicalQueryPageState extends State<TechnicalQueryPage> {
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  TechnicalQueryController cntTechnicalQuery = Get.put(TechnicalQueryController());
  GlobalKey<ScaffoldState> globalPrivacyPolicyPageKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // check.value = globalMyAccountPageKey;
      BottomNavigationBarPage().selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: globalPrivacyPolicyPageKey,
      endDrawer: const CustomDrawer(
        animatedOffset: Offset(1.0, 0),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: appBarHeight),
                  technicalQueryFormData(),
                  const SizedBox(height: 20),

                ],
              ),
            ),
            cntCommonHeader.commonAppBar("Technical Page", globalPrivacyPolicyPageKey,
                isMenuIconHide: true)
          ],
        ),
      ),

    );
  }

  Widget technicalQueryFormData(){
    return GetBuilder<TechnicalQueryController>(
      init: TechnicalQueryController(),
      builder: (controller){
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: const EdgeInsets.only(left: 20.0, right: 20,top: 20),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                // spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(
                    0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: cntTechnicalQuery.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 16.h),
                          commonDropDownTextField(
                            labelText: "Subject*",
                            onTap: (){
                              // cntTechnical.SelectSubject();
                            },
                            controller: cntTechnicalQuery.txtSubject,
                            hintText: /*cntTechnicalQuery.txtSubject.text*/"Select Subject",
                          ),
                          SizedBox(height: 16.h),
                          attachmentWidget(),
                          SizedBox(height: 5.h),
                          queryTextField(cntTechnicalQuery.txtMassageNew),
                          SizedBox(height: 16.h),
                          submitButton(),
                          const SizedBox(height: 30,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget queryTextField(
      Rxn<TextEditingController>? controller,[double leftPadding = 0 , bool labelOpen = true]) {
    return Obx(() =>
        TextFormField(
          onChanged: (value){
            controller?.update((val) { });
          },
          style: boldTextStyle(fontSize: 16, txtColor: AppColors.appFontColor),
          maxLines: 4,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
          ],
          controller: controller?.value,
          validator: (value) =>
              validation(value, "Please enter query"),
          decoration: InputDecoration(
            border: InputBorder.none,
            floatingLabelBehavior: labelOpen?FloatingLabelBehavior.always:FloatingLabelBehavior.never,
            labelText: labelOpen?"Message*":null,
            hintText: "",
            labelStyle:
            TextStyle(
                fontSize: 14.sp,
                color:AppColors.labelGreyColor,
                fontFamily: fontFamily,
                fontWeight: FontWeight.w500),
            hintStyle:TextStyle(
                fontSize: 16, color: AppColors.labelGreyColor, fontWeight: FontWeight.normal),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.labelGreyColor)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.labelGreyColor)),
            errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            disabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),

          ),
        ));
  }

  Widget attachmentWidget([double leftPadding = 0 , bool labelOpen = true]){
    return GestureDetector(
      onTap: (){
        cntTechnicalQuery.onSelectDialog();
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelOpen?
                    Text("File",style:
                    TextStyle(
                        fontSize: 10.sp,
                        color:AppColors.labelGreyColor,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w500),
                    )
                        :Container(),
                    const SizedBox(height: 8,),
                    Container(
                        child: cntTechnicalQuery.arrImageAndFileList.length!=0? SizedBox(
                          height: cntTechnicalQuery.arrImageAndFileList.length !=0?100:10,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount:
                              cntTechnicalQuery.arrImageAndFileList.length > 0
                                  ? cntTechnicalQuery.arrImageAndFileList.length
                                  : 0,
                              itemBuilder: (context, i) {
                                return cntTechnicalQuery.fileBlock(i);
                              }),
                        ):Container(
                          height: labelOpen?null:50,
                          width: labelOpen?null:120,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Attach your file" , style:
                              TextStyle(fontSize: 15.sp,
                                  color: AppColors.labelGreyColor, fontWeight: FontWeight.w700,fontFamily: fontFamily),
                              ),
                              SvgPicture.asset(fileUploadIcons)
                            ],
                          ),
                        )
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 8,),
          Divider(color: AppColors.labelGreyColor,thickness: 1,),

        ],
      ),
    );

  }

  Widget submitButton() {
    return onTapButton(
        onTap: (){
          if(cntTechnicalQuery.formKey.currentState!.validate()){

          }
        },
        height: 40,
        width: Get.width,
        decoration:
        CustomDecorations().backgroundLocal(AppColors.appThemeColor, 8, 0, AppColors.appThemeColor),
        text: "Submit".toUpperCase(),
        style: TextStyle(color: AppColors.whiteColor, fontSize: 12.sp,fontFamily: fontFamily,fontWeight: FontWeight.w500)
    );
  }

}
