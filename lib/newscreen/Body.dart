import 'package:full_eshop_app/Custom-components/defaultButton.dart';
import 'package:full_eshop_app/newscreen/signin/sign_in.dart';
import 'package:full_eshop_app/newscreen/splash_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

// This is the best practice

class SplashBody extends StatefulWidget {
  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {

  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Djalal Life Style, Let’s shop!",
      "text1": "مرحبا بكم في محلات جلال لايف ستايل",
      "image": "assets/images/splash_1.png"

    },
    {
      "text":
      "We help people conect with store \naround Algeria",
       "text1":
      " نقدم افضل الملابس لكي سيدتي",
      "image": "assets/images/splashone.jpg"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "text1": "نقدم للكم طرق جديدة للتسوق والوصول الي منتوجاتكم المفضلة",
      "image": "assets/images/splashthree.jpg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                  text1: splashData[index]['text1'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: (20.0/375.0)*screenWidth),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                            (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        Get.to(()=>SignInScreen(),transition: Transition.rightToLeft);
                        //  Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    Spacer(),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
