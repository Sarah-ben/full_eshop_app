import 'package:flutter/material.dart';

import 'favBody.dart';
class FavScreen extends StatefulWidget {
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FavBody(),
    );
  }
}


