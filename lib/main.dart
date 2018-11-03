import 'package:flutter/material.dart';
import './pages/main.dart';
import 'models/colors.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webview Example',
      theme: new ThemeData(
        canvasColor: MyColors.blue(),
      ),
      home: new Main(),
    );
  }
}