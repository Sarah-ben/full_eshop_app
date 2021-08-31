import 'package:flutter/material.dart';

import '../constants.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.text1,
    this.image,
  }) : super(key: key);
  final String text, image,text1;

  @override
  Widget build(BuildContext context) {
    var screenHeight=MediaQuery.of(context).size.height;
    var screenWidth=MediaQuery.of(context).size.width;
    return  Column(
        children: <Widget>[
          Spacer(),
          Text(
            "Djalal Lifestyle",
            style: TextStyle(
              fontSize: (25.0/375.0)*screenWidth,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.0,),
          Text(
            text1,
            textAlign: TextAlign.center,
          ),
          Spacer(flex: 2),
          Image.asset(
            image,
            height:(265.0/812.0)*screenHeight,
            width: (235.0/375.0)*screenWidth,
          ),
        ],
      );

  }
}