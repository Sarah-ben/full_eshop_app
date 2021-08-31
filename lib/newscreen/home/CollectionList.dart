import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CollectionList extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding:
      EdgeInsets.only(left:20.0,top: 10.0,bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Our ',
              style: TextStyle(color: Colors.black,fontSize: 25.0,fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(text: 'Products',
                  style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.normal),
                )
              ]
            ),

          )
         // SearchField(),

        ],
      ),
    );
  }
  @override
  double get maxExtent => 43.0;

  @override
  double get minExtent => 43.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
