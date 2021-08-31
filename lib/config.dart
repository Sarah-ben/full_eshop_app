import 'package:fialogs/fialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class config extends GetxController{
  static  SharedPreferences sharedPreferences;
  dialog(BuildContext context,String message,String type){
    return  errorDialog(
      context,
      type,
      message,
      // positiveButtonText: "OK",
      // positiveButtonAction: () {},
      // negativeButtonText: "OK",
      // negativeButtonAction: () {},
      neutralButtonText: "OK",
      neutralButtonAction: () {
        Navigator.pop(context);
      },
      hideNeutralButton: false,
      closeOnBackPress: false,
    );
  }
  Widget reload(){
    return Material(
      type: MaterialType.transparency,
      child: new Center(
        child: new SizedBox(
          width: 100.0,
          height: 100.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.black),),
              ],
            ),
          ),
        ),
      ),
    );
  }



   static String userWishList = 'userWishList';
  static  String userCart = 'userCart';


}