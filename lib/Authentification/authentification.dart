import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:full_eshop_app/newscreen/home/home.dart';
import 'package:full_eshop_app/newscreen/signup/verification.dart';
import 'package:full_eshop_app/newscreen/splash.dart';
import 'package:fialogs/fialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:full_eshop_app/config.dart';
class Auth extends GetxController{
  Widget signinUuserSheet(BuildContext context,email,passwd){
    var width=MediaQuery
        .of(context)
        .size
        .width;
    var height= MediaQuery
        .of(context)
        .size
        .height;
    return  Positioned(
      top:55,
      left: 10,
      right: 10,
      child: Container(
        // margin: EdgeInsets.only(left: 10,right: 10),
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(5)),
        height: 45,
        width: width,
        child:RaisedButton(
          elevation: 0,
          color: Colors.orange,
          onPressed:()async{
            CreateAccount(email, passwd, context);
          }
          ,child:Text('Sign in',style: TextStyle(color: Colors.white)
          ,),),
      ),);
  }
  Future CreateAccount(email,passwd,context)async{
    User user;
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: passwd).then((value) {
      user=value.user;
    }).catchError((onError){
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
  var pressedBool = true;

  changeStatus() {
    if(pressedBool){
      pressedBool = false;
    }
    else {
      pressedBool = true;
    }
    update();
    var x=pressedBool;
  }

  config c=Get.put(config());
  //SIGN UP
  Future signupWithEmail(String email,String passwd,String name,context)async{
  User user;
  dynamic f=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: passwd).then((value) {
    user=value.user;
  }).catchError((onError){
  c.dialog(context, onError.message,'Error');
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
 // print(config.sharedPreferences.getStringList('userWishList').length -1);

  }
  //SIGN IN
  Future signinWithEmail(String mail,String password,context)async{
    User fuser;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: mail, password: password)
        .then((auth) => fuser = auth.user)
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
        c.dialog(context, onError.message, 'Error');
        print(onError.message);
      }
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
    await FirebaseFirestore.instance.collection('admins').get().then((snap) {
      snap.docs.forEach((element) {
        if(element.data()['ID']!= id) {
          c.dialog(context, 'ID is wrong','Error');

        }
        else if(element.data()['passwd']!=passwd){
          c.dialog(context, 'Password is wrong','Error');
        }
        else{
          print('done');
          //Get.offAll(HomeScreen());
        }
      });
    });
  }
  //Email verifying
//  User user;
 // FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  Future checkMail(BuildContext context,Timer timer, User user)async{
    await user.reload();
    if(user.emailVerified){
      timer.cancel();
      Get.off(()=>HomeScreen());
     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
  }
 //LOG OUT
  Future signOut(BuildContext context)async{
    await FirebaseAuth.instance.signOut().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c){
     return SplashScreen();
    })));
}
  addToFav(model) {
    if (config.sharedPreferences
        .getStringList('userWishList')
        .contains(model.Publish_date)) {
      Get.snackbar(
          "Notification", " Product already exists ! check your wishlist");

      // Toast.show('already exists', context);
    } else {
      List cartList = config.sharedPreferences
          .getStringList('userWishList');
      cartList.add(model.Publish_date);
      FirebaseFirestore.instance
          .collection('users')
          .doc(config.sharedPreferences
          .getString('uid'))
          .update({
        'userWishList': cartList
      }).then((value) {
        config.sharedPreferences
            .setStringList(
            'userWishList', cartList);
        Get.snackbar("Notification", "Product added to your wishlist");
        // Toast.show('Added', context);
      });
    }
  }
  removeFromFav(model){
    List list = config.sharedPreferences
        .getStringList('userWishList');
    list.remove(model.Publish_date);
    FirebaseFirestore.instance
        .collection('users')
        .doc(config.sharedPreferences
        .getString('uid'))
        .update({'userWishList': list}).then(
            (value) {
          config.sharedPreferences.setStringList(
              'userWishList', list);
          Get.snackbar("Notification", "Product removed from your wishlist");

          //Toast.show('Removed', context);
        });
    update();
  }

}
