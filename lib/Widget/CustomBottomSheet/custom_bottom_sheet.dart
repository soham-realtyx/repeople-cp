

import 'package:flutter/material.dart';
import 'package:repeoplecp/Config/Utils/colors.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/Widget/custom_textField.dart';

void loginDialogue({
  BuildContext? context,
  BorderRadius? mainContainerBorder,
  Color? borderColor,
  double? stackRadius,
  required Widget stackIcon,
  BorderRadius? stackBorder,
  BorderRadius? buttonBorder,
  MaterialColor? stackColor,
  MaterialColor? mainContainerColor,
  required String dialogText,
  // required Container firstButton,
  required OnTapPress firstButtonTap,
  required String firstButtonText,
  Color? firstButtonTextColor,
  BoxDecoration? firstButtonBoxDecoration,
  FontWeight? firstButtonTextFontWeight,
  required OnTapPress secondButtonTap,
  required String secondButtonText,
  Color? secondButtonTextColor,
  BoxDecoration? secondButtonBoxDecoration,
  FontWeight? secondButtonTextFontWeight,
  // required Container secondButton,

}){
  showDialog(
      barrierColor: Colors.black.withOpacity(0.3),
      barrierDismissible: false,
      context: contextCommon,
      builder: (context){
        return
          Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: mainContainerBorder?? BorderRadius.circular(15.0)
              ),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                    
                        color: mainContainerColor,
                        borderRadius: buttonBorder ?? const BorderRadius.all(Radius.circular(20))),
                    height: 190,
                    child: Column(
                      children: [
                        const SizedBox(height: 5,),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding:  const EdgeInsets.only(top: 20,left: 10,right: 10),
                            child: Center(
                              child: Text(
                                dialogText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: AppColors.appThemeColor
                                ),),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: GestureDetector(
                                      onTap: firstButtonTap,
                                      child: Container(
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15))
                                        ),
                                        child: Material(
                                            elevation: 1,
                                            color: AppColors.whiteColor,
                                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15)),
                                            child:
                                            Center(child: Text(firstButtonText,style:
                                            const TextStyle(fontWeight: FontWeight.w600),))),
                                      ),
                                    )
                                ),
                                Expanded(
                                    child: GestureDetector(
                                      onTap: secondButtonTap,
                                      child: Container(
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15))
                                        ),
                                        child: Material(
                                            elevation: 1,
                                            color: AppColors.appThemeColor,
                                            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(15)),
                                            child: Center(
                                                child:
                                                Text(secondButtonText,style:
                                                TextStyle(color: AppColors.whiteColor,fontWeight: FontWeight.w600),))),
                                      ),
                                    )
                                ),





                              ],
                            ),
                          ),
                        ),
                        // SizedBox(height:20.0)



                      ],
                    ),
                  ),
                  Positioned(
                    top: -35,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: stackBorder ?? const BorderRadius.all(Radius.circular(40))),
                        child: CircleAvatar(
                          backgroundColor:stackColor,
                          // backgroundColor: Colors.grey[900],
                          radius: stackRadius?? 35,
                          child: stackIcon,
                          // const Icon(Icons.exit_to_app,size: 40.0,color:Colors.white,
                        )
                    ),
                  )
                ],
              )
          );

      }
  );
}