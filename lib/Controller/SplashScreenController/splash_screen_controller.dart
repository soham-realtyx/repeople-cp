
import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Helper/AppMaintanance/app_maintainance.dart';
import 'package:repeoplecp/Config/Helper/AppUpgrade/app_upgrade.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/View/SendOTPPage/send_otp_page.dart';

class SplashScreenController extends GetxController{
  final FirebaseRemoteConfig remoteConfig =
      FirebaseRemoteConfig.instance;


  @override
  void onInit() {
    super.onInit();

  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 4), onLoadDone);
  }

  onLoadDone() async{
      Get.offAll(()=> const SendOTPPage());
  }

  Future<void> check_app_update() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(
          seconds: 1), // a fetch will wait up to 10 seconds before timing out
      minimumFetchInterval: const Duration(
          seconds:
          1), // fetch parameters will be cached for a maximum of 1 hour
    ));
    fetchUpdate();
  }

  void fetchUpdate() async {
    await remoteConfig.fetchAndActivate();
    updateMessage.value = remoteConfig.getString('update_msg') != ""
        ? remoteConfig.getString('update_msg')
        : "There is a newer version of app available please update it now.";
    version.value = remoteConfig.getString('version_name') != ""
        ? remoteConfig.getString('version_name')
        : "Version :";
    forceUpdate.value = remoteConfig.getBool('is_force_update')
        ? remoteConfig.getBool('is_force_update')
        : false;
    if (remoteConfig.getBool('is_update_available')) {
      if (packageInfo.version != remoteConfig.getString('version_name')) {
        Get.to(()=>AppUpgradePage(
          msg: updateMessage.value,
          forceUpdate: forceUpdate.value, versioncode: version.value,
        ));
      }
    }
    if (remoteConfig.getBool('uder_mantanation')) {
      Get.to(()=>const AppMaintenancePage());
    }
    print("version_name:${remoteConfig.getString('version_name')}");
    print("is_force_update:${remoteConfig.getBool('is_force_update')}");
    print("is_update_available:${remoteConfig.getBool('is_update_available')}");
  }

}