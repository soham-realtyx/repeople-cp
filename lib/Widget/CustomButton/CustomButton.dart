



import 'package:flutter/material.dart';

Widget OnLoginTapButton(
    {BoxDecoration? decoration,
      double? height,
      double? width,
      TextStyle? style,
      String? text,
      Widget? icon,
      VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      decoration: decoration,
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon ?? Container(),
          const SizedBox(width: 6,),
          Text(
            text!,
            style: style,
          ),
        ],
      ),
    ),
  );
}
Widget OnTapButton(
    {BoxDecoration? decoration,
      double? height,
      double? width,
      TextStyle? style,
      String? text,
      Widget? icon,
      VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      decoration: decoration,
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text!,
            style: style,
          ),
          SizedBox(width: 3,),
          icon == null ? Container() : icon
        ],
      ),
    ),
  );
}