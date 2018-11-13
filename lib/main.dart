import 'package:flutter/material.dart';

import './pages/main.dart';
import 'models/colors.dart';
import 'models/notif.dart';
import 'models/database.dart';


void main() {
  // Notifications notifications = new Notifications();
  runApp(MyApp());
  // DBHelper().closeDB();
}

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