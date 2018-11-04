import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api.dart';
import '../models/section.dart';

class SectionsAPI extends API {

  Future<Iterable<SectionModel>> getData() async {
    String url = this.domain + '/?json=get_category_index';
   
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
      }
    );

    List rawStories = json.decode(response.body)['categories'];
    return (rawStories).map((i) => new SectionModel.fromJson(i));
  }

  Future<String> getImage(SectionModel section) async {
    String url = this.domain + '/?json=get_category_posts&slug=' + section.slug + '&count=1&page=1&include=thumbnail';

    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
      }
    );

    List rawStories = json.decode(response.body)['posts'];
    if (rawStories.length > 0 && rawStories[0]['thumbnail_images'] != null) {
      return rawStories[0]['thumbnail_images']['medium']['url'];
    }
  }
}

