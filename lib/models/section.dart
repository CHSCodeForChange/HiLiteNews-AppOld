import 'package:flutter/widgets.dart';
import '../api/sections.dart';

class SectionModel {
  String title;
  String slug;
  Image image;
  int count;

  SectionModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    count = json['count'];
  }

  Future<void> fillImage() async {
    String url = await new SectionsAPI().getImage(this);
    image = url != null ? Image.network(url) : null;
  }
}