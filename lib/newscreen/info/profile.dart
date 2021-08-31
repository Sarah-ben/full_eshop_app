import 'package:full_eshop_app/newscreen/info/profileBody.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 1.0,
        title: Text('My information ',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,), onPressed: ()=>Navigator.pop(context)),
      ),
      body:GetBuilder<ProfileBody>(
        init: ProfileBody(),
          builder: (b){
          return b.pBody(context);
          }) ,
     // bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}