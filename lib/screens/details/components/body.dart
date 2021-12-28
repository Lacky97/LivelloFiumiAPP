import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/model/River.dart';
import 'package:movie_app/screens/details/components/lineTitles.dart';
import 'package:movie_app/screens/details/components/linechart.dart';
import 'package:movie_app/screens/home/components/header.dart';

import '../../../boxes.dart';

import 'package:flutter/material.dart';

import 'package:spring_button/spring_button.dart';

class Body extends StatelessWidget {
  const Body({Key key, this.data}) : super(key: key);

  final River data;

  void removeElementDB(key) {
    final box = Boxes.getRivers();
    box.delete(key);
  }

  Widget row(String text, Color color) {
    return Padding(
      padding: EdgeInsets.all(12.5),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Header(
            size: size,
            text: data.Bacino,
            subtext: data.Comune,
            level: data.Valore_ora_rif,
          ),
          Row(children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 20.0, right: 20.0, bottom: 5.0),
                child: SizedBox(
                    width: size.width / 1.11,
                    height: 220,
                    child: Card(
                        child: Column(children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(children: <Widget>[
                                  Text("Corso d'acqua: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                  Text("${data.Corso_Acqua}")
                                ])),
                            Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(children: <Widget>[
                                  Text("Località: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                  Text("${data.Localita}")
                                ])),
                            Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(children: <Widget>[
                                  Text("Valore massimo nelle 24h: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                  Text("${data.Massimo24H}")
                                ])),
                            Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(children: <Widget>[
                                  Text("Ora di riferimento: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                  Text("${data.Ora_Rif}")
                                ])),
                            Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(children: <Widget>[
                                  Text("Ora Località: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                  Text("${data.Ora_Loc}")
                                ])),
                            Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(children: <Widget>[
                                  Text("Provincia: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                  Text("${data.Provincia}")
                                ])),
                          ]))
                    ]))))
          ]),
          Row(children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, left: 20.0, right: 20.0, bottom: 20.0),
                child: SizedBox(
                    width: size.width / 1.11,
                    height: 220,
                    child: Card(
                      child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Text(
                  ('Livello del fiume ' + data.Bacino.toString()),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: MyLineChart(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            /*IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white.withOpacity( 1.0 ),
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            )*/
          ],
        ), 
                      
                    
                      ),
                    ))
          ]),
          Column(
            children: <Widget>[
              SizedBox(
                width: size.width / 2,
                height: 84,
                child: SpringButton(
                  SpringButtonType.OnlyScale,
                  row(
                    "Rimuovi",
                    Colors.deepOrangeAccent,
                  ),
                  onTapDown: (_) =>
                      {removeElementDB(data.key), Navigator.pop(context)},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



/* 

TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    
                  },
                  child: Text(
                    "Rimuovi",
                    style: TextStyle(
                      backgroundColor: Colors.red,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),

*/

/*   LineChart(
                          LineChartData(
                            minX: 0,
                            maxX: 6,
                            minY: 0,
                            maxY: 10,
                            titlesData: LineTitles.getTitleData(),
                            gridData: FlGridData(
                              show: true,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: const Color(0xff37434d),
                                  strokeWidth: 1,
                                );
                              },
                              drawVerticalLine: true,
                              getDrawingVerticalLine: (value) {
                                return FlLine(
                                  color: const Color(0xff37434d),
                                  strokeWidth: 1,
                                );
                              },
                            ),
                            borderData: FlBorderData(
                                show: true,
                                border: Border.all(
                                    color: const Color(0xff37434d), width: 1)),
                            lineBarsData: [
                              LineChartBarData(
                                  spots: [
                                    FlSpot(0, 3),
                                    FlSpot(1, 2),
                                    FlSpot(2, 5),
                                    FlSpot(3, 2.5),
                                    FlSpot(4, 4),
                                    FlSpot(5, 3),
                                    FlSpot(6, 4),
                                  ],
                                  colors: [
                                    Colors.blue
                                  ],
                                  barWidth: 6,
                                  )
                            ],
                          ),
                          swapAnimationDuration: Duration(milliseconds: 150),
                          swapAnimationCurve: Curves.linear,
                        ),*/

