import 'package:flutter/material.dart';



class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon({
    Key key,
    @required this.svgIcon,
  }) : super(key: key);

  final String svgIcon;

  @override
  Widget build(BuildContext context) {

    var screenHeight=MediaQuery.of(context).size.height;
    var screenWidth=MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        (20.0/375.0)*screenWidth,
        (20.0/375.0)*screenWidth,
        (20.0/375.0)*screenWidth,
      ),
    /*  child: SvgPicture.asset(
        svgIcon,
        height:  (18.0/375.0)*screenWidth,
      ),*/
    );
  }
}