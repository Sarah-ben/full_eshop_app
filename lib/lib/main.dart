
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'shared/config.dart';
import 'views/welcomeScreen/splash.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  config.sharedPreferences=await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  User user=FirebaseAuth.instance.currentUser;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (BuildContext context)=>AppCubit()),
    ],
      child: BlocConsumer<AppCubit,AppStates>(
        builder: (context,state){
          return   GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: user!=null?HomeScreen():SplashScreen(),
          );
        },
        listener: (context,state){},
      ),);

  }
}