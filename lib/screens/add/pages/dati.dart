import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_app/model/River.dart';
import 'package:movie_app/screens/home/components/header.dart';
import 'package:movie_app/screens/home/home_screen.dart';

import '../../../boxes.dart';
import '../../../constants.dart';

class Data extends StatefulWidget {
  final String prov;
  final String comun;
  const Data({Key key, this.prov, this.comun}) : super(key: key);
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  List<dynamic> data = [];
  bool isloading = false;
  List<dynamic> key = [
    "Bacino",
    "Comune",
    "Corso d'acqua",
    "Località",
    "Massimo nelle 24H[m]",
    "Ora di rif.",
    "Ora locale del massimo",
    "Provincia",
    "Valore all'ora di rif.[m]",
    "index",
    "level_0"
  ];
  
  final List<River> river = [];


  @override
  void initState() {
    super.initState();
    this.fetchUser();
  }

  Future addOnDB(List data) async{
    final river = River()
      ..Bacino = data[0].toString()
      ..Comune = data[1].toString()
      ..Corso_Acqua = data[2].toString()
      ..Localita = data[3].toString()
      ..Massimo24H = data[4].toString()
      ..Ora_Rif = data[5].toString()
      ..Ora_Loc = data[6].toString()
      ..Provincia = data[7].toString()
      ..Valore_ora_rif = data[8].toString();

    final box = Boxes.getRivers();

    box.add(river);
  }

  fetchUser() async {
    var url = Uri.parse(
        "http://192.168.1.66:5000/api/data?prov=${widget.prov}&comun=${widget.comun}");
    var response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> items = json.decode(response.body);
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
    return Column(children: <Widget>[
      Header(size: size, text: 'Aggiungi il fiume'),
      Container(
          height: 290,
          child: GestureDetector(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
                child: Column(children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return getCard(index, data[index]);
                          }))),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          child: Text("Aggiungi"),
                          onPressed: () {
                            addOnDB(data);
                            Navigator.push(
                                context, 
                                MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kTextColor),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                kBackgroundColor),
                          ))))
            ])),
          )))
    ]);
  }

  Widget getCard(index, value) {
    //var fullname = index['author'];
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(children: <Widget>[
            Text(key[index] + ': ',
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Column(children: <Widget>[
            Text(
              value.toString(),
            )
          ])
        ]);
  }
}
