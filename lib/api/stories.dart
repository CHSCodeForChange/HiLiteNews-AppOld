import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api.dart';
import '../models/story.dart';

class StoriesAPI extends API {

  Future<Iterable<StoryModel>> getData(String category, String tag, String query, int page) async {
    String url = this.domain + '/?json=get_recent_posts';

    if (category != null) {
      url = this.domain + '/?json=get_category_posts&slug=' + category;
    } else if (tag != null) {
      url = this.domain + '/?json=get_tag_posts&slug=' + tag;
    } else if (query != null) {
      url = this.domain + '/?json=get_search_results&search=' + query;
    }

    url += '&count=10&page=' + page.toString() + '&include=posts,title,excerpt,thumbnail,url,date,custom_fields,tags,comment_count';

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

