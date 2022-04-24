import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop_update/shared/components/components.dart';
import 'package:eshop_update/shared/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'addProducts.dart';

class infos extends StatefulWidget {
  @override
  _infosState createState() => _infosState();
}

class _infosState extends State<infos> {
  buildGridViews v=Get.put(buildGridViews());
  TextEditingController _name=TextEditingController();
  TextEditingController _origpice=TextEditingController();
  TextEditingController _promotion=TextEditingController();
  TextEditingController _description=TextEditingController();
  DocumentSnapshot documentSnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
          decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.only(top:2 ),
          width:MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height-(199),
          child:
          ListView(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width:MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-(199),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                        maxLines:1 ,
                        validator: (v) {
                          if (v == '') {
                            return 'This is Empty';
                          } else
                            return null;
                        },
                        controller: _name,
                        decoration: InputDecoration(
                          hintText: 'Nom de produit',)

                    ),
                    TextFormField(
                      maxLines:1 ,
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'This is Empty';
                        } else
                          return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: _origpice,
                      decoration: InputDecoration(
                        hintText: 'Prix originale',
                      ),
                    ),
                    TextFormField(
                      maxLines:1 ,
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'This is Empty';
                        } else
                          return null;
                      },
                      controller: _promotion,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Promotion',

                      ),
                    ),
                    TextFormField(
                      //   maxLines: 5,
                      validator: (v) {
                        if (v == '') {
                          return 'This is Empty';
                        } else
                          return null;
                      },
                      controller: _description,
                      decoration: InputDecoration(
                        hintText: 'Description/Details (Optional)',

                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child:Text('Choisez la Collection et le Magasin',style: TextStyle(fontSize: 10),),
                    ),

                    Container(

                      // margin: EdgeInsets.only(left: 20,right: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: RaisedButton(

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed:() async {
                          reload();
                          if(v.images.length==0){
                            showDialog(context: context,builder: (_){
                              return AlertDialog(
                                backgroundColor: Theme.of(context).backgroundColor,
                                content: Text("No image selected",style: TextStyle(color: Colors.white)),
                                actions: <Widget>[
                                  InkWell(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 80,
                                      height: 30,
                                      // backgroundColor: MultiPickerApp.navigateButton,
                                      // backgroundDarkerColor: MultiPickerApp.background,
                                      child: Center(child: Text("Ok",style: TextStyle(color: Colors.white),)),
                                    ),
                                  )
                                ],
                              );
                            });
                          }
                          else{
                            showDialog(context: context,builder: (context){
                              return SimpleDialog(
                                children: [
                                  Text('يتم االنشر ،انتظر قليلا من فضلك')
                                ],
                              );
                            });
                            uploadImages(_name.text,int.parse(_origpice.text) , int.parse(_promotion.text), _description.text,context);

                          }
                        },
                        color: Colors.deepOrange,
                        child: Text(
                          'Publish',
                          style: TextStyle(
                              color: Colors.white, fontSize: 15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )

      ),
    );
  }
  config c=Get.put(config());
  void uploadImages(String name,int prix_originale,int prix_apres_promotion,String Details,context){
    for ( var imageFile in v.images) {
      v.postImage(imageFile).then((downloadUrl) {
        v. imageUrls.add(downloadUrl.toString());
        if(v.imageUrls.length==v.images.length){
          //String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          FirebaseFirestore.instance.collection('Products').doc().set({
            'urls':v.imageUrls,
            'name':name,
            'url1':v.imageUrls[0],
            'Publish_date':DateTime.now().microsecondsSinceEpoch.toString(),
            'prix_originale':prix_originale,
            'prix_apres_promotion':prix_apres_promotion,
            'Details':Details,
          }).then((_){
            dialog(context, 'تم النشر', 'Info');
            _name.clear();
            _origpice.clear();
            _promotion.clear();
            _description.clear();
            //  Toast.show('تم النشر', context);
            setState(() {
              v.images = [];
              v. imageUrls = [];
            });
          });
        }
      }).catchError((err) {
        print(err);
      });
    }

  }

}
