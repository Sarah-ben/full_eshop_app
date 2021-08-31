import 'dart:ui';
import 'package:full_eshop_app/Authentification/authentification.dart';
import 'package:full_eshop_app/newscreen/home/search.dart';
import 'package:full_eshop_app/newscreen/info/profile.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:favorite_button/favorite_button.dart';
import 'CollectionList.dart';
import 'details.dart';
import 'package:full_eshop_app/config.dart';

import 'model.dart';
class ProductsPage extends StatefulWidget {

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>
    with SingleTickerProviderStateMixin {
 TextEditingController _controller = TextEditingController();
  List<NetworkImage> listOfImages = <NetworkImage>[];
  @override
  Widget build(BuildContext context) {
    var imageWidth = (MediaQuery.of(context).size.width / 2) - 20;
    var screenWidth = MediaQuery.of(context).size.width;

    return Material(
        child: Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: screenWidth,
        //padding: EdgeInsets.only( left:1.0,right: 1.0),

        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Container(
                margin: EdgeInsets.only(left: 20.0),
                child:Column(
                  children: [
                    Text(
                      'Djalal Life Style',
                      style: TextStyle(
                        fontFamily: 'Signatra',
                        color: Colors.black,
                        fontSize: 25.0
                      ),
                    ),
                    Container(
                     // margin:EdgeInsets.only(left:20.0),
                      child: Text(
                        'Women clothes store',
                        style: TextStyle(
                          fontFamily: 'Signatra',
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                )
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.08,
              backgroundColor: Colors.white,
            //  pinned: true,
             // floating: true,
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.search,
                        size: 25,
                        color: Colors.black,
                      ),
                      onPressed: () {
                          Get.to(()=>SearchScreen(), transition: Transition.leftToRight);
                      }),
                ),
                Container(
                  padding: EdgeInsets.only(right: 5.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        size: MediaQuery.of(context).size.width/15.0,color: Colors.black,
                      ),
                      onPressed: () {
                        Get.to(()=>Profile(), transition: Transition.leftToRight);

                      }
                    //   Navigator.pushNamed(context, ProfileScreen.routeName),
                  ),
                ),
              ],
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(.35),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                ),
              ),
            ),

            SliverPersistentHeader(
                pinned: false, floating: true, delegate: CollectionList()),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Products')
                  .orderBy("Publish_date", descending: true)
                  .snapshots(),
              builder: (BuildContext context, snapshot) {

                if (snapshot.data == null) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else
                  return SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 2,
                      //crossAxisSpacing: 2,
                      // mainAxisSpacing: 2,
                      staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        ItemModel model = ItemModel.fromJson(
                            snapshot.data.docs[index].data());
                        return GetBuilder<sourceInfos>(
                          init: sourceInfos(),
                          builder: (c) {
                            return c.sourceInfo(model, context);
                          },
                        );
                      },
                      itemCount: snapshot.data.docs.length);
                //snapshot.connectionState==ConnectionState.waiting? Container(child: Center(child: CircularProgressIndicator(),),)
                //:
              },
            ),
          ],
        ),
      ),
    ));
  }
}


class sourceInfos extends GetxController {
  Auth auth = Get.put(Auth());
  QuerySnapshot snapshots;

