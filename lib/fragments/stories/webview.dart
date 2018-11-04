import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../models/story.dart';
import '../../models/colors.dart';

class Webview extends StatelessWidget { 
  final StoryModel story;
  Webview(this.story);

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
        url: this.story.url,
        appBar: AppBar(
          title: Text(this.story.title),
          backgroundColor: MyColors.blue(),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.share),
              tooltip: 'Share',
              onPressed: () {
                Share.share(story.url);
              },
            ),
          ]
        ),
        withJavascript: true,
        withLocalStorage: true,
        withZoom: true,
      );
  }
}

