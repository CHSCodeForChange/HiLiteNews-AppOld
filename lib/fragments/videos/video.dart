import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../../models/colors.dart';
import '../../models/video.dart';


class Video extends StatelessWidget {
  VideoModel video;

  Video(this.video);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => new Webview(story)),
        // );
      },

      child: new Card(
        child: new Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              video.image == null ? new Container() :  video.image,
              new Padding (
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                child: new Text(
                  video.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 25.0, color:Colors.black, fontWeight: FontWeight.bold)
                ),
              ),
              new Padding (
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                child: new Text(
                  video.getTimeDiff(),
                  style: TextStyle(fontSize: 16.0, color: Colors.grey)
                )
              ),
             
              new Padding (
                padding: EdgeInsets.only(top: 5.0, bottom: 10.0, left: 10.0, right: 10.0),
                child: new Text(
                  video.excerpt,
                  style: TextStyle(fontSize: 14.0, color:Colors.black)
                ), 
              ),
            ],
          ),
        )
      )
    );
  }
}