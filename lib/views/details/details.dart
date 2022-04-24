import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:story_view/story_view.dart';
import 'package:story_view/widgets/story_view.dart';
import '../home/homebody.dart';
import '../../models/model.dart';
import 'package:eshop_update/shared/config.dart';
class ProductDetails extends StatefulWidget {
  // final   QueryDocumentSnapshot queryDocumentSnapshot;

  //ProductDetails({ this.queryDocumentSnapshot}) ;

  final ItemModel model;
  ProductDetails({this.model});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
//  final ItemModel model;
//  ProductDetails(this.model);

//List<NetworkImage> listOfImages;


}

class _ProductDetailsState extends State<ProductDetails> {
  List listOfImages =[];



  // final ItemModel model;
//  List<NetworkImage> listOfImages = <NetworkImage>[];
  int a = 1;
  //_ProductDetailsState(this.model);

//  _ProductDetailsState(this.model, this.listOfImages);
  showl(data) {
    return StoryItem.inlineImage(url: data, caption: null, controller: _controller);
  }
  final StoryController _controller = StoryController();
  final StoryController controller = StoryController();

 // ItemModel model;
  @override
  Widget build(BuildContext context) {
    listOfImages=[];
    for(int i=0;i<widget.model.urls.length;i++){
      listOfImages.add(widget.model.urls[i]);
    }
    List list;
    for (int i=0;i<listOfImages.length;i++){
      list=listOfImages ;
    }
    return Scaffold(
        body:Container(
          padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:Padding(
            padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom ),
            child: Container(
                margin: EdgeInsets.only(left: 1.0,right: 1.0,top:1.0,bottom:1.0),
                height: MediaQuery.of(context).size.height/2,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                child:Stack(
                  children: [
                    StoryView(
                      storyItems: [
                        for(var i in list)showl(i),
                        //StoryItem.pageVideo(url, controller: storyController)
                      ],
                      progressPosition: ProgressPosition.bottom,
                      repeat: false,
                      controller: controller,
                    ),
                   if (FirebaseAuth.instance.currentUser!=null)
                     Positioned(top: 18,right: 16,
                       child:  Card(
                         shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                         child: Container(
                           decoration: BoxDecoration(
                             gradient: LinearGradient(
                               begin: Alignment.topCenter,
                               end: Alignment.bottomCenter,
                               colors: [
                                 Colors.black.withOpacity(0.2),
                                 Colors.white.withOpacity(0.15),
                               ],
                             ),
                             borderRadius: BorderRadius.circular(15.0),
                           ),
                           child: IconButton( icon:Icon(Icons.shopping_cart_rounded), onPressed: (){
                             if (config.sharedPreferences
                                 .getStringList(config.userCart)
                                 .contains(widget.model.Publish_date)) {
                               Get.snackbar("Notification",
                                   " Product already exists ! check your cart");

                               // Toast.show('already exists', context);
                             } else {
                               List cartList =
                               config.sharedPreferences.getStringList(config.userCart);
                               cartList.add(widget.model.Publish_date);
                               FirebaseFirestore.instance
                                   .collection('users')
                                   .doc(config.sharedPreferences.getString('uid'))
                                   .update({'userCart': cartList}).then((value) {
                                 config.sharedPreferences
                                     .setStringList('userCart', cartList);
                                 // Toast.show('Added', context);
                               });
                             }
                           }
                           )                        ,
                         ),
                       ),
                     ),
                    Positioned(
                      bottom:20,
                      left:10,
                      child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.4),
                                Colors.white.withOpacity(0.15),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding: const EdgeInsets.symmetric(horizontal: 150),
                                child:Divider(
                                  thickness: .5,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10,top: 10),
                                child: Text(widget.model.name,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),),
                              ),
                              Container(
                                  padding: const EdgeInsets.only(left: 10,top: 10),
                                  child: Text('Details',style: TextStyle(color: Colors.black54,fontSize: 18.0, fontWeight: FontWeight.bold,),)),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(left: 10,top: 5,right: 5.0),
                                child: Text(widget.model.Details,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 17.0)),
                              ),
                        if (100-(((widget.model.prix_apres_promotion*100)/widget.model.prix_originale)) >5)
                          Container(
                            margin: const EdgeInsets.only(left: 10,top: 25),
                            child:
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.red,
                                  ),
                                  alignment: Alignment.topLeft,
                                  // width: 33.0,
                                  //height: 33.0,
                                  child:Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${(100-(((widget.model.prix_apres_promotion*100)/widget.model.prix_originale))).toInt()} %",style: TextStyle(fontSize: 17.0,color: Colors.white,fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          "off",style: TextStyle(fontSize: 14.0,color: Colors.white,fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child:Row (
                                        children: [
                                          Text(
                                            "prix original:",
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,

                                                decoration: TextDecoration.lineThrough
                                            ),
                                          ),
                                          Text(
                                            '${widget.model.prix_originale}',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration.lineThrough
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child:Row (
                                        children: [
                                          Text(
                                            "nouvelle prix:",
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold,

                                              color: Colors.black,
                                            ),
                                          ),

                                          Text(
                                            '${widget.model.prix_apres_promotion} DA',
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.black,

                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                            ],
                          )
                      ),
                    )
                  ],
                )

            ),
          ),

        )
    );
  }

}
Plusinfo(BuildContext context,String name,String desc,int OldPrice, int NewPrice,marketplace){
  return showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height*.3,
          child:ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 150),
                    child:Divider(
                      thickness: .5,
                      color: Colors.black,
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.only(left: 20,top: 10),
                    child: Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 20,top: 10),
                      child: Text('Details',style: TextStyle(color: Colors.grey,fontSize: 17),)),
                  Container(
                    padding: const EdgeInsets.only(left: 20,top: 5),
                    child: Text(desc,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20,top: 25),
                    child:
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),

                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.red,
                          ),
                          alignment: Alignment.topLeft,
                          // width: 33.0,
                          //height: 33.0,
                          child:Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(

                                  "${((NewPrice*100)/OldPrice).toInt()} %",style: TextStyle(fontSize: 15.0,color: Colors.white,fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "off",style: TextStyle(fontSize: 12.0,color: Colors.white,fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 0.0),
                              child:Row (
                                children: [
                                  Text(
                                    "prix original:",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        decoration: TextDecoration.lineThrough
                                    ),
                                  ),
                                  Text(
                                    '$OldPrice',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        decoration: TextDecoration.lineThrough
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child:Row (
                                children: [
                                  Text(
                                    "nouvelle prix:",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,
                                    ),
                                  ),

                                  Text(
                                    '$NewPrice DA',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.black,

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.only(left: 20,top: 20),
                    child:
                    Text(
                        '${marketplace} ',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15)),

                  ),
                ],
              )
            ],
          ),
        );
      }
  );
}


