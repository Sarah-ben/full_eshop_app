import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:full_eshop_app/newscreen/signin/sign_in.dart';
import 'package:fialogs/fialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../config.dart';
import 'CollectionList.dart';
import 'details.dart';
import 'model.dart';

class HomeWithoutAuth extends StatefulWidget {
  @override
  _HomeWithoutAuthState createState() => _HomeWithoutAuthState();
}

class _HomeWithoutAuthState extends State<HomeWithoutAuth>  with SingleTickerProviderStateMixin {
  infosWithoutAuth inf=Get.put(infosWithoutAuth());
  TextEditingController _controller = TextEditingController();
  List<NetworkImage> listOfImages = <NetworkImage>[];
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    return Material(
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width:screenWidth,

            child: CustomScrollView(
              slivers: [
                SliverAppBar(
            automaticallyImplyLeading:false,
                  title:  Container(
                    margin:EdgeInsets.only(left:20.0),
                    child:
                    Text('Djalal Life Style',style: TextStyle( fontFamily: 'Signatra', color: Colors.black87,
                    ),),),

                  expandedHeight: MediaQuery.of(context).size.height * 0.08,
                  backgroundColor: Colors.white,
                  pinned: true,
                  floating: true,
                  actions: [
                    Container(
                      margin:EdgeInsets.only(right:20.0),
                      child: IconButton(
                          icon: Icon(
                            Icons.search,
                            size: 25,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                          }),
                    ),              ],
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      color:Colors.red.withOpacity(.35),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.0),bottomLeft:  Radius.circular(30.0)),

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
                          crossAxisCount: 3,
                          staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                          itemBuilder: (context, index) {
                            ItemModel model =
                            ItemModel.fromJson(snapshot.data.docs[index].data());
                            return GetBuilder<infosWithoutAuth>(
                              init: infosWithoutAuth(),
                              builder: (c) {
                                return inf.sourceInfoWithoutAuth(model, context);
                              },
                            );
                          },
                          itemCount: snapshot.data.docs.length);

                  },
                ),
              ],
            ),
          ),
        ));
  }
}
class infosWithoutAuth extends GetxController{
  config co =Get.put(config());

  Widget sourceInfoWithoutAuth(ItemModel model, BuildContext context) {
    var p=100-((model.prix_apres_promotion*100)/model.prix_originale);
    return
      InkWell(
         onTap: () =>Get.to(ProductDetails(model: model,),transition: Transition.downToUp),
        child:  Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            width: MediaQuery.of(context).size.width,
            child: Card(
              child: Column(
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 10,
                    height: (MediaQuery.of(context).size.width / 2) - 70,
                    child: Stack(
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width / 2) - 10,
                          height: (MediaQuery.of(context).size.width / 2) - 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: //AssetImage('assets/images/pizza.jpg')
                                NetworkImage(model.urls[0])),
                          ),
                        ),


                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5.0 ),
                                child: Text(
                                  '${model.prix_originale} DA',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  height: 20,
                                  width: 35,
                                  margin: EdgeInsets.only(right: 1.0,top: 5.0),
                                  child:IconButton(
                                    icon:Icon (Icons.favorite_outline_sharp),
                                    onPressed:(){
                                      return  errorDialog(
                                        context,
                                        'Error',
                                        'Sign in first',
                                        neutralButtonText: "OK",
                                        neutralButtonAction: () {
                                         Get.to(()=>SignInScreen());
                                        },
                                        negativeButtonText: 'Cancel',
                                        negativeButtonAction: (){
                                          Get.to(()=>HomeWithoutAuth());
                                        },
                                        hideNeutralButton: false,
                                        closeOnBackPress: false,
                                      );
                                    } ,
                                  )

                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width -
                                (((MediaQuery.of(context).size.width / 2) - 20) +
                                    23),
                            margin: EdgeInsets.only(bottom: 10.0,top: 4),
                            child: Text(
                              '${model.name}',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500, fontSize: 15,
                              ),
                            ),
                          ),
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
                      ))
                ],
              ),
            )),
      );

  }

}

