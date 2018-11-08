import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../../models/colors.dart';
import '../../models/tag.dart';
import '../stories/stories.dart';

class TagStories extends StatelessWidget {
  TagModel tag;

  TagStories(this.tag);

  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: MyColors.blue(),
          title: Text(tag.title, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        ),   
        body: new Stories(null, tag.slug, null),
    );
  }

}