import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../models/section.dart';
import '../../models/colors.dart';
import '../../api/sections.dart';


class Sections extends StatefulWidget {
  @override
  SectionsState createState() => new SectionsState();
}

class SectionsState extends State<Sections> {
  Iterable<SectionModel> sections;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    Iterable<SectionModel> sections = await new SectionsAPI().getData();
    setState(() {
      this.sections = sections; 
    });
  }

  Future<void> getImage(SectionModel section) async {
    if (section.image == null) {
      await section.fillImage();
      setState(() {
        sections = sections;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (sections == null) {
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
        children: List.generate(sections.length, (index) {
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
                      sections.elementAt(index).title,
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