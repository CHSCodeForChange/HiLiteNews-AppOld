import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../fragments/sections/sections.dart';
import '../fragments/sections/tags.dart';
import '../models/colors.dart';

class SectionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      initialIndex: 1,
      length: 11,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: MyColors.blue(),
          bottom: TabBar(
            indicatorColor: MyColors.yellow(),
            isScrollable: true,
            tabs: [
              Tab(text: "Sections"),
              Tab(text: "Tags"),
            ],
          ),
          title: Text('HiLite Newspaper', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),),
        ),
        body: TabBarView(
          children: [
            new Sections(),
            new Tags(),
          ],
        ),
      ),
    );
  }
}