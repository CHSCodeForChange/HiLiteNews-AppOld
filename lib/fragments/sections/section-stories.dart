import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../../models/colors.dart';
import '../../models/section.dart';
import '../stories/stories.dart';

class SectionStories extends StatelessWidget {
  SectionModel section;

  SectionStories(this.section);

  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: MyColors.blue(),
          title: Text(section.title, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        ),   
        body: new Stories(section.slug, null),
    );
  }

}