import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';

import '../../models/colors.dart';
import '../../models/tag.dart';
import '../../models/database.dart';
import 'tag-stories.dart';

class Tag extends StatefulWidget {

  TagModel tag;

  Tag(this.tag);

  @override 
  TagState createState() => new TagState(tag);
}

class TagState extends State<Tag> {

  TagModel tag;

  TagState(this.tag);

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    await tag.fillImage();
    await tag.isSaved();
    if (this.mounted) {
      setState(() {
        tag = tag;
      });
    }
  }

  @override 
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => new TagStories(tag)),
        );
      },
      child: new Stack(
        children: <Widget>[ 
          tag.image != null ? tag.image : new Container(
            color: MyColors.random(),
          ),
          tag.image != null ? new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: new Container(
              decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
          ) : new Container(), 
          new Container(
            padding: EdgeInsets.all(15.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  color: MyColors.yellow(),
                  padding: EdgeInsets.all(10.0),
                  child: new AutoSizeText(
                    tag.title,
                    maxLines: 1,
                    style: new TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                new Expanded(
                  child: new Container(
                    alignment: Alignment.bottomLeft,
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          tag.getCount(),
                          style: new TextStyle(fontSize: 17.0, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        new IconButton(
                          icon: Icon(tag.saved == null || !tag.saved ? Icons.add_circle : Icons.check_circle),
                          color: Colors.white, 
                          onPressed: () {
                            if (tag.saved == null || !tag.saved) {
                              DBHelper().saveTag(tag);
                              this.setState(() {
                                tag.saved = true;
                              });
                            } else {
                              DBHelper().deleteTag(tag);
                              this.setState(() {
                                tag.saved = false;
                              });
                            }
                          },
                        )
                      ],
                    )
                  )
                )
              ],
            ),
          )
        ],
      )
    );
  }

}