
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:repeoplecp/Widget/custom_textField.dart';

class LoginController extends GetxController {

  var formKeys = GlobalKey<FormState>();
  var otpFormKeys = GlobalKey<FormState>();
  bool isSendVerify = false;

  int levelClock = 60;
  late OTPInteractor _OTPInteractor;
  RxBool isOtpFieldShown = false.obs;
  Rx<Duration> duration = const Duration().obs; // for timer
  Timer? timer;
  final mcnTxt = Get.context;
  RxBool timerIsActive = true.obs;
  
  RxInt isUser=0.obs;
  RxString isRegister="".obs;

  FocusNode mobileFocusNode = FocusNode();
  FocusNode referFocusNode = FocusNode();
  FocusNode otpFocusNode = FocusNode();
  GlobalKey<ScaffoldState> globalLoginPageKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> globalOtpPageKey = GlobalKey<ScaffoldState>();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtContact = TextEditingController();
  TextEditingController txtProject = TextEditingController();
  TextEditingController txtBudget = TextEditingController();
  TextEditingController txtScheduleDate = TextEditingController();
  TextEditingController txtScheduleTime = TextEditingController();
  TextEditingController txtQuery = TextEditingController();
  OTPTextEditController? txtOtp = OTPTextEditController(codeLength: 6);
  OTPTextEditController? txtOtp1 = OTPTextEditController(codeLength: 6);
  Rxn<TextEditingController> txtContactNew = Rxn(TextEditingController());


  @override
  void onClose() {
    super.onClose();
    isoCode1.value = "";
    isoCode1.obs;
    // isocode="";
    txtContact.clear();
    txtContactNew.value?.clear();
    cCode = "";
    //Get.delete<DashboardController>();
  }


  // OTP Function
  RxBool isReferralText = false.obs;
  RxBool isReferralCode = true.obs;

  RxInt isNewUser=0.obs;
  RxString mobileNo="".obs;
  RxString otp = "".obs;

  RxInt countText = 45.obs;
  countDown() {
    countText.value = 45;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countText.value == 0) {
        timer.cancel();
        countText.refresh();
        update();
      } else {
        countText.value--;
        countText.refresh();
        update();
      }
    });
  }



  // send otp
  void startTimer() {
    duration.value = const Duration(seconds: 60);
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    const addSeconds = -1;
    final seconds = duration.value.inSeconds + addSeconds;
    if (seconds < 0) {
      timerIsActive.value = false;
      timer?.cancel();
    } else {
      duration.value = Duration(seconds: seconds);
    }
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    // final hours=twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.value.inMinutes.remainder(60));
    final seconds = twoDigits(duration.value.inSeconds.remainder(60));

    return Text('$minutes:$seconds',
        style: const TextStyle(fontSize: 12, color: Colors.black)
        // boldTextStyle(fontSize: 12,
        //     txtColor: AppColors.TEXT_FIELD_COLOR),
        );
    // return Text('${duration.inSeconds}',style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: poppins_regular),);
  }

  customListener() {
    try {
      _OTPInteractor = OTPInteractor();
      _OTPInteractor
          .getAppSignature()
          //ignore: avoid_print
          .then((value) => print('signature - $value'));
      txtOtp1 = OTPTextEditController(
        codeLength: 6,
        //ignore: avoid_print
        onCodeReceive: (code) {
          print('Your Application receive code - $code');
          txtOtp!.clear();
          txtOtp!.text = txtOtp1!.text;
        },
        otpInteractor: _OTPInteractor,
      )..startListenUserConsent(
          (code) {
            final exp = RegExp(r'(\d{4})');
            return exp.stringMatch(code ?? '') ?? '';

          },
          strategies: [],
        );
    } catch (e) {
      print(e);
    }
  }
}
