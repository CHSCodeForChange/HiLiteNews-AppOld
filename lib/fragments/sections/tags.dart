import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../models/tag.dart';
import '../../models/colors.dart';
import '../../api/tags.dart';
import './tag.dart';


class Tags extends StatefulWidget {
  @override
  TagsState createState() => new TagsState();
}

class TagsState extends State<Tags> {
  List<TagModel> tagsOg;
  List<TagModel> tags;
  ScrollController controller;

  @override
  void initState() {
    controller = new ScrollController();
    getData();
    super.initState();
  }

  Future<void> getData() async {
    tagsOg = (await new TagsAPI().getData()).toList();
    if (this.mounted) {
      setState(() {
        this.tags = tagsOg; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (tags == null) {
      return new Center(
        child: new SizedBox(
          height: 50.0,
          width: 50.0,
          child: new CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(MyColors.yellow())),
        ),
      );
    } else {
      return new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (String query) {
                tags = tagsOg.sublist(0,tagsOg.length);
                tags.retainWhere((item) => item.title.contains(query.toUpperCase()));
                this.setState(() {
                  tags = tags;
                });
              },

              decoration: InputDecoration(
                border: OutlineInputBorder(),
                fillColor: MyColors.yellow(),
                filled: true,
                hintText: "Search",
              ),
            ),
          ),
          new Expanded(
            child: new GridView.count(
              controller: controller,
              crossAxisCount: 2,
              children: new List.generate(tags != null ? tags.length : 0, (index) {
                return new Tag(tags.elementAt(index));
              }),
            )
          )
        ],
      );
    }
  }

}