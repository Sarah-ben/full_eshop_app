import 'dart:ui';

import 'package:full_eshop_app/Authentification/authentification.dart';
import 'package:full_eshop_app/newscreen/admin/addProducts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../config.dart';
class SignForm extends GetxController{
  TextEditingController email=TextEditingController();
  config c=Get.put(config());
  TextEditingController password=TextEditingController();
  Auth auth=Get.put(Auth());
  TextEditingController id=TextEditingController();
  TextEditingController passwd=TextEditingController();

  final formKey = GlobalKey<ScaffoldState>();


  AdminSigninSheet(BuildContext context){
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context, builder: (context){
      return Padding(
        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container (
          padding: EdgeInsets.symmetric(horizontal: (20.0 / 375.0) * screenWidth),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0))
          ),
          height: MediaQuery.of(context).size.height*0.45,
          width:MediaQuery.of(context).size.width ,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.45,
                width:MediaQuery.of(context).size.width ,

                child: ListView(children: [
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child:Divider(
                      thickness: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  Form(
                      child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top:25,left: 10,right: 10),
                          child:TextFormField(
                            controller: id,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "";
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                              labelText: "ID",
                              hintText: "Admin ID",
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(color: Colors.black)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(color: Colors.black)
                              ) ,
                              // If  you are using latest version of flutter then lable text and hint text shown like this
                              // if you r using flutter less then 1.20.* then maybe this is not working properly
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),
                          )
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Container(
                          margin: EdgeInsets.only(top:5,left: 10,right: 10),
                          child:TextFormField(
                            controller: passwd,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "";
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Admin password",
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(color: Colors.black)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(color: Colors.black)
                              ) ,
                              // If  you are using latest version of flutter then lable text and hint text shown like this
                              // if you r using flutter less then 1.20.* then maybe this is not working properly
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              //suffixIcon: Icon(Icons.email_outlined),
                            ),
                          )
                      ),
                    ],
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      child: Icon(FontAwesomeIcons.check,color: Colors.white,),
                      onPressed: (){
                      //  if(id.text.isNotEmpty&&passwd.text.isNotEmpty){
                          auth.adminLogin(id.text, passwd.text, context).then((value) => Get.to(()=>AddProducts()));

                      //  }
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                      mainAxisAlignment:MainAxisAlignment.center ,
                        children: [
                          Text("Users can not access to Admin side ")
                        ],
                      )
                  )
                ],),

              ),


            ],
          ),
        ),
      );
    });
  }

}