  Widget sourceInfo(ItemModel model, BuildContext context) {

    var p = 100 - ((model.prix_apres_promotion * 100) / model.prix_originale);
    return InkWell(
      onTap: () =>
          Get.to(()=>ProductDetails(model: model), transition: Transition.leftToRight),
      child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
          //  padding: EdgeInsets.only( left:1.0,right: 1.0),
          width: MediaQuery.of(context).size.width,
          //m height: 246,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //margin: EdgeInsets.only(right: 3),
                  width: (MediaQuery.of(context).size.width / 2) - 10,
                  height: (MediaQuery.of(context).size.width / 2) - 70,
                  child: Stack(
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width / 2) - 10,
                        height: (MediaQuery.of(context).size.width / 2) - 30,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF343434).withOpacity(0.4),
                                Color(0xFF343434).withOpacity(0.15),
                              ],
                            ),
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: //AssetImage('assets/images/pizza.jpg')
                                  NetworkImage(model.urls[0])),
                        ),
                      ),
                      Positioned(right: 5.0,
                      //bottom: 1.0,
                      child:  Card(
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0)),
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
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          height: MediaQuery.of(context).size.width * .065,
                          width: MediaQuery.of(context).size.width * .065,
                          //margin: EdgeInsets.only(right: 6.0, top: 5.0),
                          //  decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.circular(9)),
                          child:  FavoriteButton(
                            iconSize: 25,
                            isFavorite:config.sharedPreferences.getStringList(config.userWishList)==null?false:
                            config.sharedPreferences.getStringList(config.userWishList).contains(model.Publish_date)?true:
                            false,

                            valueChanged: (v) {
                              v == true
                                  ? auth.addToFav(model)
                                  : auth.removeFromFav(model);
                            },
                          ),

                          //favBtn(model,30.0)
                        ),
                      ),),



                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 4),
                    //   height: 82,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(
                                '${model.prix_originale} DA',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),



                              //favBtn(model,30.0)


                          ],
                        ),
                        Container(
                          //height:36,
                          width: MediaQuery.of(context).size.width -
                              (((MediaQuery.of(context).size.width / 2) - 20) +
                                  23),
                          margin: EdgeInsets.only(bottom: 10.0, top: 4),
                          child: Text(
                                '${model.name}',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                        ),
                      ],
                    )),
            if(p>=5)    Padding(
                    padding: EdgeInsets.only(left: 3,top:3,bottom: 7
                    ),
                    child: Container(
                        margin: EdgeInsets.only(bottom: 3.0),
                        padding: EdgeInsets.only(
                            left: 4.0,
                            right: 4.0,
                            top: 3.0,
                            bottom: 3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.red,
                        ),
                        child: Text(
                          '${p.toInt()} % Off',
                          style: TextStyle(
                              color: Colors.white, fontSize: 10.0),
                        ))),
              ],
            ),
          )
      ),
    );
  }

 /* FavPage(BuildContext context) {
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
                Get.to(HomeScreen(), transition: Transition.leftToRight);
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
                  whereIn: config.sharedPreferences.getStringList('userCart'))
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
*/
 /* favBtn(model, size) {
    return FavoriteButton(
      iconSize: size,
      isFavorite: config.sharedPreferences
              .getStringList('userWishList')
              .contains(model.Publish_date)
          ? true
          : false,
      valueChanged: (v) {
        v == true ? auth.addToFav(model) : auth.removeFromFav(model);
      },
    );
  }
*/
  /*favBtn2(model) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.red.withOpacity(.3)
      ),
      child: FavoriteButton(
          iconSize: 40.0,
          isFavorite: config.sharedPreferences
                  .getStringList('userWishList')
                  .contains(model.url1)
              ? true
              : false,
          valueChanged: (v) {
            if (v == true) {
              if (config.sharedPreferences
                  .getStringList('userWishList')
                  .contains(model.Publish_date)) {
                Get.snackbar("Notification",
                    " Product already exists ! check your wishlist");

                // Toast.show('already exists', context);
              } else {
                List cartList =
                    config.sharedPreferences.getStringList('userWishList');
                cartList.add(model.url1);
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(config.sharedPreferences.getString('uid'))
                    .update({'userWishList': cartList}).then((value) {
                  config.sharedPreferences
                      .setStringList('userWishList', cartList);
                  // Toast.show('Added', context);
                });
              }
            } else {
              List list = config.sharedPreferences.getStringList('userWishList');
              list.remove(model.Publish_date);
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(config.sharedPreferences.getString('uid'))
                  .update({'userWishList': list}).then((value) {
                config.sharedPreferences.setStringList('userWishList', list);

                //Toast.show('Removed', context);
              });
              update();
            }
          }),
    );
  }
  */
  /*favBtn3(model) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white
      ),
      child:IconButton(icon: Icon(Icons.shopping_cart_rounded,size: 20,), onPressed: (){
        {
          if (config.sharedPreferences
              .getStringList('userCart')
              .contains(model.url1)) {
            Get.snackbar("Notification",
                " Product already exists ! check your Cart");

            // Toast.show('already exists', context);
          } else {
            List cartList =
            config.sharedPreferences.getStringList('userCart');
            cartList.add(model.url1);
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
      }),
    );
  }
  */
}



