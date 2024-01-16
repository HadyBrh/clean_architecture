import 'package:flutter/cupertino.dart';

class Constants{

  static double getScreenWidth(BuildContext context){
    return MediaQuery.sizeOf(context).width;

  }
  static double getScreenHeight(BuildContext context){
    return MediaQuery.sizeOf(context).height;
  }

  static double getSafeAreaHeight(BuildContext context){
    return MediaQuery.of(context).padding.top;
  }
}

