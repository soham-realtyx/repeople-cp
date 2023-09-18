import 'package:flutter/material.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/View/BottomNavigationBarPage/BottomNavigationBarPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: const BottomNavigationBarPage(),
    );
  }
}
