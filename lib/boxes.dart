import 'package:hive/hive.dart';

import 'model/River.dart';

class Boxes {
  static Box<River> getRivers() => 
    Hive.box<River>('River3');
}