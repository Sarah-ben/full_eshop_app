import 'package:flutter/material.dart';


class SocalCard extends StatelessWidget {
  const SocalCard({
    Key key,
    this.icon,
    this.press,
  }) : super(key: key);

  final String icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin:
        EdgeInsets.symmetric(horizontal:  (10.0/375.0)*screenWidth),
        padding: EdgeInsets.all( (12.0/375.0)*screenWidth),
        height: (50.0/812.0)*screenHeight,
        width:  (50.0/375.0)*screenWidth,
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          shape: BoxShape.circle,
        ),
        child: Image.asset(icon),
      ),
    );
  }
}
