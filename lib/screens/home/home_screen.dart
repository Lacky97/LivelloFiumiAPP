import 'package:flutter/material.dart';
import 'package:movie_app/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(), body: Body());
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
    );
  }
}
