import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitles {
  static getTitleData() => FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      showTitles: true,
      reservedSize: 22,
      getTitles: (value) { 
        switch (value.toInt()){
          case 2: return 'MAR';
          case 5: return 'JUN';
          case 8: return 'SEP';
        }
        return '';
      },
      margin: 0,
    ),
    leftTitles: SideTitles(
      showTitles: true,
      reservedSize: 20,
      getTitles: (value) { 
        switch (value.toInt()){
          case 2: return '10k';
          case 5: return '30k';
          case 8: return '50k';
        }
        return '';
      },
      margin: 2,
    ),
    topTitles: SideTitles(
      showTitles: false,),
    rightTitles: SideTitles(showTitles: false)
  );
}