import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:toast/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

import '../../config.dart';
class AddProducts extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;

  const AddProducts({Key key, this.globalKey}) : super(key: key);

  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {

  //CHOOSE IMAGE FROM GALLERU
  /* void selectImageFromGallery(File file)async{
    await ImagePicker.pickImage(source:ImageSource.gallery).then((image){
      file=image;
    });
  }

//CHOOSE IMAGE FROM CAMERA
  void selectImageFromCamera(File file)async{
    await  ImagePicker.pickImage(source:ImageSource.camera).then((image){
      file=image;
    });
  }*/
  config c=Get.put(config());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:
            ListView(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: loadAssets,
                      child:Container(
                        width: 130,
                        height: 50,
                        //backgroundColor: MultiPickerApp.navigateButton,
                        //backgroundDarkerColor: MultiPickerApp.background,
                        child: Center(child: Icon(Icons.add,size:50)),
                      ),
                    ),
                    SizedBox(height: 4,),
                    Container(
                      height:MediaQuery.of(context).size.height ,
                      child: v.buildGridView(),
                    ),

                  ],
                ),
              ],
            )

        ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Get.to(()=>infos());
      }, label: Text('Next ')),
    );
  }
  x v=Get.put(x());
  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: v.images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      v.images = resultList;
      _error = error;
    });
  }  String _error = 'No Error Dectected';

}
class x extends GetxController{
  File file ;
  String ImageUrl;
  List<String> imageUrls = <String>[];

  List<Asset> images = List<Asset>();
  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    TaskSnapshot storageTaskSnapshot = await uploadTask;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }
  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

}
class infos extends StatefulWidget {
  @override
  _infosState createState() => _infosState();
}

class _infosState extends State<infos> {
  x v=Get.put(x());
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
                          c.reload();
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
            c.dialog(context, 'تم النشر', 'Info');
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
