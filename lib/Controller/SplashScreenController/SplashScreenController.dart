
import 'dart:async';

import 'package:get/get.dart';
import 'package:repeoplecp/View/SendOTPPage/SendOTPPage.dart';

class SplashScreenController extends GetxController{

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 4), onLoadDone);
  }

  onLoadDone() async{
      Get.offAll(()=> const SendOTPPage());
  }

}