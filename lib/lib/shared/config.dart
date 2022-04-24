import 'package:fialogs/fialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class config extends GetxController{
  static  SharedPreferences sharedPreferences;
 static String userWishList = 'userWishList';
 static String userCart = 'userCart';
 
}