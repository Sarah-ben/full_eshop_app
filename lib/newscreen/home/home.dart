import 'package:full_eshop_app/newscreen/Favorite/favorite.dart';
import 'package:full_eshop_app/newscreen/card/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Enums.dart';
import '../../constants.dart';
import 'homebody.dart';
class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;

    return Scaffold(
    body: ProductsPage(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    icon: Icon(Icons.home_outlined,
                      size: MediaQuery.of(context).size.width/15.0,),
                    onPressed: () {
                      Get.off(()=>HomeScreen());
                    }

                  //   Navigator.pushNamed(context, HomeScreen.routeName),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        // margin:EdgeInsets.only(right:10),
                        // padding: EdgeInsets.all((12.0/ 375.0) * screenWidth),
                          height:(46.0 / 375.0) * screenWidth,
                          width: (46.0 / 375.0) * screenWidth,
                          decoration: BoxDecoration(
                            color: kSecondaryColor.withOpacity(0.0),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(icon: Icon(Icons.favorite_outline_sharp,color: Colors.black,
                            size: MediaQuery.of(context).size.width/15.0,
                          ), onPressed:()=> Get.to(()=>FavScreen()),
                          )
                      ),
                      //if (config.sharedPreferences('userCart') != 0)
                      /* Positioned(
                      top: -3,
                      right: 0,
                      child: Container(
                        height: (16.0 / 375.0) * screenWidth,
                        width: (16.0 / 375.0) * screenWidth,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF4848),
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(width: 1.5, color: Colors.white),
                        ),
                        child: Center(
                          child:Text(
    "${config.sharedPreferences.getStringList('userWishList').length -1}",
    style: TextStyle(
    fontSize: (10.0 / 375.0) * screenWidth,
    height: 1,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    ),
    )

                        ),
                      ),
                    )
                    */
                    ],
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: ()=>Get.to(()=>CartScreen()),
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        // margin:EdgeInsets.only(right:10),
                        //  padding: EdgeInsets.all((12.0/ 375.0) * screenWidth),
                        height:(46.0 / 375.0) * screenWidth,
                        width: (46.0 / 375.0) * screenWidth,
                        decoration: BoxDecoration(
                          color: kSecondaryColor.withOpacity(0.0),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.shopping_cart_outlined,color: Colors.black,
                          size: MediaQuery.of(context).size.width/15.0,
                        ),
                      ),
                      //if (config.sharedPreferences('userCart') != 0)
                      /*  Positioned(
                      top: -3,
                      right: 0,
                      child: Container(
                        height: (16.0 / 375.0) * screenWidth,
                        width: (16.0 / 375.0) * screenWidth,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF4848),
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(width: 1.5, color: Colors.white),
                        ),
                        child: Center(
                          child: Text('0')
                        ),
                      ),
                    )
                    */
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}