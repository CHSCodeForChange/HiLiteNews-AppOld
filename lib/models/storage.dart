
// import 'package:shared_preferences/shared_preferences.dart';

// class Storage {

//   Future<SharedPreferences> getPrefs() async {
//     return await SharedPreferences.getInstance();
//   }
  
//   void storeCategories(List<String> slugs) async {
//     final prefs = await getPrefs();
//     prefs.setStringList('categories', slugs);
//   }

//   void storeTags(List<String> slugs) async {
//     final prefs = await getPrefs();
//     prefs.setStringList('tags', slugs);
//   }

//   Future<<List<String>> getCategories() async {
//     final prefs = await getPrefs();
//     return prefs.getStringList('categories');
//   }
  
//   Future<<List<String>> getTags() async {
//     final prefs = await getPrefs();
//     return prefs.getStringList('categories');
//   }

// }