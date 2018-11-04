import 'package:flutter/widgets.dart';

class VideoModel {

  String url;
  String title;
  String excerpt;
  Image image;
  DateTime date;

  VideoModel.fromJson(Map<String, dynamic> json) {
    title = json['snippet']['title'];
    excerpt = json['snippet']['description'];
    date = DateTime.parse(json['snippet']['publishedAt']);
    image =Image.network(json['snippet']['thumbnails']['medium']['url'], scale: .5, fit: BoxFit.fitWidth,);
    url = "https://www.youtube.com/watch?v=" + json['snippet']['resourceId']['videoId'];
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


  
}