import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import './models/story.dart';
import './story.dart';
import './models/colors.dart';
import './home.dart';

class Stories extends StatefulWidget {
    final String category;
    Stories(this.category);


    @override
    StoriesState createState() => new StoriesState(this.category);

}

class StoriesState extends State<Stories> {
  final webview = FlutterWebviewPlugin();
  Iterable<StoryModel> stories;
  ScrollController controller = new ScrollController();
 
  final String domain = 'https://hilite.org';
  final String category;
  int count = 10;

  StoriesState(this.category);


  @override
  void initState() {
    this.getData();

    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        count += 5;
        getData();
      }
    });

    webview.close();
  }
  

   @override
  void dispose() {
    webview.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<String> getData() async {
    String url = this.domain + '/?json=get_recent_posts';
    if (this.category != null) {
      url = this.domain + '/?json=get_category_posts&slug=' + this.category;
    }

    url += '&count=' + this.count.toString() + '&page=1&include=posts,title,excerpt,thumbnail,url,date,custom_fields,tags';

    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
      }
    );

    print(url);
    
    if (this.mounted) {
      this.setState(() {
        List raw_stories = json.decode(response.body)['posts'];
        stories = (raw_stories).map((i) => new StoryModel.fromJson(i));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Material(
      color: MyColors.offWhite(),
      child: ListView.builder(
        itemCount: stories == null ? 1 : stories.length + 1,
        controller: controller,
        itemBuilder: (BuildContext context, int index) {
          if (index < (stories == null ? 0  : stories.length)) {
            return new GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Story(stories.elementAt(index))),
                );
              },

              child: new Card(
                child: new Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      stories.elementAt(index).image == null ? new Container() :  
                      new Stack(
                        alignment: Alignment.bottomLeft,
                        children: <Widget>[
                          stories.elementAt(index).image,
                          stories.elementAt(index).isTagNull() ? new Container() : 
                            new Padding(
                              padding: EdgeInsets.only(bottom: 10.0, left: 15.0),
                              child: new Chip(
                                shape: RoundedRectangleBorder(),
                                backgroundColor: MyColors.yellow(),
                                label: new Text(
                                  stories.elementAt(index).topTag,
                                  style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                                ),
                              )
                            )
                        ],
                      ),
                      new Padding (
                        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                        child: new Text(
                          stories.elementAt(index).title,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 25.0, color:Colors.black, fontWeight: FontWeight.bold)
                        ),
                      ),
                      stories.elementAt(index).isExcerptNull() ? new Container() :
                        new Padding (
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                          child: new Text(
                            stories.elementAt(index).excerpt,
                            style: TextStyle(fontSize: 14.0, color:Colors.black)
                          ), 
                        ),
                      new Padding (
                        padding: EdgeInsets.only(top: 5.0, bottom: 10.0, left: 10.0, right: 10.0),
                        child: new Text(
                          stories.elementAt(index).timeDiff() + stories.elementAt(index).getAuthor(),
                          style: TextStyle(fontSize: 16.0, color: Colors.black)
                        )
                      ),
                    ],
                  ),
                )
              )
            );
          } else {
            return new Card(
              child: new Container(
                padding: EdgeInsets.all(30.0),
                child: new Container(
                  child: new LinearProgressIndicator(
                    backgroundColor: MyColors.semiTransYellow(),
                    valueColor: AlwaysStoppedAnimation<Color>(MyColors.yellow()),
                  ),
                )
              ),
            );
          }
        },
      )
    );
  }
}