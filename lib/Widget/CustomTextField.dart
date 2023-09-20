import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:repeoplecp/Config/Helper/HexColor.dart';
import 'package:repeoplecp/Config/Utils/SizeConfig.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/Utils/images.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';
import 'package:repeoplecp/Widget/CountryCodeDialog.dart';
import 'package:repeoplecp/Widget/IntelCountryCode.dart';

typedef void OnTapPress();
typedef void OnChange(String value);
String cCode = "91";
String isoCode = "IN";
RxString isoCode1 = "INDIA".obs;
FocusNode mobileFocusNode = FocusNode();
Rx<Country> selectedCountry = countryIndia().obs;
RxString countrystr = "IN".obs;
RxString countrycode = "+91".obs;

DateTime currentData = DateTime.now();
Future<TimeOfDay?> currenttime = Future(() => TimeOfDay.now());
TextEditingController txtDob = TextEditingController();
TextEditingController txtAnniversary = TextEditingController();

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}

String? validation(String? value, String message) {
  if (value!.trim().isEmpty) {
    return message;
  } else {
    return null;
  }
}

String? emailvalidation(String? value) {
  bool emailValid = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value!);
  if (value.trim().isEmpty) {
    return "" + "Please enter your email";
  } else if (!emailValid) {
    return "" + "Please enter your valid email";
  } else {
    return null;
  }
}

Widget commonDropDownTextField(
    {OnTapPress? onTap,
    bool autoFocus = false,
    String? imageIcon,
    String? labelText,
    String? hintText,
    TextEditingController? controller,
    List<TextInputFormatter>? inputformat,
    String? Function(String?)? validator,
    String? Function(String?)? onChanged,
    String? Function(String?)? onFieldSubmitted,
    TextInputType? textInputType,
    int? maxLength,
    int maxline = 1,
    double leftIconPadding = 0,
    bool labelAlwaysOpen = true,
    bool noautovalidation = false,
    double padding = 0,
    bool isFocus = false}) {
  return TextFormField(
    onTap: onTap,
    style: boldTextStyle(fontSize: 16, txtColor: AppColors.appFontColor),
    // TextStyle(fontSize: 18, color: APP_FONT_COLOR, fontWeight: FontWeight.w600),
    readOnly: true,
    controller: controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: validator,

    // validator: (value) =>
    //     validation(value, "Please select project"),
    decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyColor)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyColor)),
        errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
        labelStyle: TextStyle(
            fontSize: 14.sp,
            color: AppColors.labelGreyColor,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500),
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(
            height: 1.8,
            fontSize: 16,
            fontFamily: fontFamily,
            color: HexColor("#898989"),
            fontWeight: FontWeight.w700),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIconConstraints: const BoxConstraints(maxWidth: 30, minWidth: 10),
        // prefixIconConstraints: BoxConstraints(maxWidth: 50),
        suffixIcon: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SvgPicture.asset(
              dropDownSvgIcons,
              height: 24,
              width: 24,
            )
            //Icon(Icons.arrow_drop_down),
            )),
  );
}

Widget phoneNumberTextField(Rxn<TextEditingController>? controller,
    [bool? readonly = false,
    bool? showCursor = true,
    bool? isPrefix = true,
    Widget? prefixIcons]) {
  return IntlPhoneCustomField(
    readOnly: readonly ?? false,
    showCursor: showCursor ?? true,
    controller: controller?.value,
    disableLengthCheck: false,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    textAlign: TextAlign.left,
    focusNode: mobileFocusNode,
    autofocus: false,
    mobilNo: false,
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
      backgroundColor: AppColors.whiteColor,
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
      if (controller!.value!.text.isNotEmpty) {}
    },
    onCountryChanged: (country) {
      selectedCountry.value = country;
      controller?.value?.text = "";
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
      // suffixIcon:
      // isPrefix!
      //     ? prefixIcons
      //     : Container(),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyColor)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey)),
      errorBorder:
          const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      disabledBorder:
          const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      focusedErrorBorder:
          const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    ),
  );
}

