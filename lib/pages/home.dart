import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../fragments/stories/search.dart';
import '../fragments/stories/stories.dart';
import '../models/colors.dart';
import '../models/database.dart';
import '../models/section.dart';
import '../models/tag.dart';

class HomeView extends StatefulWidget {

  @override
  HomeViewState createState() => new HomeViewState();
}

class HomeViewState extends State<HomeView> {

  List<Widget> children = [
    new Search(),
    new Stories(null, null, null)
  ];

  List<Tab> tabs = [
    Tab(icon: Icon(Icons.search)),
    Tab(text: 'All',),
  ];
  
  bool areSectionsFinished = false;
  bool areTagsFinished = false;

  @override
  void initState() {
    fillSections().whenComplete(() {areSectionsFinished = true;});
    fillTags().whenComplete(() {areTagsFinished = true;}); 
    super.initState();
  }

  Future<void> fillSections() async {
    List<SectionModel> sections = await DBHelper().getSections();
    for (int i = 0; i < sections.length; i++) {
      tabs.add(new Tab(text: sections[i].titleEachWordCapped()));
      children.add(new Stories(sections[i].slug, null, null));
    }
    this.setState(() {
      tabs = tabs;
      children = children;
    });
  }

  Future<void> fillTags() async {
    List<TagModel> tags = await DBHelper().getTags();
    for (int i = 0; i < tags.length; i++) {
      children.add(new Stories(null, tags[i].slug, null));
      tabs.add(new Tab(text: tags[i].title));
    }
    this.setState(() {
      tabs = tabs;
      children = children;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !areSectionsFinished || !areTagsFinished ? 
      new Center(
        child: new CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(MyColors.yellow())),
      ) :
      new DefaultTabController(
        initialIndex: 1,
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.blue(),
            bottom: new TabBar(
              indicatorColor: MyColors.yellow(),
              tabs: tabs, 
              isScrollable: true,
            ),
            title: Text('HiLite Newspaper', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),),
          ),
          body: TabBarView(
            children: children
          ),
        ),
      );
  }
}