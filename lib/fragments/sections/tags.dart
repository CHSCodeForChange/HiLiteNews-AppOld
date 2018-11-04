import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../models/tag.dart';
import '../../models/colors.dart';
import '../../api/tags.dart';


class Tags extends StatefulWidget {
  @override
  TagsState createState() => new TagsState();
}

class TagsState extends State<Tags> {
  Iterable<TagModel> tags;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    Iterable<TagModel> tags = await new TagsAPI().getData();
    setState(() {
      this.tags = tags; 
    });
  }

  Future<void> getImage(TagModel section) async {
    if (section.image == null) {
      await section.fillImage();
      setState(() {
        tags = tags;
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
      return new GridView.count(
        crossAxisCount: 2,
        children: List.generate(tags.length, (index) {
          return Stack(
            children: <Widget>[
              new Container(
                color: MyColors.random(),
              ),
              new Container(
                padding: EdgeInsets.all(15.0),
                child: new Column(
                  children: <Widget>[
                    new AutoSizeText(
                      tags.elementAt(index).title,
                      maxLines: 1,
                      style: new TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    new AutoSizeText(
                      tags.elementAt(index).getCount().toString() + " Posts",
                      maxLines: 1,
                      style: new TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
                    )
                    
                  ],
                ),
              )
            ],
          );
        }),
      );
    }
  }

}