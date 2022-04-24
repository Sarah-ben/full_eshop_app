import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop_update/shared/components/components.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:toast/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

import '../../shared/config.dart';
import 'buildForm.dart';
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
  buildGridViews v=Get.put(buildGridViews());
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
  }  String _error = 'No Error Detected';

}
class buildGridViews extends GetxController{
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
