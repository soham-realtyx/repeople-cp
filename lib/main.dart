import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Helper/event.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Config/functions.dart';
import 'package:repeoplecp/View/SplashScreen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Config/Helper/notification_handler.dart';
Future<void> myBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print(
      "-----------------------------------onBackgroundMessage--------------------------------------");
  }

  try {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var count = sp.getInt(notificationCount);
    if (kDebugMode) {
      print(count);
    }
    if (kDebugMode) {
      print(message.data);
    }
    isBadgeShow.value=true;
    isBadgeShow.refresh();
    // NotificationCountHandler(message.data['n_id'] ?? "");
  }
  catch (e,s) {
    if (kDebugMode) {
      print(s);
    }
  }

}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  NotificationHandler notificationHandler = NotificationHandler();
  FirebaseMessaging.onBackgroundMessage(myBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen(notificationHandler.onMessageOpenApp);
  FirebaseMessaging.onMessage.listen(notificationHandler.onMessage);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FlutterError.onError = (flutterdetails)=>FirebaseCrashlytics.instance.recordFlutterError(flutterdetails);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectionResult) {
      if (connectionResult == ConnectivityResult.mobile ||
          connectionResult == ConnectivityResult.wifi) {
        checkInternetStatus().then((value) {
          if (value) {
            Get.back();
          } else {
            showNoInternetDialog();
          }
          eventBus.fire(InternetConnectionChanged(status: value));
        });
      } else {
        showNoInternetDialog();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      color: AppColors.whiteColor,
      defaultGlobalState: true,
      debugShowCheckedModeBanner: false,
      themeMode:ThemeMode.light,
      theme: ThemeData(
        primaryColor: AppColors.appThemeColor,
        fontFamily: 'Montserrat',
        // primarySwatch: AppColors.appThemeColor,
        appBarTheme: AppBarTheme(
          color: AppColors.whiteColor,
          centerTitle: true,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
