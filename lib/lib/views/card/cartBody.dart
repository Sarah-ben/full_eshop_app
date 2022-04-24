import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop_update/shared/components/constans.dart';
import 'package:eshop_update/shared/components/constans.dart';
import 'package:eshop_update/shared/components/constans.dart';
import 'package:eshop_update/shared/styles/colors.dart';
import 'package:eshop_update/views/home/home.dart';
import 'package:eshop_update/models/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eshop_update/shared/config.dart';
import 'cart.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FavPage s=Get.put(FavPage());
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: (12.0 / 375.0) * screenWidth),
      child:s.FvPage(context)
    );
  }
}
class FavPage extends GetxController{
   FvPage(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_outlined,
             color: Colors.black,
              ),
              onPressed: () {
                Get.to(()=>HomeScreen(), transition: Transition.leftToRight);
              }),
          backgroundColor: Colors.white,
          title: Text('Cart ',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  )),
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Products')
              .where('Publish_date',
                  whereIn: config.sharedPreferences.getStringList(config.userCart))
              .snapshots(),
          builder: (BuildContext context, snap) {
            return snap.connectionState == ConnectionState.waiting
                ? SliverToBoxAdapter(
                    child: Center(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                      ),
                    ),
                  ))
                : !snap.hasData
                    ? Center(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                          ),
                        ),
                      )
                    : snap.data.docs.length == 0
                        ? SliverToBoxAdapter(
                            child: Card(
                              elevation: 0,
                              //  color: Colors.white,
                              child: Container(
                                height: 100.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.insert_emoticon,
                                      color: kPrimaryColor,
                                    ),
                                    Column(
                                      children: [
                                        Text("My cart is empty "),
                                        Text("قائمة مشترياتي فارغة"),
                                      ],
                                    )                                    //Text("Ajoute des produits"),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate((cntx, i) {
                            ItemModel model =
                                ItemModel.fromJson(snap.data.docs[i].data());
                            return Container(
                              margin: EdgeInsets.only(top: 5.0),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .28,
                                    height:
                                        MediaQuery.of(context).size.width * .28,
                                    padding:
                                        EdgeInsets.only(top: 9.0, right: 9.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF5F6F9),
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image:NetworkImage( model.urls[0]),
                                        fit: BoxFit.fill,
                                      ),
                                    ),

                                  ),
                                  SizedBox(width: 20),
                                  Container(
                                      width: MediaQuery.of(context).size.width -
                                          (MediaQuery.of(context).size.width *
                                              .3) -
                                          46.0,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              .28,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 10.0,
                                            child: Text(
                                              model.name,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,

                                                  fontSize: MediaQuery.of(context).size.width*.05),
                                              maxLines: 2,
                                            ),
                                          ),
                                          //SizedBox(height: 10),
                                          Positioned(
                                            bottom: 5.0,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .3) -
                                                  24.0,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text.rich(
                                                    TextSpan(
                                                      text:
                                                          "${model.prix_apres_promotion} DA",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: kPrimaryColor),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                " x${model.prix_originale}",
                                                            //style: Theme.of(context).textTheme.bodyText1,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough)),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0.0),
                                                    child: FlatButton(
                                                      child: Icon(Icons.delete),
                                                      onPressed: () {
                                                        List list = config
                                                            .sharedPreferences
                                                            .getStringList(
                                                                'userCart');
                                                        list.remove(model.Publish_date);
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .doc(config
                                                                .sharedPreferences
                                                                .getString(
                                                                    'uid'))
                                                            .update({
                                                          'userCart': list
                                                        }).then((value) {
                                                          config
                                                              .sharedPreferences
                                                              .setStringList(
                                                                  'userCart',
                                                                  list);
                                                         Navigator.push(context, MaterialPageRoute(builder: (c)=>CartScreen()));
                                                        });
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            );
                          },
                                childCount:
                                    snap.hasData ? snap.data.docs.length : 0));
          },
        )
      ],
    );
  }

}