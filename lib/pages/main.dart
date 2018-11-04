import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'sections.dart';
import 'videos.dart';
import '../models/colors.dart';

class Main extends StatefulWidget {

  @override 
  MainState createState() => new MainState();
}

class MainState extends State<Main> {

  int index = 1;

  List<Widget> pages = [
    new VideosView(),
    new HomeView(),
    new SectionsView(),
  ];

  List<BottomNavigationBarItem> navItems = [
    new BottomNavigationBarItem(
      icon: Icon(Icons.ondemand_video),
      title: new Text("Videos"),
    ),
    new BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: new Text("Home"),
    ),
    new BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      title: new Text("Sections"),
    ),
  ];

  void onTabTapped(int index) {
    setState(() {
      this.index = index;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
        fixedColor: Colors.white,
        currentIndex: index,
        onTap: onTabTapped,
        items: navItems,
      ),
      body: pages[index],
    );
  }
}