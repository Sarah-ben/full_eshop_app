import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:eshop_update/shared/components/components.dart';
import 'package:eshop_update/shared/cubit/AppCubit/app_cubit.dart';
import 'package:eshop_update/shared/cubit/AuthCubit/auth_cubit.dart';
import 'package:eshop_update/shared/cubit/AuthCubit/auth_states.dart';
import 'package:eshop_update/views/home/homeWithoutAuth.dart';
import 'package:eshop_update/views/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import '../../shared/config.dart';
import 'package:eshop_update/shared/styles/colors.dart';
import 'forgot-password.dart';
import 'package:eshop_update/shared/config.dart';
class SignInScreen extends StatefulWidget {
  // static String routeName = "/sign_in";
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }


    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  SignForm signForm = Get.put(SignForm());

  config c = Get.put(config());


  TextEditingController id = TextEditingController();

  TextEditingController mail = TextEditingController();

  TextEditingController name = TextEditingController();

  TextEditingController password = TextEditingController();

  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<AuthCubit,AuthStates>(builder: (context,state){
      return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            actions: [
              FlatButton(
                  onPressed: () {
                    Get.to(() => HomeWithoutAuth());
                  },
                  child: Icon(Icons.home))
            ],
            title: Text(
              'Signin',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context)),
          ),
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: (20.0 / 375.0) * screenWidth),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.04),
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: (28.0 / 375.0) * screenWidth,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Sign in with your email and password  \nor create a new account",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.08),
                      Container(
                        child: Column(
                          children: [
                            Form(
                              key: key,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: mail,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Email is empty";
                                      } else if (!emailValidatorRegExp
                                          .hasMatch(value)) {
                                        return "Email incorrect";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      hintText: "Enter your email",
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(15.0),
                                          borderSide:
                                          BorderSide(color: Colors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(15.0),
                                          borderSide:
                                          BorderSide(color: Colors.black)),
                                      // If  you are using latest version of flutter then lable text and hint text shown like this
                                      // if you r using flutter less then 1.20.* then maybe this is not working properly
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                      suffixIcon: Icon(Icons.email_outlined),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * .03),
                                  TextFormField(
                                    controller: password,
                                    obscureText: AppCubit.get(context).pressedBool,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Password is empty";
                                      } else if (value.length < 8) {
                                        return "Password incorrect";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        labelText: "Password",
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                            borderSide:
                                            BorderSide(color: Colors.black)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                            borderSide:
                                            BorderSide(color: Colors.black)),
                                        hintText: "Enter your password",
                                        // If  you are using latest version of flutter then lable text and hint text shown like this
                                        // if you r using flutter less then 1.20.* then maybe this is not working properly
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (c) {
                                                  return SimpleDialog();
                                                });
                                            AppCubit.get(context).changeStatus();
                                          },
                                          child: AppCubit.get(context).pressedBool == true
                                              ? Icon(Icons.visibility_off)
                                              : Icon(Icons.visibility),
                                        )
                                      //CustomSurffixIcon(svgIcon: Icons.email_outlined,),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * .03),
                            Row(
                              children: [
                                Spacer(),
                                GestureDetector(
                                  onTap: () => Get.to(()=>ForgotPasswordScreen()),
                                  child: Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: screenHeight * .03),
                            SizedBox(
                              width: double.infinity,
                              height: (56.0 / 812.0) * screenHeight,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.red,
                                onPressed: () async {
                                  if(_connectionStatus=='${ConnectivityResult.mobile}'&&_connectionStatus=='${ConnectivityResult.mobile}'){
                                    if (key.currentState.validate()) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return reload();
                                          });
                                      AuthCubit.get(context).signinWithEmail(
                                          mail.text, password.text, context);
                                    }
                                  }
                                  else
                                  {
                                    Toast.show('     you are offline\n  فشل الاتصال بالانترنت', context);
                                  }

                                },
                                child: Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: (18.0 / 375.0) * screenWidth,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.08),
                      SizedBox(height: (20.0 / 812.0) * screenHeight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t have an account? ",
                            style: TextStyle(fontSize:  (16.0/375.0)*screenWidth),
                          ),
                          GestureDetector(
                            onTap: ()=>Get.to(()=>SignUpScreen()),
                            // onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize:  (16.0/375.0)*screenWidth,
                                  color: kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: (20.0 / 812.0) * screenHeight),
                      FlatButton(
                        child: Text(
                          'I am an Admin?',
                          style: TextStyle(decoration: TextDecoration.underline),
                        ),
                        onPressed: () {
                          AdminSigninSheet(context,id.text,password.text,AuthCubit.get(context).adminLogin(id.text, password.text, context));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ));
    }, listener: (context,state){});
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
