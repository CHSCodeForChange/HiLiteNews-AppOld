import 'package:flutter/widgets.dart';
import '../api/tags.dart';

class TagModel {
  String title;
  String slug;
  Image image;
  int count;

  TagModel(this.title, this.slug, this.count);


  TagModel.fromJson(Map<String, dynamic> json) {
    title = "#" + json['title'].toString().toUpperCase();
    slug = json['slug'];
    count = json['post_count'];
  }

  Future<void> fillImage() async {
    String url = await new TagsAPI().getImage(this);
    image = url != null ? Image.network(url, scale: 0.25) : null;
  }

  int getCountInt() {
    return count == null ? 0 : count;
  }

  String getCount() {
    return getCountInt().toString() + " Posts";
  }
}