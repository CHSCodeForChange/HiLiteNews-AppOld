import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../models/colors.dart';
import '../fragments/videos/videos.dart';

class VideosView extends StatelessWidget {

  @override 
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.blue(),
        title: Text('HiLite Newspaper', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),),
      ),
      body: new Videos()
    );
  }
}