import 'package:eshop_update/shared/components/components.dart';
import 'package:eshop_update/shared/styles/colors.dart';
import 'package:eshop_update/views/home/home.dart';
import 'package:eshop_update/views/settings/profileBody.dart';
import 'package:eshop_update/views/welcomeScreen/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eshop_update/shared/config.dart';

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
      body:SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            // ProfilePic(),
            // SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.grey.withOpacity(.1),
                onPressed: () {
                  myInfoSheet(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person_sharp,
                          color: kPrimaryColor.withOpacity(.3),
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text('My Info'),
                            Text('معلوماتي')
                          ],
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.grey.withOpacity(.1),
                onPressed: () {
                  Get.to(()=>HomeScreen(), transition: Transition.leftToRight);
                },
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: kPrimaryColor.withOpacity(.3),
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text('Home'),
                            Text('الرئيسية')
                          ],
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.grey.withOpacity(.1),
                onPressed: () {
                  aboutUs(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: kPrimaryColor.withOpacity(.3),
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text('about us'),
                            Text('عنا')
                          ],
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.grey.withOpacity(.1),
                onPressed: () {
                  ReportWidget(context);
                  //  auth.signOut();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.report,
                          color: kPrimaryColor.withOpacity(.3),
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text('Report a problem'),
                            Text('الابلاغ عن مشكلة')
                          ],
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: FlatButton(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.grey.withOpacity(.1),
                onPressed: () {
                   FirebaseAuth.instance.signOut().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c){
                    return SplashScreen();
                  })));
                },
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Text('Log out'),
                            Text('تسجيل الخروج')
                          ],
                        ),
                      ],
                    ),
                    Icon(Icons.login_outlined),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
     // bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
