import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:html2md/html2md.dart' as html2md;

import './models/paper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


String url = 'https://www.google.com';
String title  = 'Story Title';

class Stories extends StatefulWidget {


    final PaperModel paper;

    Stories(this.paper);

    @override
    StoriesState createState() => new StoriesState(this.paper);

}

class StoriesState extends State<Stories> {
  List stories;

  final webview = FlutterWebviewPlugin();

 

  final PaperModel paper;
  StoriesState(this.paper);


  @override
  void initState() {
    this.getData();
    webview.close();
  }
  

   @override
  void dispose() {
      webview.dispose();
      super.dispose();
    }

  Future<String> getData() async {

    String url = this.paper.website + '?json=get_recent_posts&count=12&page=1&include=posts,title,excerpt,thumbnail,url,modified,custom_fields';
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
      }
    );
    
    this.setState(() {
      stories = JSON.decode(response.body)['posts'];
    });

    print(stories[3]['thumbnail_images']);
  }



  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.deepPurple,
      child: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top:20.0, bottom: 5.0),
            child: new Text(
              paper.name,
              
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),

            )
          ),
          new Expanded(
            child: new ListView.builder(
              itemCount: stories == null ? 0 : stories.length,
              padding: new EdgeInsets.all(8.0),
              itemBuilder: (BuildContext context, int index) {
                return new GestureDetector(
                  onTap: () {
                    url = stories[index]['url'];
                    title = stories[index]['title'];
                    Navigator.of(context).pushNamed('/webview');
                  },

                  child: new Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    child: new Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            html2md.convert(stories[index]["title"]),
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 20.0, color:Colors.black, fontWeight: FontWeight.bold)
                          ),
                          new Padding (
                            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: new Text(
                              stories[index]["modified"],
                              style: TextStyle(fontSize: 14.0, color:Colors.black54)
                            ), 
                          ),
                          stories[index]['thumbnail_images'] == null ? new Container() : Image.network(stories[index]['thumbnail_images']['medium']['url']),
                          new Padding (
                            padding: EdgeInsets.only(top: 10.0),
                            child: new Text(
                              html2md.convert(stories[index]["excerpt"]),
                              style: TextStyle(fontSize: 14.0, color:Colors.black)
                            ), 
                          )
                        ],
                      ),
                    )
                  )
                );
              },
            )
          )
        ],
      )
    );
  }
}