import 'package:flutter/material.dart';

import 'body.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text('Signup',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,), onPressed: ()=>Navigator.pop(context)),
      ),
      body: BodySignup(),
    );
  }
}