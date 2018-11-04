import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api.dart';
import '../models/video.dart';

class VideosAPI extends API {

  static String nextPageToken;

  Future<Iterable<VideoModel>> getData(bool next_page) async {
    String url = youtube + 'playlistItems?part=snippet,contentDetails';

    if (next_page) {
      url += '&pageToken=' + nextPageToken;
    }
    
    url += '&playlistId=UU8K4aIVcOuVYArzo2EColaw&key=' + youtubeToken;

    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
      }
    );

    nextPageToken = json.decode(response.body)['nextPageToken'];

    List rawVideos = json.decode(response.body)['items'];
    return (rawVideos).map((i) => new VideoModel.fromJson(i));
  }
}

