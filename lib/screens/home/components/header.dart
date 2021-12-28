import 'package:flutter/material.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header(
      {Key key, @required this.size, @required this.text, this.subtext, this.level})
      : super(key: key);

  final Size size;
  final String text;
  final String subtext;
  final String level;
  

  MaterialColor getColorLevel() {
    var riverLevel = double.parse(level);
    if(riverLevel >= 1 && riverLevel < 2){
      return Colors.yellow;
    } else if (riverLevel >= 2 && riverLevel < 3){
      return Colors.orange;
    } if (riverLevel >= 3){
      return Colors.red;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 0.1),
      // It will cover 20% of our total height
      height: size.height * 0.15,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Column(children: <Widget>[
                  Text(
                    this.text,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  (subtext != null
                      ? Text(
                          this.subtext,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      : Text('')),
                ]),
                Spacer(),
                (level != null
                    ? Column(children: <Widget>[
                        Text(
                          '$level mt', 
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: getColorLevel(), fontWeight: FontWeight.bold),
                        ),
                      ])
                    : Text(''))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
