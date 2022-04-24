import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop_update/shared/components/constans.dart';
import 'package:eshop_update/shared/styles/colors.dart';
import 'package:eshop_update/views/home/home.dart';
import 'package:eshop_update/views/home/homebody.dart';
import 'package:eshop_update/models/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'favorite.dart';
import 'package:eshop_update/shared/config.dart';
class FavBody extends StatefulWidget {
  @override
  _FavBodyState createState() => _FavBodyState();
}

class _FavBodyState extends State<FavBody> {
  FavGallery favGallery = Get.put(FavGallery());
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.0),
          child: favGallery.FavG()),
    );
  }
}

class FavGallery extends GetxController {
  Widget FavG() {
    return CustomScrollView(slivers: [
      SliverAppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Get.to(() => HomeScreen());
            }),
        backgroundColor: Colors.white,
        title: Text('Wish List',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
      ),
      StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Products')
              .where('Publish_date',
                  whereIn: config.sharedPreferences.getStringList(config.userWishList)).snapshots(),
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
                                        Text("Wish list is empty "),
                                        Text("قائمة مفضلاتي فارغة"),
                                      ],
                                    )
                                    //Text("Ajoute des produits"),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SliverStaggeredGrid.countBuilder(
                            crossAxisCount: 1,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 3,
                            staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                            itemBuilder: (context, index) {
                              ItemModel model = ItemModel.fromJson(
                                  snap.data.docs[index].data());
                              return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    elevation: 0.0,
                                    // color: Colors.red.withOpacity(.1),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .25,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .25,
                                                padding: EdgeInsets.all(9.0),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF5F6F9),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        model.urls[0]),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              Column(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .25,
                                                    width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width -
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .25) -
                                                        126.0,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          top: 10.0,
                                                          child: Text(
                                                            model.name,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .05,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                        //SizedBox(height: 10),
                                                        Positioned(
                                                          bottom: 10.0,
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .3) -
                                                                46.0,
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
                                                                            FontWeight
                                                                                .w600,
                                                                        color:
                                                                            kPrimaryColor),
                                                                    children: [
                                                                      TextSpan(
                                                                          text:
                                                                              " x${model.prix_originale}",
                                                                          //style: Theme.of(context).textTheme.bodyText1,
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              decoration: TextDecoration.lineThrough)),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                  child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0.0),
                                                child: FlatButton(
                                                  child: Icon(
                                                    Icons.favorite_outlined,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    List list = config
                                                        .sharedPreferences
                                                        .getStringList(
                                                            'userWishList');
                                                    list.remove(
                                                        model.Publish_date);
                                                    FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(config
                                                            .sharedPreferences
                                                            .getString('uid'))
                                                        .update({
                                                      'userWishList': list
                                                    }).then((value) {
                                                      config.sharedPreferences
                                                          .setStringList(
                                                              'userWishList',
                                                              list);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (c) =>
                                                                  FavScreen()));
                                                    });
                                                  },
                                                ),
                                              ))

                                            ],
                                          ),
                                          Divider(
                                            thickness: 1,
                                            color: Colors.black.withOpacity(.1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );



                            },
                            itemCount: snap.data.docs.length);
          })
    ]);
  }
}
