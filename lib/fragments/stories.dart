import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../api/stories.dart';
import '../models/story.dart';
import '../models/colors.dart';
import './story.dart';
import './loader.dart';

class Stories extends StatefulWidget {
    final String category;
    Stories(this.category);


    @override
    StoriesState createState() => new StoriesState(this.category);

}

class StoriesState extends State<Stories> {
  final webview = FlutterWebviewPlugin();
  Iterable<StoryModel> stories;
  ScrollController controller = new ScrollController();
 
  final String category;
  int count = 10;

  StoriesState(this.category);


  @override
  void initState() {
    this.getData();

    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        count += 5;
        getData();
      }
    });

    webview.close();
  }
  

   @override
  void dispose() {
    webview.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> getData() async {
    Iterable<StoryModel> stories = await new StoriesAPI().getData(category, count);
    this.setState(() {
      this.stories = stories;
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Material(
      color: MyColors.offWhite(),
      child: ListView.builder(
        itemCount: stories == null ? 1 : stories.length + 1,
        controller: controller,
        itemBuilder: (BuildContext context, int index) {
          if (index < (stories == null ? 0  : stories.length)) {
            return new Story(stories.elementAt(index));
          } else {
            return new Loader();
          }
        },
      )
    );
  }
}