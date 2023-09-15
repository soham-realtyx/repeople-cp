

import 'package:flutter/material.dart';
import 'package:repeoplecp/Config/Helper/HexColor.dart';
import 'package:repeoplecp/Config/Utils/styles.dart';

class CustomDecorations {
  BoxDecoration background(Color bgColor,double radius,double width,Color borderColor){
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(
            color:borderColor,
            width: width),
        color: bgColor
    );
  }
  BoxDecoration exploreMoreBackground(String bgColor,double radius,double width,String borderColor){
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        boxShadow: [smallcontainerboxShadow],
        border: Border.all(
            color:HexColor(borderColor) ,
            width: width),
        color: HexColor(bgColor)
    );
  }
  BoxDecoration backgroundLocal(Color bgColor,double radius,double width,Color borderColor){
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(
            color:borderColor,
            width: width),
        color: bgColor,
        boxShadow: [
          fullcontainerboxShadow
        ]
    );
  }

  BoxDecoration backgroundWithoutBorder(MaterialColor bgColor,double radius,double width){
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: bgColor
    );
  }

  BoxDecoration backgroundWithShadow(
      MaterialColor bgColor,double radius,double width,MaterialColor borderColor){
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        boxShadow: [smallcontainerboxShadow],
        border: Border.all(
            color:borderColor,
            width: width),
        color: bgColor
    );
  }


}

