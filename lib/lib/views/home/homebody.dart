import 'dart:ui';
import 'package:eshop_update/shared/components/components.dart';
import 'package:eshop_update/shared/components/constans.dart';
import 'package:eshop_update/shared/cubit/AppCubit/app_cubit.dart';
import 'package:eshop_update/shared/cubit/AppCubit/app_states.dart';
import 'package:eshop_update/views/search/search.dart';
import 'package:eshop_update/views/settings/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:favorite_button/favorite_button.dart';
import 'CollectionList.dart';
import '../details/details.dart';
import 'package:eshop_update/shared/config.dart';

import '../../models/model.dart';
import 'home.dart';
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

    return  BlocConsumer<AppCubit,AppStates>(builder: (context,state){
      AppCubit cubit=AppCubit.get(context);
      return Scaffold(
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
                          Get.to(()=>SearchScreen());
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
                          Get.to(()=>Profile());

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
                        staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          ItemModel model = ItemModel.fromJson(
                              snapshot.data.docs[index].data());
                              return sourceInfo(model, context,cubit.addToFav(model),cubit.removeFromFav(model));

                        },
                        itemCount: snapshot.data.docs.length);
                  //snapshot.connectionState==ConnectionState.waiting? Container(child: Center(child: CircularProgressIndicator(),),)
                  //:
                },
              ),
            ],
          ),
        ),
      );
    }, listener: (context,state){});
  }
}




