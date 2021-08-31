import 'package:full_eshop_app/Custom-components/defaultButton.dart';
import 'package:full_eshop_app/Custom-components/noAccountText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

class ForgotBody extends StatelessWidget {
  ForgotPassForm forgotPassForm=Get.put(ForgotPassForm());
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: (20.0/375.0)*screenWidth),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: (45.0/812.0)*screenWidth,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.1),
             forgotPassForm.form(context)
             // ForgotPassForm(context),
            ],
          ),
        ),
      ),
    );
  }
}

class  ForgotPassForm extends GetxController{
  TextEditingController email=TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget form(BuildContext context){
    var screenHeight=MediaQuery.of(context).size.height;

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value.isEmpty) {
                return "Email is empty";
              } else return null;
            },
            decoration: InputDecoration(

              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Colors.black)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Colors.black)
              ) ,
              labelText: "Email",
              hintText: "Enter your email",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.email_outlined),
              //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: (30.0/812.0)*screenHeight),
          SizedBox(height: screenHeight * 0.1),
          DefaultButton(
            text: ""
                "Reset",
            press: () {

              if (formKey.currentState.validate()) {
                FirebaseAuth.instance.sendPasswordResetEmail(email: email.text).then((value){
                  Toast.show('A link has been sent to ${email.text} to reset your password', context);
                }).then((value) =>Navigator.pop(context) );
                // Do what you want to do
              }
            },
          ),
          SizedBox(height: screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }
}