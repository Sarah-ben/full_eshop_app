import 'package:full_eshop_app/newscreen/Body.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
  //  SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SplashBody(),
      ),
    );
  }
}