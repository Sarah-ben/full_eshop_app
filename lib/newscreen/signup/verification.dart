import 'dart:async';

import 'package:full_eshop_app/newscreen/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  User user;
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  Timer timer;
  @override
  void initState() {
    user=firebaseAuth.currentUser;
    user.sendEmailVerification();
    timer=Timer.periodic(Duration(seconds: 5), (t){
      checkMail();
    });
    super.initState();
  }
  Future checkMail()async{
    user=firebaseAuth.currentUser;
    await user.reload();
    if(user.emailVerified){
      timer.cancel();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3,
                margin:  EdgeInsets.only(top:20.0,left: 10.0,right: 10.0),
                child:Text('A link has been send to ${user.email}, check to complete registration\nتم ارسال رابط الى ${user.email}،يرجي النقر لتاكيد الهوية',style: TextStyle(fontWeight: FontWeight.w500,fontSize: MediaQuery.of(context).size.width*.05,color: Colors.black87),textAlign:TextAlign.center ,),
              ),
              CircularProgressIndicator(valueColor:AlwaysStoppedAnimation(Colors.red),),

            ],
          )
      ),
    );
  }
}
