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

  @override
  void initState() {
    fillSections().whenComplete(() {});
    fillTags().whenComplete(() {});
    super.initState();
  }

  Future<void> fillSections() async {
    List<SectionModel> sections = await DBHelper().getSections();
    for (int i = 0; i < sections.length; i++) {
      children.add(new Stories(sections[i].slug, null, null));
      tabs.add(new Tab(text: sections[i].title));
    }
    this.setState(() {
      children = children;
      tabs = tabs;
    });
  }

  Future<void> fillTags() async {
    List<TagModel> tags = await DBHelper().getTags();
    for (int i = 0; i < tags.length; i++) {
      children.add(new Stories(null, tags[i].slug, null));
      tabs.add(new Tab(text: tags[i].title));
    }
    this.setState(() {
      children = children;
      tabs = tabs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      initialIndex: 1,
      length: children.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.blue(),
          bottom: TabBar(
            indicatorColor: MyColors.yellow(),
            isScrollable: true,
            tabs: tabs
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