import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../models/story.dart';
import '../../models/colors.dart';
import './story.dart';
import 'stories.dart';

class Search extends StatelessWidget {
  final webview = FlutterWebviewPlugin();
  ScrollController controller = new ScrollController();

  Stories list;
  Iterable<StoryModel> stories;
  
  Search() {
    list = new Stories(null, null, " ");
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (String query) {
                list.updateQuery(query);
                list.scrollUp();
              },
              style: TextStyle(color: Colors.white),

              decoration: InputDecoration(
                border: OutlineInputBorder(),
                fillColor: MyColors.blue(),
                filled: true,
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.white),

              ),
            ),
          ),
          new Expanded (
            child: list,
          )
        ],
      )
    );
  }
}