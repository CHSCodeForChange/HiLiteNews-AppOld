import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api.dart';
import '../models/story.dart';

class StoriesAPI extends API {

  Future<Iterable<StoryModel>> getData(String category, int count) async {
    String url = this.domain + '/?json=get_recent_posts';
    if (category != null) {
      url = this.domain + '/?json=get_category_posts&slug=' + category;
    }

    url += '&count=' + count.toString() + '&page=1&include=posts,title,excerpt,thumbnail,url,date,custom_fields,tags,comment_count';

    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
      }
    );

    List rawStories = json.decode(response.body)['posts'];
    return (rawStories).map((i) => new StoryModel.fromJson(i));
  }
}
