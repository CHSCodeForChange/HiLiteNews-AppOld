import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';

import '../../models/colors.dart';
import '../../models/section.dart';
import '../../models/database.dart';
import 'section-stories.dart';

class Section extends StatefulWidget {

  SectionModel section;

  Section(this.section);

  @override 
  SectionState createState() => new SectionState(section);
}

class SectionState extends State<Section> {
  SectionModel section;
  final double blur = 2.0;

  SectionState(this.section);

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override 
  void dispose() {
    super.dispose();
  }

  Future<void> getData() async {
    await section.fillImage();
    if (this.mounted) {
      setState(() {
        section = section;
      });
    }
  }

  @override 
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => new SectionStories(section)),
        );
      },
      child: new Stack(
        children: <Widget>[ 
          section.image != null ? section.image : new Container(
            color: MyColors.random(),
          ),
          section.image != null ? new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: blur, sigmaY: blur),
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
                    section.title,
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
                        new AutoSizeText(
                          section.getCount(),
                          maxLines: 1,
                          style: new TextStyle(fontSize: 17.0, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        new IconButton(
                          icon: Icon(section.saved == null || !section.saved ? Icons.add_circle : Icons.check_circle),
                          color: Colors.white, 
                          onPressed: () {
                            if (section.saved == null || !section.saved) {
                              DBHelper().saveSection(section);
                              this.setState(() {
                                section.saved = true;
                              });
                            } else {
                              DBHelper().deleteSection(section);
                              this.setState(() {
                                section.saved = false;
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
      ),
    );
  }

}