import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Helper/hex_color.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/size_config.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Controller/CommonHeaderController/common_header_controller.dart';
import 'package:repeoplecp/Controller/MarketingInformationController/marketing_information_controller.dart';
import 'package:repeoplecp/Widget/CustomButton/custom_button.dart';
import 'package:repeoplecp/Widget/CustomDrawer/custom_drawer.dart';
import 'package:repeoplecp/Widget/country_code_dialog.dart';
import 'package:repeoplecp/Widget/custom_boxDecoration.dart';
import 'package:repeoplecp/Widget/custom_textField.dart';
import 'package:repeoplecp/Widget/horizontal_divider_widget.dart';
import 'package:repeoplecp/Widget/intel_country_code.dart';

class MarketingInformation extends StatefulWidget {
  const MarketingInformation({super.key});

  @override
  State<MarketingInformation> createState() => _MarketingInformationState();
}

class _MarketingInformationState extends State<MarketingInformation> {
  MarketingInformationController cntMarketingInfo =
      Get.put(MarketingInformationController());
  CommonHeaderController cntCommonHeader = Get.put(CommonHeaderController());
  GlobalKey<ScaffoldState> globalMarketingInfoPageKey =
      GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    cntMarketingInfo.txtMobile.value!.text="8029136857";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      key: globalMarketingInfoPageKey,
      endDrawer: const CustomDrawer(
        animatedOffset: Offset(1.0, 0),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 85.w),
                  marketingInformationData(),
                  const SizedBox(height: 12),
                  Center(
                      child: Text("Preview",
                          style: mediumTextStyle(
                              txtColor: AppColors.labelGreyColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 10))),
                  const SizedBox(height: 20),
                  marketingInformationDisplayData(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            cntCommonHeader.commonAppBar(
              "Marketing Information",
              globalMarketingInfoPageKey,
            ),
          ],
        ),
      ),
    );
  }

  Widget marketingInformationData() {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20),
      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 8, left: 8),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AppColors.black.withOpacity(0.08),
                spreadRadius: 0,
                blurRadius: 6,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          editInvoiceImageData(),
          const SizedBox(
            height: 16,
          ),
          Form(key: cntMarketingInfo.marketingInfoKey,child: phoneNumberTextField(cntMarketingInfo.txtMobile)),
          const SizedBox(
            height: 16,
          ),
          whatsAppNumberTextField(),
          const SizedBox(
            height: 16,
          ),
          simpleTextFieldNewWithCustomization(
            hintText: "email@example.com",
            controller: cntMarketingInfo.txtEmail,
            // inputFormat: [UpperCaseTextFormatter()],
            textInputType: TextInputType.name,
            labelText: "Email",
            textCapitalization: TextCapitalization.sentences,
            // validator: (value) => validation(value, "Please enter email")
          ),
          const SizedBox(
            height: 16,
          ),
          simpleTextFieldNewWithCustomization(
            hintText: "www.example.com",
            controller: cntMarketingInfo.txtWebsite,
            // inputFormat: [UpperCaseTextFormatter()],
            textInputType: TextInputType.name,
            labelText: "Website",
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(
            height: 16,
          ),
          simpleTextFieldNewWithCustomization(
            hintText: "Address",
            controller: cntMarketingInfo.txtAddress,
            // inputFormat: [UpperCaseTextFormatter()],
            textInputType: TextInputType.name,
            labelText: "Address",
            textCapitalization: TextCapitalization.sentences,
            // validator: (value) => validation(
            //     value, "Please enter correspondence Address")
          ),
          const SizedBox(
            height: 12,
          ),
          saveButton()
        ],
      ),
    );
  }

  Widget editInvoiceImageData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Logo",
          style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.labelGreyColor,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() => cntMarketingInfo.companyLogoImage.value != ""
                ? Obx(() => Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: Get.width - 53.w,
                          height: 174.w,
                          // padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 138),
                          decoration: BoxDecoration(
                            color: AppColors.appThemeColor.withOpacity(0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: cntMarketingInfo.companyLogoImage.value != ""
                              ? Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.file(
                                    File(cntMarketingInfo
                                        .companyLogoImage.value),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image(
                                      image: NetworkImage(cntMarketingInfo
                                          .companyLogoImage.value),
                                      fit: BoxFit.cover)),
                        ),
                        Obx(
                          () => cntMarketingInfo.companyLogoImage.value == ""
                              ? const SizedBox()
                              : GestureDetector(
                                  onTap: () {
                                    cntMarketingInfo.companyLogoImagePicker();
                                  },
                                  child: Container(
                                    width: Get.width - 52.w,
                                    height: 174.w,
                                    // padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 138),
                                    decoration: BoxDecoration(
                                      color: AppColors.appThemeColor
                                          .withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "CHANGE",
                                        style: mediumTextStyle(
                                            txtColor: AppColors.whiteColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                        )
                      ],
                    ))
                : GestureDetector(
                    onTap: () {
                      cntMarketingInfo.companyLogoImagePicker();
                    },
                    child: Container(
                      width: Get.width - 52.w,
                      height: 174.w,
                      // padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 138),
                      decoration: BoxDecoration(
                        color: AppColors.appThemeColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          "+ADD",
                          style: TextStyle(
                              color: AppColors.appThemeColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: fontFamily),
                        ),
                      ),
                    ),
                  )),
          ],
        ),
        SizedBox(
          height: 8.w,
        ),
        HorizontalDivider(color: AppColors.labelGreyColor, height: 1),
      ],
    );
  }

  Widget marketingInformationDisplayData() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 34,
              ),

              cntMarketingInfo.companyImage.value != ""?
              Image.asset(cntMarketingInfo.companyImage.value,width: 50,height: 50,):const SizedBox(),
              SizedBox(
                height:cntMarketingInfo.companyImage.value==""?0:10,
              ),
              Text(
                "Brikkin Martech Private Limited",
                style: boldTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    txtColor: AppColors.newBlack),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "203, 2nd Floor, Ackruti Star, MIDC Central Road, Andheri East, Mumbai-400093",
                style: mediumTextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    txtColor: AppColors.newBlack),
              ),
              const SizedBox(
                height: 10,
              ),
              companyDetailsCustomWidget(
                icons: callSvgIcons,
                text: cntMarketingInfo.txtMobile.value!.text.toString(),
                iconColor: AppColors.appThemeColor
              ),
              SizedBox(
                height: cntMarketingInfo.txtMobile.value!.text==""?0:10,
              ),
              cntMarketingInfo.whatsAppMobileText.value!=""
              ? companyDetailsCustomWidget(
                icons: newWhatsAppSvgIcons,
                text: cntMarketingInfo.whatsAppMobileText.value,
                iconColor: AppColors.green
              ):const SizedBox(),
              SizedBox(
                height:cntMarketingInfo.whatsAppMobileText.value==""?0:10,
              ),
              cntMarketingInfo.emailText.value!=""
                  ?companyDetailsCustomWidget(
                  icons: mailForwardSvgIcons,
                  text: cntMarketingInfo.emailText.value,
                  iconColor: hex("E17055")
              ):const SizedBox(),
              SizedBox(
                height: cntMarketingInfo.emailText.value==""?0:10,
              ),
              cntMarketingInfo.websiteText.value!=""
              ? companyDetailsCustomWidget(
                  icons: webSiteSvgIcons,
                  text: cntMarketingInfo.websiteText.value,
                  iconColor: hex("636E72")
              ):const SizedBox(),
              const SizedBox(
                height: 34,
              ),
            ],
          )),
        ),
        Positioned(
          top: 0,
          right: 20,
          left: 20,
          child: Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 4, top: 4),
            decoration: BoxDecoration(
                color: AppColors.appThemeColor.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Text(
              "Authorized Chanel Partner",
              style: mediumTextStyle(
                  txtColor: AppColors.newBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: 10),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 20,
          left: 20,
          child: Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 4, top: 4),
            decoration: BoxDecoration(
                color: AppColors.appThemeColor.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Row(
              children: [
                Text('MAHARERA Reg. No.:',
                    style: mediumTextStyle(
                        txtColor: AppColors.newBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: 10)),
                Text(' A51800035827',
                    style: boldTextStyle(
                        txtColor: AppColors.newBlack,
                        fontWeight: FontWeight.w700,
                        fontSize: 10))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget saveButton() {
    return onTapButton(
        onTap: () {
          if (cntMarketingInfo.marketingInfoKey.currentState!.validate()) {
            cntMarketingInfo.whatsAppMobileText.value=cntMarketingInfo.txtWhatsAppMobile.value!.text.toString();
            cntMarketingInfo.emailText.value=cntMarketingInfo.txtEmail.value!.text.toString();
            cntMarketingInfo.websiteText.value=cntMarketingInfo.txtWebsite.value!.text.toString();
            cntMarketingInfo.addressText.value=cntMarketingInfo.txtAddress.value!.text.toString();
            cntMarketingInfo.companyImage.value=cntMarketingInfo.companyLogoImage.value;
          }
        },
        height: 40.w,
        decoration: CustomDecorations().backgroundLocal(
            AppColors.appThemeColor, 6, 0, AppColors.appThemeColor),
        text: "Submit".toUpperCase(),
        style: TextStyle(
            color: AppColors.whiteColor,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp));
  }

  Widget companyDetailsCustomWidget({String? icons, String? text,Color? iconColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          icons??"",
          height: 24,
          width: 24,
          color: iconColor,
        ),
        const SizedBox(
          width: 14,
        ),
        Text(
          text??"",
          style: mediumTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              txtColor: AppColors.newBlack),
        ),
      ],
    );
  }

  Widget whatsAppNumberTextField() {
    return IntlPhoneCustomField(
      // readOnly: readonly ?? false,
      // showCursor: showCursor ?? true,
      controller: cntMarketingInfo.txtWhatsAppMobile.value,
      disableLengthCheck: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textAlign: TextAlign.left,
      focusNode: mobileFocusNode,
      autofocus: false,
      mobilNo: true,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textAlignVertical: TextAlignVertical.bottom,
      selectedCountry: selectedCountry.value,
      flagsButtonPadding: const EdgeInsets.only(left: 0),
      validator: (value) => mobileValidation(value!),
      onSubmitted: (value) {},
      style: boldTextStyle(fontSize: 16, txtColor: AppColors.appFontColor),
      dropdownIconPosition: IconPosition.trailing,
      dropdownIcon:
          Icon(Icons.arrow_drop_down, color: hex("#898989"), size: 26.h),
      dropdownTextStyle:
          boldTextStyle(fontSize: 16, txtColor: AppColors.appFontColor),
      showCountryFlag: false,
      hintText: "9876543210",
      hintStyle: TextStyle(
          height: 1.3,
          fontSize: 16,
          fontFamily: fontFamily,
          color: HexColor("#898989"),
          fontWeight: FontWeight.w700),
      pickerDialogStyle: PickerDialogCustomStyle(
        backgroundColor: AppColors.pageBackgroundColor,
        countryCodeStyle:
            mediumTextStyle(fontSize: 14, txtColor: AppColors.appFontColor),
        searchFieldCursorColor: AppColors.black,
        countryNameStyle:
            mediumTextStyle(fontSize: 14, txtColor: AppColors.appFontColor),
        listTileDivider: Container(
          height: 0.8,
          color: AppColors.greyColor,
        ),
      ),
      initialCountryCode: 'IN',
      cursorColor: AppColors.black,
      onChanged: (phone) {
        countrystr.value = phone.countryISOCode;
        countrycode.value = phone.countryCode;
        if (cntMarketingInfo.txtWhatsAppMobile.value!.text.isNotEmpty) {}
      },
      onCountryChanged: (country) {
        selectedCountry.value = country;
        cntMarketingInfo.txtWhatsAppMobile.value?.text = "";
      },
      decoration: InputDecoration(
        counterText: "",
        contentPadding: const EdgeInsets.only(bottom: 15),
        hintText: "9876543210",
        hintStyle: TextStyle(
            height: 1.8,
            fontSize: 16,
            fontFamily: fontFamily,
            color: HexColor("#898989"),
            fontWeight: FontWeight.w700),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.labelGreyColor)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.labelGreyColor)),
        errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
      ),
    );
  }
}
