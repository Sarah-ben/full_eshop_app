import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../config.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitialAppState());
 static AppCubit get(context)=>BlocProvider.of(context);
  config c=Get.put(config());
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
  addToFav(model) {
    emit(AddLoadingState());
    if (config.sharedPreferences
        .getStringList('userWishList')
        .contains(model.Publish_date)) {
      Get.snackbar(
          "Notification", " Product already exists ! check your wishlist");
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
        emit(AddSuccessState());

        config.sharedPreferences
            .setStringList(
            'userWishList', cartList);
        Get.snackbar("Notification", "Product added to your wishlist");
        // Toast.show('Added', context);
      });
    }
  }
  removeFromFav(model){
    emit(RemoveLoadingState());
    List list = config.sharedPreferences
        .getStringList('userWishList');
    list.remove(model.Publish_date);
    FirebaseFirestore.instance
        .collection('users')
        .doc(config.sharedPreferences
        .getString('uid'))
        .update({'userWishList': list}).then(
            (value) {
              emit(RemoveSuccessState());
              config.sharedPreferences.setStringList(
              'userWishList', list);
          Get.snackbar("Notification", "Product removed from your wishlist");
          //Toast.show('Removed', context);
        });

  }

}