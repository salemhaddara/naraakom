// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';

class category {
  String title_ar, title_en;
  int id, active;
  category(
      {required this.id,
      required this.title_ar,
      required this.title_en,
      required this.active});
  static List<category> parseCategories(String jsonString) {
    final Map<String, dynamic> data = json.decode(jsonString);
    final List<dynamic> categoriesData = data['data'];
    List<category> categories = [];

    try {
      for (var categoryData in categoriesData) {
        categories.add(
          category(
            id: categoryData['id'],
            title_ar: categoryData['title_ar'],
            title_en: categoryData['title_en'],
            active: categoryData['active'],
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    return categories;
  }
}
