import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../../api/videos.dart';
import '../../models/video.dart';
import '../../models/colors.dart';
import './video.dart';
import '../loader.dart';

class Videos extends StatefulWidget {
    @override
    VideosState createState() => new VideosState();
}

class VideosState extends State<Videos> {
  final webview = FlutterWebviewPlugin();
  List<VideoModel> videos = [];
  ScrollController controller = new ScrollController();
 
  @override
  void initState() {
    print("starting");
    
    this.getData(false);

    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        getData(true);
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

  Future<void> getData(bool next_page) async {
    Iterable<VideoModel> videos = await new VideosAPI().getData(next_page);
    this.setState(() {
      this.videos.addAll(videos);
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Material(
      color: MyColors.offWhite(),
      child: ListView.builder(
        itemCount: videos == null ? 1 : videos.length + 1,
        controller: controller,
        itemBuilder: (BuildContext context, int index) {
          if (index < (videos == null ? 0  : videos.length)) {
            return new Video(videos.elementAt(index));
          } else {
            return new Loader();
          }
        },
      )
    );
  }
}