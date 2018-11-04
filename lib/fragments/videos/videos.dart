import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../api/videos.dart';
import '../../models/video.dart';
import '../../models/colors.dart';
import './video.dart';
import '../loader.dart';

class Videos extends StatefulWidget {
    final String category;
    Videos(this.category);


    @override
    VideosState createState() => new VideosState(this.category);

}

class VideosState extends State<Videos> {
  final webview = FlutterWebviewPlugin();
  Iterable<VideoModel> stories;
  ScrollController controller = new ScrollController();
 
  final String category;
  int count = 10;

  VideosState(this.category);


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
    Iterable<VideoModel> videos = await new VideosAPI().getData(category, count);
    this.setState(() {
      this.stories = videos;
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
            return new Video(stories.elementAt(index));
          } else {
            return new Loader();
          }
        },
      )
    );
  }
}