import 'package:flutter/material.dart';

class SizeConfig{
  static double screenWith = 0;
  static double screenHeiht = 0;

  void init(BoxConstraints constraints){
    screenWith = constraints.maxWidth;
    screenHeiht = constraints.maxHeight;
  }

  static double getScreenPropotionHeight(double actualHeight){
    //812 is the artboardHight
    return (actualHeight / 900.0)*screenHeiht;
  }

  static double getScreenPropotionWidth(double actualWidth){
    //375 is the artboard with
    return (actualWidth / 375.0) * screenWith;
  }

}