
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './models/story.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import './models/colors.dart';


class Story extends StatelessWidget { 
  final StoryModel story;
  Story(this.story);

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
        url: this.story.url,
        appBar: AppBar(
          title: Text(this.story.title),
          backgroundColor: MyColors.blue(),
        ),
        withJavascript: true,
        withLocalStorage: true,
        withZoom: true,
      );
  }
}

