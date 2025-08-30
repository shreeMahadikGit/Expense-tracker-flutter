import 'package:flutter/material.dart';


class AppColors{
 static late double totalfood;

  void _totalFood(double tf) {
    totalfood = tf;
  }

  AppColors({required double totalFood}) {
    _totalFood(totalFood);
  }

 static List pieColors = [
    Colors.indigo[400],
    Colors.blue,
    Colors.green,
    Colors.amber,
    Colors.deepOrange,
    Colors.brown,
  ];

 static List category = [
  {"name": "Food", "amount": totalfood},
  {"name": "Entertainment", "amount": 100.0},
  {"name": "Personal", "amount":100.0},
  {"name": "Transportation", "amount": 100.0},
  {"name": "Studies", "amount": 100.0},
  {"name": "Any", "amount": 100.0},
];
  
  static Color primaryWhite = Color(0xffedf1f4);



}

