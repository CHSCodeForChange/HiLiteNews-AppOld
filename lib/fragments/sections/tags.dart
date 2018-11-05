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
  Iterable<TagModel> tags;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    Iterable<TagModel> tags = await new TagsAPI().getData();
    setState(() {
      this.tags = tags; 
    });
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
        children: List.generate(tags != null ? tags.length : 0, (index) {
          return new Tag(tags.elementAt(index));
        }),
      );
    }
  }

}