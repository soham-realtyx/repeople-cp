import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/View/HomePage/home_page.dart';
import 'package:repeoplecp/View/SplashScreen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const HomePage(),
    );
  }
}
