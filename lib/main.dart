//import 'package:flutter/material.dart';
//import 'package:movie_app/pages/index.dart';
//import 'package:movie_app/theme/colors.dart';

///void main() => runApp(MaterialApp(
//   debugShowCheckedModeBanner: false,
// theme: ThemeData(
// primaryColor: primary
//),
// home: IndexPage(),
// ));

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/model/River.dart';
import 'package:movie_app/screens/home/home_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Box box;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(RiverAdapter());
  box = await Hive.openBox<River>('River3');
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant App',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
