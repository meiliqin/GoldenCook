
import 'package:chinese_food/home/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //需要用StatelessWidget包裹MaterialApp后面才能获取到屏幕宽高
    return MaterialApp(
      // theme: ThemeData(
      //   primaryColor: Colors.white
      // ),
      home: MainPage(),
    );
  }

}