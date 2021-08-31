import 'dart:ui';

import 'package:full_eshop_app/Authentification/authentification.dart';
import 'package:full_eshop_app/newscreen/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:full_eshop_app/config.dart';
import '../../constants.dart';

class ProfileBody extends GetxController {
  Auth auth = Get.put(Auth());
  Widget pBody(BuildContext context) {
    return SingleChildScrollView(
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
                auth.signOut(context);
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
    );
  }
  myInfoSheet(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: (20.0 / 375.0) * screenWidth),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: ListView(
               // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.0),
                      Container(
                        margin: EdgeInsets.only(left: 10,right: 10),

                        width: screenWidth,
                        child:
                            Text(
                              config.sharedPreferences.getString('name'),
                              style: TextStyle(
                                  fontSize: screenWidth * .05,
                                  fontWeight: FontWeight.bold),
                            ),


                        ),

                      SizedBox(height: 15.0),


                            Container(
                              width:MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text(config.sharedPreferences.getString('email'),style:TextStyle(color:Colors.blue))),


                    ],
                  ),
                  Divider(
                    color: kTextColor,
                  ),

                ],
              ),
            ),
          );
        });
  }
  config c = Get.put(config());
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> ResetformKey = GlobalKey<FormState>();
   /*editName(BuildContext context) {
  return  showModalBottomSheet(context: context , builder: (context){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 170,
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child:
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Change name',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    'تغيير الاسم',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Form(
              key: ResetformKey,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'New name',
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                controller: name,
                autocorrect: true,
                validator: (v) {
                  if (v.isEmpty) {
                    return 'name is empty ';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                SizedBox(
                  width: 8,
                ),
                RaisedButton(
                  onPressed: () async {
                    showDialog(context: context,
                        builder: (BuildContext context){
                          return c.reload();
                        });
                    if (ResetformKey.currentState.validate()) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(config.sharedPreferences.getString('uid'))
                          .update({'username': name.text})
                          .then((value) => {
                        config.sharedPreferences
                            .setString('name', name.text)
                      })
                          .catchError((onError) {
                        return errorDialog(
                          context,
                          "Error",
                          "${onError.message}",
                          // positiveButtonText: "OK",
                          // positiveButtonAction: () {},
                          // negativeButtonText: "OK",
                          // negativeButtonAction: () {},
                          neutralButtonText: "OK",
                          neutralButtonAction: () {
                            Navigator.pop(context);
                            name.clear();
                          },
                          hideNeutralButton: false,
                          closeOnBackPress: false,
                        );
                      }).then((value) =>Get.to(()=>Profile(), transition: Transition.leftToRight));
                    }
                  },
                  elevation: 0,
                  color: Colors.red,
                  child: Text('Reset',
                      style: TextStyle(color: Colors.white)),
                )
              ],
            )
          ],
        ),

      );
    });
  }
  */
  final Uri params = Uri(
    scheme: 'mailto',
    path: 'djalaldjalalrabah@gmail.com',
    query: 'subject=App Feedback&body=App Version 3.23', //add subject and body here
  );
   final Uri param = Uri(
    scheme: 'mailto',
    path: 'sarah.bensalem.cs@gmail.com',
    query: 'subject=App Feedback&body=App Version 3.23', //add subject and body here
  );
 /*  editEmail(BuildContext context) {
    return showModalBottomSheet(context: context, builder: (context){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 170,
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child:Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Change email',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    'تغيير الايمايل',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Form(
              key: ResetformKey,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'New Email',
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                controller: name,
                autocorrect: true,
                validator: (v) {
                  if (v.isEmpty) {
                    return 'Email is empty ';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                SizedBox(
                  width: 8,
                ),
                RaisedButton(
                  onPressed: () async {
                    showDialog(context: context,
                        builder: (BuildContext context){
                          return c.reload();
                        });
                    if (ResetformKey.currentState.validate()) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(config.sharedPreferences.getString('uid'))
                          .update({'userEmail': email.text})
                          .then((value) => {
                        config.sharedPreferences
                            .setString('email', email.text)
                      })
                          .catchError((onError) {
                        return errorDialog(
                          context,
                          "Error",
                          "${onError.message}",
                            neutralButtonText: "OK",
                          neutralButtonAction: () {
                            Navigator.pop(context);
                            email.clear();
                          },
                          hideNeutralButton: false,
                          closeOnBackPress: false,
                        );
                      }).then((value) => Get.to(()=>Profile(), transition: Transition.leftToRight));
                    }
                  },
                  elevation: 0,
                  color: Colors.red,
                  child: Text('Reset',
                      style: TextStyle(color: Colors.white)),
                )
              ],
            )
          ],
        ),

      );
    });
  }
  */
  aboutUs(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            width:MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset('assets/images/loc.png')
                      ),

                      Container(
                          width:MediaQuery.of(context).size.width,
                         child:Row(
                           children: [
                            Container(
                                width:MediaQuery.of(context).size.width,
                                padding :EdgeInsets.all(20.0),
                                child: RichText(text: TextSpan(
                                  text: 'Djalal Lifestyle ',
                                  style: TextStyle(fontSize: 20.0,color: Colors.red,fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                       text: ',boutique de luxe située au 4 ème étage du centre commercial RITEDJMALL à Constantine, spécialisée dans la vente de vêtements pour femmes: chez nous quelque soit votre style, vous trouverez l’article qui vous correspond',style:TextStyle(fontSize: MediaQuery.of(context).size.width*.05,color:Colors.black,fontWeight: FontWeight.w400))
                                  ]
                                ))

                            )
                           ],
                         )
                      ),
                      Container(
                        padding:EdgeInsets.only(left:20.0),
                        child: Row(
                          children: [
                            Icon(Icons.info),
                            SizedBox(width: 20.0,),
                            Text('Boutique/magazin',
                                style:TextStyle(fontSize: MediaQuery.of(context).size.width*.05,color:Colors.black,fontWeight: FontWeight.w400))
                          ],
                        ),
                      ),

                       Container(
                         padding:EdgeInsets.only(left:20.0),
                         child: Row(
                            children: [
                              Icon(Icons.phone,color: Colors.blue,),
                              SizedBox(width: 5.0,),
                              FlatButton(
                                  onPressed: () => launch("tel://0777 90 59 82"),
                                  child: new Text("0777 90 59 82     Call",style:TextStyle(fontSize: MediaQuery.of(context).size.width*.05,color:Colors.black,fontWeight: FontWeight.w400))),
                            ],
                        ),
                      ),
                      Container(
                        padding:EdgeInsets.only(left:20.0),
                              child: Row(
                              children: [
                                Icon(Icons.email,color: Colors.red,),
                                SizedBox(width: 5.0,),
                                FlatButton(
                                    onPressed: ()async {var urls = params.toString();
                                    if (await canLaunch(urls)) {
                                    await launch(urls);
                                    } else {
                                    throw 'Could not launch $urls';
                                    }
                                    },
                                    child: new Text("djalaldjalalrabah@gmail.com",style:TextStyle(fontSize:MediaQuery.of(context).size.width*.05,color:Colors.black,fontWeight: FontWeight.w400))),
                              ],
          )
                      ),
                      Container(
                          padding:EdgeInsets.only(left:20.0),
                          child: Row(
                              children: [
                                Container(
                                  width: 25.0,
                                  height:25.0 ,
                                  child: Image.asset('assets/images/fb.jpg'),

                                ),
                                SizedBox(width: 10.0,),

                                InkWell(
                                  onTap: ()async{
                                    var urll = 'https://www.facebook.com/Djalal.Lifestyle';
                                    if (await canLaunch(urll)) {
                                    await launch(urll);
                                    } else {
                                    throw 'Could not launch $urll';
                                    }
                                  },
                                  child: Text('/Djalal.Lifestyle',style:TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.w500)),
                                )
                              ])


                      ),

                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
  ReportWidget(BuildContext context){
     return showModalBottomSheet(context: context, builder: (context){
       return Container(
         width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height*.15,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
          Text(' Contact us /تواصل معنا ',style:TextStyle(fontSize: 17.0,color:Colors.black,fontWeight: FontWeight.bold)),
             Container(
               width: MediaQuery.of(context).size.width,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Container(
                     padding:EdgeInsets.only(left:20.0),
                     child: Row(
                       children: [
                         Icon(Icons.phone,color: Colors.blue,),
                         SizedBox(width: 10.0,),
                         FlatButton(
                             onPressed: () => launch("tel://0540996396"),
                             child: new Text("Phone",style:TextStyle(fontSize: 17.0,color:Colors.black,fontWeight: FontWeight.w400))),
                       ],
                     ),
                   ),
                   Container(
                       padding:EdgeInsets.only(left:20.0),
                       child: Row(
                         children: [
                           Icon(Icons.email,color: Colors.red,),
                           SizedBox(width: 10.0,),
                           FlatButton(
                               onPressed: ()async {var urlh = param.toString();
                               if (await canLaunch(urlh)) {
                                 await launch(urlh);
                               }
                               else {
                                 throw 'Could not launch $urlh';
                               }
                               },
                               child: new Text("Gmail",style:TextStyle(fontSize: 17.0,color:Colors.black,fontWeight: FontWeight.w400))),
                         ],
                       )
                   ),
                 ],
               ),
             )
           ],
         ),
       );
     });
  }
}