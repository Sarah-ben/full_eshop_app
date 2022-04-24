import 'package:flutter/material.dart';

import 'forgot-body.dart';


class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text('Forgot password',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,), onPressed: ()=>Navigator.pop(context)),
      ),
      body: ForgotBody(),
    );
  }
}