import 'package:full_eshop_app/newscreen/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize:  (16.0/375.0)*screenWidth),
        ),
        GestureDetector(
          onTap: ()=>Get.to(()=>SignUpScreen(),transition: Transition.rightToLeft),
         // onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize:  (16.0/375.0)*screenWidth,
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}