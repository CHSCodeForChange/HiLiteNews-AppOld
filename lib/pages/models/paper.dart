

class PaperModel {
  final String name;
  final String school;
  final String description;
  final String city;
  final String state;
  final String website;

  PaperModel(this.name, this.school, this.description, this.city, this.state, this.website);

  PaperModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        school = json['school'],
        description = json['description'],
        city = json['city'],
        state = json['state'],
        website = json['website'];



  Map<String, dynamic> toJson() =>
    {
      'name': name,
      'school': school,
      'description': description,
      'city': city,
      'state': state,
      'website': website,
    };
}