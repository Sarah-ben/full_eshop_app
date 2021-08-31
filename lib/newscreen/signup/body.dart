import 'package:full_eshop_app/Custom-components/socal-card.dart';
import 'package:full_eshop_app/newscreen/signup/signup-form.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class BodySignup extends StatelessWidget {
  var url='https://www.facebook.com/Djalal.Lifestyle';
   openUrl(context)async{
    if(await canLaunch(url)) {
      await launch(url);
    }else
      {
        Toast.show('something went wrong , please try again .حدث خطا ما يرجى اعادة المحاولة لاحقا ،', context,gravity: Toast.BOTTOM);
      }
  }
  @override
  Widget build(BuildContext context){
    var screenHeight=MediaQuery.of(context).size.height;
    var screenWidth=MediaQuery.of(context).size.width;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: (20.0/375.0)*screenWidth),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.01), // 4%
                Text("Register Account", style: TextStyle(
                  fontSize: (28.0/375.0)*screenWidth,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.5,
                )),
                Text(
                  "Complete your details to continue \nor sign in ",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.08),
                SignUpForm(),
                SizedBox(height: screenHeight * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                       margin: EdgeInsets.symmetric(horizontal:  (10.0/375.0)*screenWidth),
                        padding: EdgeInsets.all( (12.0/375.0)*screenWidth),
                        height: (50.0/812.0)*screenHeight,
                        width:  (50.0/375.0)*screenWidth,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('assets/images/fb.jpg'),
                      ),
                    ),
                    SocalCard(
                      icon: "assets/images/instag.png",
                      press: () {},
                    ),

                  ],
                ),
                SizedBox(height: (20.0/812.0)*screenHeight),
                Text(
                  "This app does'nt contain any ads and there is no access to user informations",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}