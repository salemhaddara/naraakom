// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';

class department {
  String title_en, title_ar;
  int active, id, doctor_id, department_id;
  department({
    required this.title_en,
    required this.title_ar,
    required this.active,
    required this.id,
    required this.doctor_id,
    required this.department_id,
  });

  static List<department> parseDepartments(String jsonData) {
    final parsedData = json.decode(jsonData);
    final List<dynamic> departmentData = parsedData['data'];

    List<department> departments = [];

    for (var entry in departmentData) {
      List<dynamic> departmentList = entry['departments'];

      for (var dept in departmentList) {
        department department_item = department(
          title_en: dept['title_en'],
          title_ar: dept['title_ar'],
          active: dept['active'],
          id: dept['id'],
          doctor_id: dept['doctor_id'],
          department_id: dept['department_id'],
        );
        departments.add(department_item);
      }
    }

    return departments;
  }
}
