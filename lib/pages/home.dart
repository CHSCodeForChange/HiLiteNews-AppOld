import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './search.dart';
import './stories.dart';
import './models/colors.dart';
class Home extends StatefulWidget {

  @override
  HomeState createState() => new HomeState();

}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = new TabController(vsync: this, length: 11, initialIndex: 1);
  }

   @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  void changePage(int index, BuildContext drawer_context) {
    _tabs.animateTo(index);
    Navigator.of(drawer_context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 11,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.blue(),
            bottom: TabBar(
              controller: _tabs,
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

          drawer: new Drawer(
            child: new ListView(
              padding: EdgeInsets.all(0.0),
              children: <Widget>[
                DrawerHeader(
                  child: Text(
                    'HiLite Newspaper', 
                    style: new TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                    color: MyColors.blue(),
                  ),
                ),
                ListTile(
                  title: Text('All'),
                  onTap: () {
                    _tabs.animateTo(1);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('News'),
                  onTap: () {
                    this.setState((){
                      changePage(2, context);
                    });
                  },
                ),
                ListTile(
                  title: Text('Feature'),
                  onTap: () {
                    this.setState((){
                      changePage(3, context);
                    });
                  },
                ),
                ListTile(
                  title: Text('Student Section'),
                  onTap: () {
                    this.setState((){
                      changePage(4, context);
                    });
                  },
                ),
                ListTile(
                  title: Text('Entertainment'),
                  onTap: () {
                    this.setState((){
                      changePage(5, context);
                    });
                  },
                ),
                ListTile(
                  title: Text('Sports'),
                  onTap: () {
                    this.setState((){
                      changePage(6, context);
                    });
                  },
                ),
                ListTile(
                  title: Text('Perspectives'),
                  onTap: () {
                    this.setState((){
                      changePage(7, context);
                    });
                  },
                ),
                ListTile(
                  title: Text('15 Minutes of Fame'),
                  onTap: () {
                    this.setState((){
                      changePage(8, context);
                    });
                  },
                ),
                ListTile(
                  title: Text('Just A Minute'),
                  onTap: () {
                    this.setState((){
                      changePage(9, context);
                    });
                  },
                ),
                ListTile(
                  title: Text('Online Only'),
                  onTap: () {
                    this.setState((){
                      changePage(10, context);
                    });
                  },
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabs,
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