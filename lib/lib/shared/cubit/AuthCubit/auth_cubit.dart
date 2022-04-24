import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop_update/shared/components/components.dart';
import 'package:eshop_update/views/home/home.dart';
import 'package:eshop_update/views/signup/verification.dart';
import 'package:eshop_update/views/welcomeScreen/splash.dart';
import 'package:fialogs/fialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../config.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit() : super(InitialAppState());
  static AuthCubit get(context)=>BlocProvider.of(context);

  var pressedBool = true;
  changeStatus() {
    if(pressedBool){
      pressedBool = false;
    }
    else {
      pressedBool = true;
    }
    emit(changePasswordVisibility());
  }
  Future createAccount(email,passwd,context)async{
    User user;
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: passwd).then((value) {
      emit(createSuccessState());
      user=value.user;
    }).catchError((onError){
      emit(createErrorState());
      if(onError is PlatformException)
      {
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
            email.clear();
          },
          hideNeutralButton: false,
          closeOnBackPress: false,
        );
      }
    });
    if(user!=null){
      readData(user).then((v){
        Get.to(()=>HomeScreen());
      });
    }
  }

  config c=Get.put(config());
  //SIGN UP
  Future signupWithEmail(String email,String passwd,String name,context)async{
    emit(RegisterLoadingState());

    User user;
    dynamic f=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: passwd).then((value) {
      emit(RegisterSuccessState());
      user=value.user;
    }).catchError((onError){
      emit(RegisterErrorState(onError));

      dialog(context, onError.message,'Error');
    });
    if(user!=null){
      saveInfoToCloud(user,name).then((value) =>Get.off(()=>Verify()));
    }
    return f;
  }
  Future saveInfoToCloud(User user,String name)async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'username':name,
      'userUid':user.uid,
      'userEmail':user.email,
      config.userWishList:['garbageValue'],
      config.userCart:['garbageValue']
    });
    await config.sharedPreferences.setString("uid", user.uid);
    await config.sharedPreferences.setString("email", user.email);
    await config.sharedPreferences.setString("name", name);
    await config.sharedPreferences.setStringList(config.userWishList, ['garbageValue']);
    await config.sharedPreferences.setStringList(config.userCart, ['garbageValue']);
  }
  //SIGN IN
  Future signinWithEmail(String mail,String password,context)async{
    emit(LoginLoadingState());
    User fuser;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: mail, password: password)
        .then((auth) {
      fuser = auth.user;
      emit(LoginSuccessState());
    })
        .catchError((onError) {
      if (onError is PlatformException) {
        return errorDialog(
          context,
          "Error",
          "orror ",
          // positiveButtonText: "OK",
          // positiveButtonAction: () {},
          // negativeButtonText: "OK",
          // negativeButtonAction: () {},
          neutralButtonText: "OK",
          neutralButtonAction: () {
            Navigator.pop(context);
          },
          hideNeutralButton: false,
          closeOnBackPress: false,
        );
      }
      else {
        dialog(context, onError.message, 'Error');
        print(onError.message);
      }
      emit(LoginErrorState(onError));

    }
    );

    if (fuser != null) {
      readData(fuser).then((value) =>
          Get.off(() => HomeScreen()));
      print(fuser.uid);
    }
  }
  //saved messages
  Future readData(User user) async {
    FirebaseFirestore.instance.collection('users').doc(user.uid).get().then((
        snap) async {
      await config.sharedPreferences.setString("uid", snap.data()['userUid']);
      await config.sharedPreferences.setString("email", snap.data()['userEmail']);
      await config.sharedPreferences.setString("name", snap.data()['username']);
      List<String> userWishList=snap.data()[config.userWishList].cast<String>();
      List<String> userCart=snap.data()[config.userCart].cast<String>();
      await config.sharedPreferences.setStringList(config.userWishList, userWishList);
      await config.sharedPreferences.setStringList(config.userCart,userCart);
      // await config.sharedPreferences.setInt('quantity', snapshot.data()['quantity']);
    });
  }
  //ADMIN SIGN IN
  Future <void>adminLogin(String id,String passwd,context)async{
    emit(AdminLoadingState());
    await FirebaseFirestore.instance.collection('admins').get().then((snap) {
      snap.docs.forEach((element) {
        if(element.data()['ID']!= id) {
          dialog(context, 'ID is wrong','Error');

        }
        else if(element.data()['passwd']!=passwd){
          dialog(context, 'Password is wrong','Error');
        }
        else{
          print('done');
          //Get.offAll(HomeScreen());
        }
        emit(AdminSuccessState());
      });
    });
  }
  //Email verifying
//  User user;
  // FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  Future checkMail(BuildContext context,Timer timer, User user)async{
    emit(emailVerificationState());
    await user.reload();
    if(user.emailVerified){
      timer.cancel();
      Get.off(()=>HomeScreen());
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
  }
  //LOG OUT
  Future signOut(BuildContext context)async{

  }
  
} 