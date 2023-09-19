import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


Widget shimmerWidget({double height =0, double width=0,double radius=0,Color? color}){
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        color:color?? Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius)
    ),
  );
}

Widget ShimmerEffect({required Widget child,Color? baseColor,Color? highlightColor}){
  return Shimmer.fromColors(baseColor: baseColor ?? Colors.grey.shade300, highlightColor:highlightColor ??Colors.grey.shade100, child: child );
}