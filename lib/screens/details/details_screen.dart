import 'package:flutter/material.dart';
import 'package:movie_app/model/River.dart';
import 'package:movie_app/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key key, this.data}) : super(key: key);

  final River data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Body(data: data),
    );
  }
}