Widget simpleTextFieldNewWithCustomization(
    {OnTapPress? onTap,
    bool autoFocus = false,
    String? imageIcon,
    String? labelText,
    String? hintText,
    Color? labelColor,
    Rxn<TextEditingController>? controller,
    TextCapitalization? textCapitalization,
    List<TextInputFormatter>? inputFormat,
    String? Function(String?)? validator,
    String? Function(String?)? onChanged,
    String? Function(String?)? onFieldSubmitted,
    TextInputType? textInputType,
    Widget? suffixIcon,
    int? maxLength,
    int maxLine = 1,
    double leftIconPadding = 0,
    bool labelAlwaysOpen = true,
    bool noAutoValidation = false,
    bool isSuffixIcon = false,
    bool isFocus = false}) {
  return Obx(() => TextFormField(
        style: boldTextStyle(fontSize: 16, txtColor: AppColors.appFontColor),
        autovalidateMode: noAutoValidation
            ? AutovalidateMode.disabled
            : AutovalidateMode.onUserInteraction,
        onTap: onTap,

        onChanged: onChanged ??
            (value) {
              controller?.update((val) {});
            },
        // textCapitalization: TextCapitalization.sentences,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        onFieldSubmitted: onFieldSubmitted,
        maxLength: maxLength,
        validator: validator,

        keyboardType: textInputType,
        inputFormatters: inputFormat,
        controller: controller?.value,
        decoration: InputDecoration(
          // counter: Container(),
          counterText: "",
          border: InputBorder.none,
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
          enabled: true,
          // contentPadding: EdgeInsets.all(20),
          labelStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColors.labelGreyColor,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w500),
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(
              height: 1.5,
              fontSize: 16,
              fontFamily: fontFamily,
              color: HexColor("#898989"),
              fontWeight: FontWeight.w700),
          focusColor: Colors.white,
          floatingLabelBehavior: labelAlwaysOpen
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.auto,
          suffixIcon: isSuffixIcon == true ? suffixIcon : const SizedBox(),
        ),
      ));
}

Widget CommonDropDownTextField(
    {OnTapPress? onTap,
      bool autoFocus = false,
      String? imageIcon,
      String? labelText,
      String? hintText,
      TextEditingController? controller,
      List<TextInputFormatter>? inputformat,
      String? Function(String?)? validator,
      String? Function(String?)? onChanged,
      String? Function(String?)? onFieldSubmitted,
      TextInputType? textInputType,
      int? maxLength,
      int maxline = 1,
      double leftIconPadding = 0,
      bool labelAlwaysOpen = true,
      bool noautovalidation=false,
      double padding=0,
      bool isFocus = false}) {
  return TextFormField(
    onTap: onTap,
    style: boldTextStyle(fontSize: 16, txtColor: AppColors.black),
    // TextStyle(fontSize: 18, color: APP_FONT_COLOR, fontWeight: FontWeight.w600),
    readOnly: true,
    controller: controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: validator,

    // validator: (value) =>
    //     validation(value, "Please select project"),
    decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.labelGreyColor)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.labelGreyColor)),
        errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        disabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),

        labelStyle:  TextStyle(
            fontSize: 14.sp,
            color:AppColors.labelGreyColor,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500),
        labelText: labelText,
        hintText: hintText,
        hintStyle:  TextStyle(
            height: 1.8,
            fontSize: 16.sp,
            fontFamily: fontFamily,
            color: HexColor("#898989"),
            fontWeight: FontWeight.w700),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIconConstraints: const BoxConstraints(maxWidth: 30,minWidth: 10 ),
        // prefixIconConstraints: BoxConstraints(maxWidth: 50),
        suffixIcon: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child:
            SvgPicture.asset(dropDownSvgIcons,height: 24,width: 24,)
          //Icon(Icons.arrow_drop_down),
        )
    ),
  );
}

