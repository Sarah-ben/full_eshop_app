import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:full_eshop_app/Authentification/authentification.dart';
import 'package:full_eshop_app/Custom-components/customSurfix.dart';
import 'package:full_eshop_app/Custom-components/defaultButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

import '../../config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  final _formKey = GlobalKey<FormState>();
    Auth auth=Get.put(Auth());
    config c=Get.put(config());

  @override
  Widget build(BuildContext context) {
    var screenHeight=MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildnameFormField(),
          SizedBox(height: (30.0/812.0)*screenHeight),
          buildEmailFormField(),
          SizedBox(height: (30.0/812.0)*screenHeight),
          buildPasswordFormField(),
          SizedBox(height:(30.0/812.0)*screenHeight),
         // FormError(errors: errors),
          SizedBox(height: (40.0/812.0)*screenHeight),
          DefaultButton(
            text: "Continue",
            press: () {
              if(_connectionStatus=='${ConnectivityResult.mobile}'&&_connectionStatus=='${ConnectivityResult.mobile}'){
                if (_formKey.currentState.validate()) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return c.reload();
                      });
             auth.signupWithEmail(email.text, password.text, name.text,context);
    }
              }
              else
              {
                Toast.show('     you are offline\n  فشل الاتصال بالانترنت', context);
              }
              c.reload();
              // if all are valid then go to success screen
            //    Navigator.pushNamed(context, CompleteProfileScreen.routeName);

            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: password,
      obscureText: true,
      validator: (value) {
        if (value.isEmpty) {
          return "Password is empty !";
        } else if (value.length < 8) {
          return "Password length must be > 8";
        }
        return null;
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
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return "Email is empty !";
        } else
        return null;
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
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
  TextFormField buildnameFormField() {
    return TextFormField(
      controller: name,
      keyboardType: TextInputType.emailAddress,

      validator: (value) {
        if (value.isEmpty) {
          return "Username is empty !";
        }
        return null;
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
        labelText: "Username",
        hintText: "Enter a Username",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}