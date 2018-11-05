import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../fragments/stories/search.dart';
import '../fragments/stories/stories.dart';
import '../models/colors.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      initialIndex: 1,
      length: 11,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.blue(),
          bottom: TabBar(
            indicatorColor: MyColors.yellow(),
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.search)),
              Tab(text: 'All',),
              Tab(text: 'News',),
              Tab(text: 'Feature',),
              Tab(text: 'Student Section',),
              Tab(text: 'Entertainment',),
              Tab(text: 'Sports',),
              Tab(text: 'Perspectives',),
              Tab(text: '15 Minutes of Fame',),
              Tab(text: 'Just A Minute',),
              Tab(text: 'Online Only',),
            ],
          ),
          title: Text('HiLite Newspaper', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),),
        ),
        body: TabBarView(
          children: [
            new Search(),
            new Stories(null, null),
            new Stories('news', null),
            new Stories('feature', null),
            new Stories('student-section', null),
            new Stories('entertainment', null),
            new Stories('sports', null),
            new Stories('perspectives', null),
            new Stories('fame', null),
            new Stories('just-a-minute', null),
            new Stories('onlineonly', null),
          ],
        ),
      ),
    );
  }
}