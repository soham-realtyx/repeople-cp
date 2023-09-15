
import 'package:flutter/material.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/SizeConfig.dart';

String fontFamily = "Montserrat";

TextStyle lightTextStyle({int fontSize = 14, Color? txtColor,FontWeight? fontWeight}) => TextStyle(
    fontSize: fontSize.sp,
    color: txtColor ?? AppColors.black,
    fontWeight: fontWeight??FontWeight.w300,
    fontFamily: fontFamily);

TextStyle regularTextStyle(
    {int fontSize = 14, Color? txtColor, FontWeight? fontWeight}) =>
    TextStyle(
        fontSize: fontSize.sp,
        color: txtColor ?? AppColors.black,
        fontFamily: fontFamily,
        fontWeight: fontWeight);

TextStyle mediumTextStyle({int fontSize = 14, Color? txtColor,FontWeight? fontWeight}) => TextStyle(
    fontSize: fontSize.sp,
    color: txtColor ?? AppColors.black,
    fontWeight: fontWeight??FontWeight.w500,
    fontFamily: fontFamily);

TextStyle semiBoldTextStyle({int fontSize = 14, Color? txtColor,FontWeight? fontWeight}) => TextStyle(
  fontSize: fontSize.sp,
  color: txtColor ?? AppColors.black,
  fontWeight: fontWeight??FontWeight.w600,
  fontFamily: fontFamily,
);

TextStyle boldTextStyle({int fontSize = 14, Color? txtColor,FontWeight? fontWeight}) => TextStyle(
    fontSize: fontSize.sp,
    color: txtColor ?? AppColors.black,
    fontWeight: fontWeight??FontWeight.w700,
    fontFamily: fontFamily);

TextStyle extraBoldTextStyle({int fontSize = 14, Color? txtColor,FontWeight? fontWeight}) => TextStyle(
    fontSize: fontSize.sp,
    color: txtColor ?? AppColors.black,
    fontWeight: fontWeight??FontWeight.w800,
    fontFamily: fontFamily);

BoxShadow fullcontainerboxShadow = BoxShadow(
    color: hex("266CB5").withOpacity(0.03),
    blurRadius: 4,
    offset: const Offset(0, 0),
    spreadRadius: 4);
BoxShadow newcontainerboxShadow = BoxShadow(
    color: AppColors.black.withOpacity(0.03),
    blurRadius: 6,
    offset: const Offset(0, 3),
    spreadRadius: 0);

BoxShadow smallcontainerboxShadow = BoxShadow(
    color: Colors.black.withOpacity(0.03),
    blurRadius: 4,
    offset: const Offset(0, 6),
    spreadRadius: 2);