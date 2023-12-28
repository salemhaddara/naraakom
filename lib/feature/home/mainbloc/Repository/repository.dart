// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:naraakom/config/httpRequests/httpHelper.dart';
import 'package:naraakom/core/utils/Constants/Backend.dart';
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

import 'package:naraakom/core/utils/Models/category.dart';

class Repository {
  Future<Map<String, dynamic>> fetchConsultants() async {
    List<ConsultantModel> consultants = [];
    try {
      var response = await http.post(Uri.parse(apiDoctors),
          headers: await httpHelper.getHeaderwithToken());
      print(response.body);
      consultants.addAll(ConsultantModel.parseConsultantModels(response.body));
      print('no error in it');
      return {'status': 'success', 'data': consultants};
    } on SocketException {
      return httpHelper.returnNetworkError();
    } catch (e) {
      return httpHelper.returnServerError();
    }
  }

  Future<Map<String, dynamic>> fetchCategories() async {
    List<category> categories = [];
    try {
      var response = await http.get(Uri.parse(apiSpecialists),
          headers: await httpHelper.getHeaderwithToken());
      categories.addAll(category.parseCategories(response.body));
      return {'status': 'success', 'data': categories};
    } on SocketException {
      return httpHelper.returnNetworkError();
    } catch (e) {
      return httpHelper.returnServerError();
    }
  }
}
