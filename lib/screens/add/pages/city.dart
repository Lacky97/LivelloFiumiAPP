import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/add/pages/dati.dart';
import 'package:movie_app/screens/home/components/header.dart';

import '../../../boxes.dart';

class City extends StatefulWidget {
  final String prov;
  const City({Key key, this.prov, box}) : super(key: key);
  @override
  _CityState createState() => _CityState();
}

class _CityState extends State<City> {
  List<dynamic> data = [];
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    var url =
        Uri.parse("http://192.168.1.66:5000/api/comuni?prov=${widget.prov}");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> items = json.decode(response.body);
      List<dynamic> comuni = [];
      List<dynamic> item = [];
      List<dynamic> output = [];
      var box = Boxes.getRivers();
      if (box.values.toList().length != 0) {
        items.forEach((k, element) {
          item.add(element);
        });
        for (int i = 0; i < box.values.toList().length; i++) {
          comuni.add(box.values.toList()[i].Comune);
        }
        print(item);
        print(comuni);

        item.forEach((element) {
          if (!comuni.contains(element)) {
            output.add(element);
          }
        });
        print(output);
        setState(() {
          data = output;
        });
      } else {
        setState(() {
          data = items.values.toList();
        });
      }
    } else {
      setState(() {
        data = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: getBody(),
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

  Widget getBody() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Header(size: size, text: 'Seleziona il comune'),
          Column(
              children: List.generate(data.length, (index) {
            return ActualComCard(
                comune: data[index],
                prov: widget.prov,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        settings: RouteSettings(name: "/Prov/City/River"),
                        builder: (context) =>
                            Data(prov: widget.prov, comun: data[index])),
                  );
                });
          }))
        ]));
  }

  Widget getCard(index) {
    //var fullname = index['author'];
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                settings: RouteSettings(name: "/Prov/City/River"),
                builder: (context) => Data(prov: widget.prov, comun: index)),
          );
        },
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            title: Row(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        index.toString(),
                        textAlign: TextAlign.center,
                      )
                    ])
              ],
            ),
          ),
        )));
  }
}

class ActualComCard extends StatelessWidget {
  const ActualComCard({
    Key key,
    this.comune,
    this.prov,
    this.press,
  }) : super(key: key);

  final String comune, prov;
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
              padding: EdgeInsets.all(kDefaultPadding * 0.8),
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
                            text: "$comune\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "$prov".toUpperCase(),
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        ),
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
