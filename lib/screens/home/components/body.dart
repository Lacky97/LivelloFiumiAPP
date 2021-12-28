import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';

import 'header_with_seachbox.dart';
import 'recomend_plants.dart';
import 'title_with_more_bbtn.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          TitleWithMoreBtn(title: "I tuoi Fiumi", press: () {}),
          RecomendsPlants(),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
