import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../api/stories.dart';
import '../../models/story.dart';
import '../../models/colors.dart';
import './story.dart';
import '../loader.dart';

class Stories extends StatefulWidget {
    final String category;
    final String tag;
    final String query;
    StoriesState state;

    Stories(this.category, this.tag, this.query);

    void updateQuery(String query) {
      state.query = query;
      state.getData();
    }

    void scrollUp() {
      state.scrollUp();
    }

    @override
    StoriesState createState() => new StoriesState(this.category, this.tag, this.query, this);

}

class StoriesState extends State<Stories> {
  final webview = FlutterWebviewPlugin();
  Iterable<StoryModel> stories;
  ScrollController controller = new ScrollController();
 
  String category;
  String tag;
  String query;
  bool moreStories = true;

  int count = 10;

  StoriesState (String category, String tag, String query, Stories parent) {
    this.category = category;
    this.tag = tag;
    this.query = query; 
    parent.state = this;
  }

  @override
  void initState() {
    if (stories == null || stories.length == 0) {
      getData();
    }

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
    Iterable<StoryModel> stories = await new StoriesAPI().getData(category, tag, query, count);
    if (this.mounted) {
      this.setState(() {
        moreStories = stories.length == this.stories?.length;
        this.stories = stories;
      });
    }
  }

  void scrollUp() {
    controller.jumpTo(0.0);
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
          } else if (moreStories) {
            return new Loader();
          } else {
            return new Container();
          }
        },
      )
    );
  }
}