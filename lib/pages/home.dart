import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './models/story.dart';
import './stories.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 10,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
              tabs: [
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