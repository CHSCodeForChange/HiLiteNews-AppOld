import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter/widgets.dart';

import 'tag.dart';

class StoryModel {
  String title;
  DateTime date;
  Image image;
  String excerpt;
  String url;
  String author;
  TagModel topTag;
  int comments;


  StoryModel(this.title, this.date, this.image, this.excerpt, this.url);

  StoryModel.fromJson(Map<String, dynamic> json) {
    title = html2md.convert(json['title']).replaceAll(new RegExp(r'\\'), '');
    date = DateTime.parse(json['date']);
    image = json['thumbnail_images'] == null ? null : Image.network(json['thumbnail_images']['medium']['url'], scale: .5, fit: BoxFit.fitWidth,);
    excerpt = html2md.convert(json['excerpt']);
    url = json['url'];
    author = json['custom_fields']['writer'] != null ? json['custom_fields']['writer'][0] : "";

    if (json['tags'] != null && json['tags'].length > 0) {
      int topIndex = -1;
      int topCount = 0;
      for (int i = 0; i < json['tags'].length; i++) {
        int count = json['tags'][i]['post_count'];
        if (count > topCount) {
          topCount = count;
          topIndex = i;
        }
      }
      topTag = TagModel.fromJson(json['tags'][topIndex]);
    } 


    comments = json['comment_count'] == null ? 0 : json['comment_count'];
  }

  String getTimeDiff () {
    Duration diff = DateTime.now().difference(date);
    if (diff.inSeconds < 60) {
      return diff.inSeconds.toString() + (diff.inSeconds > 1 ? " Seconds Ago" : " Second Ago");
    } else if (diff.inMinutes < 60) {
      return diff.inMinutes.toString() + (diff.inMinutes > 1 ? " Minutes Ago" : " Minute Ago");
    } else if (diff.inHours < 24) {
      return diff.inHours.toString() + (diff.inHours > 1 ? " Hours Ago" : " Hour Ago");
    } else if (DateTime.now().month - date.month < 1) {
      return diff.inDays.toString() + (diff.inDays > 1 ? " Days Ago" : " Day Ago");
    } else if (DateTime.now().year - date.year < 1) { 
      return (DateTime.now().month - date.month).toString() + ((DateTime.now().month - date.month) > 1 ? " Months Ago" : " Month Ago");
    } else {
      return (DateTime.now().year - date.year).toString() + ((DateTime.now().year - date.year) > 1 ? " Years Ago" : " Year Ago");
    }
  }

  bool isExcerptNull() {
    return excerpt == null || excerpt == "";
  }

  bool isTagNull() {
    return topTag == null;
  }

  String getAuthor() {
    return author != null && author != "" ? author : "";
  }

  String getInfo() {
    return getTimeDiff() + " • By " + getAuthor();
  }
}