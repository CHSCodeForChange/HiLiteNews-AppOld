import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api.dart';
import '../models/tag.dart';

class TagsAPI extends API {

  Future<Iterable<TagModel>> getData() async {
    String url = this.domain + '/?json=get_tag_index';
   
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
      }
    );

    List rawStories = json.decode(response.body)['tags'];
    return (rawStories).map((i) => new TagModel.fromJson(i));
  }

  Future<String> getImage(TagModel tag) async {
    String url = this.domain + '/?json=get_tag_posts&slug=' + tag.slug + '&count=1&page=1&include=thumbnail';

    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
      }
    );

    List rawStories = json.decode(response.body)['posts'];
    if (rawStories.length > 0 && rawStories[0]['thumbnail_images'] != null) {
      return rawStories[0]['thumbnail_images']['thumbnail']['url'];
    }
  }
}

