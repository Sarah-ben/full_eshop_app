
import 'package:favorite_button/favorite_button.dart';
import 'package:fialogs/fialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:url_launcher/url_launcher.dart';

 navigateTo(context,screen)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>screen));

Widget defaultButton(
    context,
{
  String text,
  press
}
    )=>SizedBox(
  width: double.infinity,
  height: (56.0/812.0)*getHeight(context),
  child: FlatButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    color: kPrimaryColor,
    onPressed: press,
    child: Text(
      text,
      style: TextStyle(
        fontSize:  (18.0/375.0)*getWidth(context),
        color: Colors.white,
      ),
    ),
  ),
);

Widget customTextField({  controller,String label,String hint,String asset})=>TextFormField(
  controller: controller,
  obscureText: true,
  validator: (String v){
    if(v.isEmpty){
      return "This field is empty";
    }
  },
  decoration: InputDecoration(
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: Colors.black)
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: Colors.black)
    ) ,
    labelText: label,
    hintText: hint,
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    floatingLabelBehavior: FloatingLabelBehavior.always,
  ),
);

dialog(BuildContext context,String message,String type){
  return  errorDialog(
    context,
    type,
    message,
    neutralButtonText: "OK",
    neutralButtonAction: () {
      Navigator.pop(context);
    },
    hideNeutralButton: false,
    closeOnBackPress: false,
  );
}
Widget reload(){
  return Material(
    type: MaterialType.transparency,
    child: new Center(
      child: new SizedBox(
        width: 100.0,
        height: 100.0,
        child: new Container(
          decoration: ShapeDecoration(
            color: Color(0xffffffff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.black),),
            ],
          ),
        ),
      ),
    ),
  );
}
Widget sourceInfo(ItemModel model, BuildContext context,Function addToFav,Function removeFromFav) {
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
                                  ? addToFav(model)
                                  : removeFromFav(model);
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
aboutUs(BuildContext context) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          width:MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset('assets/images/loc.png')
                    ),

                    Container(
                        width:MediaQuery.of(context).size.width,
                        child:Row(
                          children: [
                            Container(
                                width:MediaQuery.of(context).size.width,
                                padding :EdgeInsets.all(20.0),
                                child: RichText(text: TextSpan(
                                    text: 'Djalal Lifestyle ',
                                    style: TextStyle(fontSize: 20.0,color: Colors.red,fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: ',boutique de luxe située au 4 ème étage du centre commercial RITEDJMALL à Constantine, spécialisée dans la vente de vêtements pour femmes: chez nous quelque soit votre style, vous trouverez l’article qui vous correspond',style:TextStyle(fontSize: MediaQuery.of(context).size.width*.05,color:Colors.black,fontWeight: FontWeight.w400))
                                    ]
                                ))

                            )
                          ],
                        )
                    ),
                    Container(
                      padding:EdgeInsets.only(left:20.0),
                      child: Row(
                        children: [
                          Icon(Icons.info),
                          SizedBox(width: 20.0,),
                          Text('Boutique/magazin',
                              style:TextStyle(fontSize: MediaQuery.of(context).size.width*.05,color:Colors.black,fontWeight: FontWeight.w400))
                        ],
                      ),
                    ),

                    Container(
                      padding:EdgeInsets.only(left:20.0),
                      child: Row(
                        children: [
                          Icon(Icons.phone,color: Colors.blue,),
                          SizedBox(width: 5.0,),
                          FlatButton(
                              onPressed: () => launch("tel://0777 90 59 82"),
                              child: new Text("0777 90 59 82     Call",style:TextStyle(fontSize: MediaQuery.of(context).size.width*.05,color:Colors.black,fontWeight: FontWeight.w400))),
                        ],
                      ),
                    ),
                    Container(
                        padding:EdgeInsets.only(left:20.0),
                        child: Row(
                          children: [
                            Icon(Icons.email,color: Colors.red,),
                            SizedBox(width: 5.0,),
                            FlatButton(
                                onPressed: ()async {var urls = params.toString();
                                if (await canLaunch(urls)) {
                                  await launch(urls);
                                } else {
                                  throw 'Could not launch $urls';
                                }
                                },
                                child: new Text("djalaldjalalrabah@gmail.com",style:TextStyle(fontSize:MediaQuery.of(context).size.width*.05,color:Colors.black,fontWeight: FontWeight.w400))),
                          ],
                        )
                    ),
                    Container(
                        padding:EdgeInsets.only(left:20.0),
                        child: Row(
                            children: [
                              Container(
                                width: 25.0,
                                height:25.0 ,
                                child: Image.asset('assets/images/fb.jpg'),

                              ),
                              SizedBox(width: 10.0,),

                              InkWell(
                                onTap: ()async{
                                  var urll = 'https://www.facebook.com/Djalal.Lifestyle';
                                  if (await canLaunch(urll)) {
                                    await launch(urll);
                                  } else {
                                    throw 'Could not launch $urll';
                                  }
                                },
                                child: Text('/Djalal.Lifestyle',style:TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.w500)),
                              )
                            ])


                    ),

                  ],
                ),
              ),
            ],
          ),
        );
      });
}
ReportWidget(BuildContext context){
  return showModalBottomSheet(context: context, builder: (context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(' Contact us /تواصل معنا ',style:TextStyle(fontSize: 17.0,color:Colors.black,fontWeight: FontWeight.bold)),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding:EdgeInsets.only(left:20.0),
                  child: Row(
                    children: [
                      Icon(Icons.phone,color: Colors.blue,),
                      SizedBox(width: 10.0,),
                      FlatButton(
                          onPressed: () => launch("tel://0540996396"),
                          child: new Text("Phone",style:TextStyle(fontSize: 17.0,color:Colors.black,fontWeight: FontWeight.w400))),
                    ],
                  ),
                ),
                Container(
                    padding:EdgeInsets.only(left:20.0),
                    child: Row(
                      children: [
                        Icon(Icons.email,color: Colors.red,),
                        SizedBox(width: 10.0,),
                        FlatButton(
                            onPressed: ()async {var urlh = param.toString();
                            if (await canLaunch(urlh)) {
                              await launch(urlh);
                            }
                            else {
                              throw 'Could not launch $urlh';
                            }
                            },
                            child: new Text("Gmail",style:TextStyle(fontSize: 17.0,color:Colors.black,fontWeight: FontWeight.w400))),
                      ],
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  });
}
final Uri params = Uri(
  scheme: 'mailto',
  path: 'djalaldjalalrabah@gmail.com',
  query: 'subject=App Feedback&body=App Version 3.23', //add subject and body here
);
final Uri param = Uri(
  scheme: 'mailto',
  path: 'sarah.bensalem.cs@gmail.com',
  query: 'subject=App Feedback&body=App Version 3.23', //add subject and body here
);
//"assets/icons/Lock.svg"
myInfoSheet(BuildContext context) {
  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: (20.0 / 375.0) * screenWidth),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0))),
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 1.0,
                    color: Colors.black,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.0),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),

                      width: screenWidth,
                      child:
                      Text(
                        config.sharedPreferences.getString('name'),
                        style: TextStyle(
                            fontSize: screenWidth * .05,
                            fontWeight: FontWeight.bold),
                      ),


                    ),

                    SizedBox(height: 15.0),


                    Container(
                        width:MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 10,right: 10),
                        child: Text(config.sharedPreferences.getString('email'),style:TextStyle(color:Colors.blue))),


                  ],
                ),
                Divider(
                  color: kTextColor,
                ),

              ],
            ),
          ),
        );
      });
}
AdminSigninSheet(BuildContext context,id,passwd,onPressed){
  var screenWidth=MediaQuery.of(context).size.width;
  var screenHeight=MediaQuery.of(context).size.height;
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context, builder: (context){
    return Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container (
        padding: EdgeInsets.symmetric(horizontal: (20.0 / 375.0) * screenWidth),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0))
        ),
        height: MediaQuery.of(context).size.height*0.45,
        width:MediaQuery.of(context).size.width ,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.45,
              width:MediaQuery.of(context).size.width ,

              child: ListView(children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child:Divider(
                    thickness: 1.0,
                    color: Colors.black,
                  ),
                ),
                Form(
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top:25,left: 10,right: 10),
                            child:TextFormField(
                              controller: id,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "";
                                } else
                                  return null;
                              },
                              decoration: InputDecoration(
                                labelText: "ID",
                                hintText: "Admin ID",
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(color: Colors.black)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(color: Colors.black)
                                ) ,
                                // If  you are using latest version of flutter then lable text and hint text shown like this
                                // if you r using flutter less then 1.20.* then maybe this is not working properly
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                              ),
                            )
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                            margin: EdgeInsets.only(top:5,left: 10,right: 10),
                            child:TextFormField(
                              controller: passwd,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "";
                                } else
                                  return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Password",
                                hintText: "Admin password",
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(color: Colors.black)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(color: Colors.black)
                                ) ,
                                // If  you are using latest version of flutter then lable text and hint text shown like this
                                // if you r using flutter less then 1.20.* then maybe this is not working properly
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                //suffixIcon: Icon(Icons.email_outlined),
                              ),
                            )
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: Icon(FontAwesomeIcons.check,color: Colors.white,),
                    onPressed: onPressed/*(){
                      //  if(id.text.isNotEmpty&&passwd.text.isNotEmpty){
                     AuthCubit.get(context).adminLogin(id.text, passwd.text, context).then((value) => Get.to(()=>AddProducts()));

                      //  }
                    },*/
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.center ,
                      children: [
                        Text("Users can not access to Admin side ")
                      ],
                    )
                )
              ],),

            ),

          ],
        ),
      ),
    );
  });
}


