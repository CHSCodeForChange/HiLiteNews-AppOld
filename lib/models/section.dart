import 'package:flutter/widgets.dart';
import '../api/sections.dart';

class SectionModel {
  String title;
  String slug;
  Image image;
  String url;
  int count;

  SectionModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    count = json['count'];
  }

  Future<void> fillImage() async {
    url = await new SectionsAPI().getImage(this);
    image = url != null ? Image.network(url, scale: 0.25,) : null;
  }

  int getCountInt() {
    return count != null ? count : 0;
  }

  String getCount() {
    return getCountInt().toString() + " Posts";
  }
}