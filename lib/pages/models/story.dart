class StoryModel {
  final String title;
  final String date;
  final String image_url;
  final String excerpt;
  final String url;

  StoryModel(this.title, this.date, this.image_url, this.excerpt, this.url);

  StoryModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        date = json['date'],
        image_url = json['image_url'],
        excerpt = json['excerpt'],
        url = json['url'];


}