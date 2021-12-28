import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:movie_app/model/River.dart';
import 'package:movie_app/screens/details/details_screen.dart';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

import '../../../boxes.dart';
import '../../../constants.dart';

class RecomendsPlants extends StatefulWidget {
  const RecomendsPlants({
    Key key,
  }) : super(key: key);

  @override
  _RecomendsPlants createState() => _RecomendsPlants();
}


Future updateDB(List data, index) async{
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

    box.put(index, river);
  }

void updateMyRiver() async {
    var box = Boxes.getRivers().values.toList().cast<River>();
    for (var i = 0; i < box.length; i++){
      var url = Uri.parse("http://192.168.1.66:5000/api/data?prov=${box[i].Provincia}&comun=${box[i].Comune}");
    var response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> items = json.decode(response.body);
      List<dynamic> data = items.values.toList();
      updateDB(data, box[i].key);
      }
    }
  }

class _RecomendsPlants extends State<RecomendsPlants> {


  @override
  void initState() {
    super.initState();
    updateMyRiver();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: Boxes.getRivers().listenable(),
        builder: (context, box, _) {
          final rivers = box.values.toList().cast<River>();
          if (rivers.length <= 0) {
            return Container(
                margin: EdgeInsets.only(
                  left: kDefaultPadding,
                  top: kDefaultPadding,
                  bottom: kDefaultPadding / 4,
                ),
                width: size.width * 0.9,
                child: Column(children: <Widget>[]));
          }
          List<Widget> list = <Widget>[];
          for (var i = 0; i < rivers.length; i++) {
            var river = box.getAt(i);

            list.add(RecomendPlantCard(
              title: river.Bacino,
              country: river.Comune,
              price: double.parse(river.Valore_ora_rif.toString()),
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(data: river),
                  ),
                );
              },
            ));
          }
          return SingleChildScrollView(
              scrollDirection: Axis.horizontal, child: Column(children: list));
        });
  }
}

class RecomendPlantCard extends StatefulWidget {
  const RecomendPlantCard({
    Key key,
    this.title,
    this.country,
    this.price,
    this.press,
  }) : super(key: key);

  final String title, country;
  final double price;
  final Function press;

  @override
  _RecomendPlantCard createState() => _RecomendPlantCard();
}

class _RecomendPlantCard extends State<RecomendPlantCard> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Timer timer;

  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }

  void checkIfChanged() {
    print('ciao ci sono mi chiamo luca and i dont dance');
    updateMyRiver();
  }

  @override
  initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 60), (Timer t) => checkIfChanged());
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _showNotificationWithDefaultSound);
  }

  Future onSelectNotification(String payload) async {
    debugPrint("payload: $payload");
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
            title: new Text("Payload"), content: new Text('Payload')));
  }

  Future _showNotificationWithDefaultSound(String payload) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  showNotification(String river, double price) async {
    var android = new AndroidNotificationDetails(
        "channelId",
        "Local Notification",
        "This is the description of the notification, you can write anything",
        importance: Importance.high);
    var ios = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin.show(
        0, 'Attenzione livello alto', 'Il fiume ' + river + ' ha superato i 1 mt di altezza e si trova a ' + price.toString() + 'mt', generalNotificationDetails,
        payload: 'ciaooooooooooo');
  }
/*
  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
      "channelId",
      "Local Notification",
      "This is the description of the notification, you can write anything",
      importance: Importance.high
    );
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails = new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotifications.show(0,'Notif Title', 'the body of the notify', generalNotificationDetails);

  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if(widget.price > 1.0) showNotification(widget.title, widget.price);
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding,
        bottom: kDefaultPadding / 4,
      ),
      width: size.width * 0.9,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: widget.press,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: widget.price > 1.0 ? kDanger : Colors.white,
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
                            text: "${widget.title}\n".toUpperCase(),
                            style: widget.price > 1.0
                                ? TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)
                                : Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "${widget.country}".toUpperCase(),
                          style: widget.price > 1.0
                              ? TextStyle(color: Colors.white)
                              : TextStyle(
                                  color: kPrimaryColor.withOpacity(0.5),
                                ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${widget.price} mt',
                    style: widget.price > 1.0
                        ? TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)
                        : Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: kPrimaryColor),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
