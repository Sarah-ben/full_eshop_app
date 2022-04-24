import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fialogs/fialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../details/details.dart';
import '../../models/model.dart';
class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller=TextEditingController();
  QuerySnapshot querySnapshot;
  bool isExecuted=false;
  Widget SearchProducts(){
    return Container(
      margin: EdgeInsets.only(top:10.0,left:10.0),
      child: ListView.builder(
        itemCount: querySnapshot.docs.length,
        itemBuilder: (BuildContext context,index){
          ItemModel model=ItemModel.fromJson(querySnapshot.docs[index].data());
          return GestureDetector(
            onTap: (){
              Get.to(
                ProductDetails(model: model,),
               );
            },
            child: ListTile(
              leading:
              Container(
                width:MediaQuery.of(context).size.width*.15,
                height:MediaQuery.of(context).size.width*.15,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image:NetworkImage(model.urls[0]),
                    )
                ),
              ),
              title: Text(model.name,style: TextStyle(fontWeight: FontWeight.w600),),
              subtitle: Text('Prix: ${model.prix_apres_promotion}'),
            ),
          );
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation: 0,
        automaticallyImplyLeading:false,
        backgroundColor: Colors.white,

        title:Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding:EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(40.0)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width -154,
                  child: TextFormField(
                    controller:_controller ,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Search a product',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                      focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                    ),
                  ),
                ),
                GetBuilder<SearchProd>(
                  init: SearchProd(),
                  builder: (val){
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                         color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: IconButton(icon: Icon(Icons.search,size: 25,color: Colors.white,), onPressed: (){
                       CircularProgressIndicator();
                        val.searchP(_controller.text).then((value) {
                          querySnapshot=value;
                          setState(() {
                            isExecuted=true;
                          });
                        });
                      }),
                    );
                  },
                )
              ],
            ),
          ),
        ) ,),
      body: isExecuted==true?SearchProducts():
      Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Search products'),
              Text('ابحث عن منتوج'),
            ],
          ),
        ),
      ),
    );
  }
}
class SearchProd extends GetxController{
  Future searchP(String querysnap)async{
    return await FirebaseFirestore.instance.collection('Products').where('name',isGreaterThanOrEqualTo: querysnap)
        .get();
  }

}