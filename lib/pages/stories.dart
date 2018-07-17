import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';

import './paper.dart';
import 'package:http/http.dart' as http;

class Stories extends StatefulWidget {

    final String name, url;

    Stories(this.name, this.url);

    @override
    StoriesState createState() => new StoriesState(this.name, this.url);

}

class StoriesState extends State<Stories> {

  List stories;

  final String name, url;
  StoriesState(this.name, this.url);


  @override
  void initState() {
    this.getData();
  }
  
  Future<String> getData() async {

    String url = this.url + '?json=get_recent_posts&count=12&page=1&include=posts,title,excerpt,thumbnail,url,modified,custom_fields';
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
              name,
              
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
                    
                  },

                  child: new Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    child: new Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            stories[index]["title"],
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 20.0, color:Colors.black, fontWeight: FontWeight.bold)
                          ),
                          new Text(
                            stories[index]["modified"],
                            style: TextStyle(fontSize: 14.0, color:Colors.black54)
                          ), 
                          stories[index]['thumbnail_images'] == null ? new Container() : Image.network(stories[index]['thumbnail_images']['medium']['url']),
                          new Text(
                            html2md.convert(stories[index]["excerpt"]),
                            style: TextStyle(fontSize: 14.0, color:Colors.black)
                          ), 
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