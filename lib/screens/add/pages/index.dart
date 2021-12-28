import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/screens/add/pages/city.dart';
import 'package:movie_app/screens/home/components/header.dart';
import '../../../constants.dart';

var listOfRiver = [];

class IndexPage extends StatefulWidget {
  final Box box;
  
  const IndexPage({
    Key key,
    this.box
  }) : super(key: key);
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List<dynamic> data = [];
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    var url = Uri.parse("http://192.168.1.66:5000/api/provincie");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> items = json.decode(response.body);
      print(items);
      setState(() {
        data = items.values.toList();
      });
    } else {
      setState(() {
        data = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(),
      body: getWidget(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {
          Navigator.pop(
            context,
          );
        },
      ),
    );
  }

  Widget getWidget() {
    Size size = MediaQuery.of(context).size;
    return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      Header(size: size, text: 'Seleziona la provincia'),
      GridView.count(
          childAspectRatio: 5 / 2,
          crossAxisCount: 2,
          shrinkWrap: true,
          children: List.generate(data.length, (index) {
            return ActualProvCard(
                provincia: data[index],
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        settings: RouteSettings(name: "/Prov/City"),
                        builder: (context) => City(prov: data[index])),
                  );
                });
          }))
    ]);
  }
}

class ActualProvCard extends StatelessWidget {
  const ActualProvCard({
    Key key,
    this.provincia,
    this.press,
  }) : super(key: key);

  final String provincia;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          left: kDefaultPadding / 2,
          top: kDefaultPadding,
          bottom: kDefaultPadding / 4,
          right: kDefaultPadding),
      width: size.width * 0.9,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$provincia".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
