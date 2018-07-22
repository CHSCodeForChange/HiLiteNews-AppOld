import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter/widgets.dart';

class StoryModel {
  final String title;
  final String date;
  final Image image;
  final String excerpt;
  final String url;


  StoryModel(this.title, this.date, this.image, this.excerpt, this.url);

  StoryModel.fromJson(Map<String, dynamic> json)
      : title = html2md.convert(json['title']),
        date = json['modified'],
        image = json['thumbnail_images'] == null ? null : Image.network(json['thumbnail_images']['medium']['url']),
        excerpt = html2md.convert(json['excerpt']),
        url = json['url'];


}