Widget ScheduleSiteVisite(String imageIcon, String labelText, String hintText,
    Rxn<TextEditingController>? controller,
    [double leftPadding = 0,
      bool labelOpen = true,
      FontWeight fontWeight = FontWeight.bold]) {
  return InkWell(
    onTap: () {
      //OpenDatePickerDOBDialog(DateTime.now(),DateTime(2100),txtscheduledate);
    },
    child: TextFormField(
      readOnly: true,
      validator: (value) => validation(value, "Please select date"),
      onTap: () {
        OpenDatePickerDOBDialog(DateTime.now(),DateTime(DateTime.now().year+5), controller);
      },
      controller: controller?.value,
      style: boldTextStyle(fontSize: 16, txtColor: AppColors.black),
      // TextStyle(fontSize: 18, color: APP_FONT_COLOR, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.labelGreyColor)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.labelGreyColor)),
        errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        disabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        // contentPadding: EdgeInsets.all(20),
        labelStyle: TextStyle(
            fontSize: 14.sp,
            color:AppColors.labelGreyColor,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500),
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(
            height: 1.8,
            fontSize: 16.sp,
            fontFamily: fontFamily,
            color: HexColor("#898989"),
            fontWeight: FontWeight.w700),
        floatingLabelBehavior: labelOpen
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,

        // prefixIcon: Container(
        //   width: 50,
        //   height: 50,
        //   margin: EdgeInsets.only(right: 10, left: leftPadding),
        //   padding: const EdgeInsets.all(10.0),
        //   decoration: CustomDecorations()
        //       .backgroundlocal(APP_GRAY_COLOR, cornarradius, 0, APP_GRAY_COLOR),
        //   child: Image.asset(imageIcon),
        // ),
      ),
    ),
  );
}

Future<void> selectTime_with_no2(BuildContext context, int startTime, Rxn<TextEditingController>? timecontroller) async {
  final TimeOfDay? picked = await showTimePicker(
    builder: (BuildContext? context, Widget? child) {
      return Column(
        children: [
          Theme(
            data: Theme.of(context!).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.appThemeColor, // <-- SEE HERE
                onPrimary: AppColors.whiteColor, // <-- SEE HERE
                onSurface: AppColors.appThemeColor, // <-- SEE HERE
              ),
              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 10), // <-- here you can do your font smaller
                  bodyText2:
                  TextStyle(fontSize: 8.0, fontFamily: 'Poppins-Medium')),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: AppColors.appThemeColor, // button text color
                ),
              ),
            ),
            child: child!,
          ),
        ],
      );
    },
    context: context,
    initialTime: startTime == 0
        ? TimeOfDay.now()
        : TimeOfDay(hour: startTime ~/ 60, minute: startTime % 60),
  );
  if (picked != null) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
    final format = DateFormat.jm();
    timecontroller!.value!.text = format.format(dt);
    print(timecontroller.toString() + "scheduledtimedsg");
    timecontroller.update((val) {});
  }
}

OpenDatePickerDOBDialog(DateTime firstdate, DateTime lastdate,
    Rxn<TextEditingController>? datecontroller) async {
  DateTime? _datePicker = await showDatePicker(
    context: Get.context!,
    initialDate: currentData,
    firstDate: firstdate,
    lastDate: lastdate,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.appThemeColor, // <-- SEE HERE
            onPrimary: AppColors.whiteColor, // <-- SEE HERE
            onSurface: AppColors.black, // <-- SEE HERE
          ),
          textTheme:const TextTheme(
              bodyText1: TextStyle(
                  fontSize: 10), // <-- here you can do your font smaller
              bodyText2:
              TextStyle(fontSize: 8.0, fontFamily: 'Poppins-Medium')),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: AppColors.black, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  if (_datePicker != null) {
    currentData = _datePicker;
    var dateFormat = DateFormat("d MMMM y");

    print(_datePicker);
    datecontroller?.value?.text = dateFormat.format(_datePicker);
    datecontroller?.update((val) { });
  }
}

String? mobileValidation(String value) {
  print(isoCode1.value.toString());
  print("isocode1.value.toString()");
  if (value.isEmpty) {
    return "       " "Please enter mobile number";
  } else if (value.trim().isNotEmpty && !value.trim().isNumericOnly) {
    return "       " "Please enter only digits";
  } else if (value.length < 10) {
    return "       " "Please enter 10 digits";
  } else if (value.length > 10) {
    return "       " "Please enter only 10 digits";
  } else if (isoCode1.value.isEmpty || isoCode1.value == "INDIA") {
    return "       " "Please select country code";
  } else {
    return null;
  }
}
