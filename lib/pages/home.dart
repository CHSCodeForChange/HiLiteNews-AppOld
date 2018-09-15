import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './search.dart';
import './stories.dart';
import './models/colors.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 11,
        initialIndex: 1,
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
            title: Text('HiLite Newspaper'),
          ),
          body: TabBarView(
            children: [
              new Search(),
              new Stories(null),
              new Stories('news'),
              new Stories('feature'),
              new Stories('student-section'),
              new Stories('entertainment'),
              new Stories('sports'),
              new Stories('perspectives'),
              new Stories('fame'),
              new Stories('just-a-minute'),
              new Stories('onlineonly'),
            ],
          ),
        ),
      ),
    );
  }
}