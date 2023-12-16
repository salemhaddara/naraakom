// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:naraakom/config/httpRequests/httpHelper.dart';
import 'package:naraakom/core/utils/Constants/Backend.dart';
import 'package:naraakom/core/utils/Models/ConsultantModel.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

class Repository {
  Future<Map<String, dynamic>> fetchConsultants() async {
    List<ConsultantModel> consultants = [];
    try {
      var response = await http.post(Uri.parse(apiDoctors),
          headers: await httpHelper.getHeaderwithToken());
      consultants.addAll(ConsultantModel.parseConsultantModels(response.body));

      return {'status': 'success', 'data': consultants};
    } on SocketException {
      return httpHelper.returnNetworkError();
    } catch (e) {
      return httpHelper.returnServerError();
    }
  }
}
