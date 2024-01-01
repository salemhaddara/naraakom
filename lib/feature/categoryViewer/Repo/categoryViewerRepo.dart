// ignore_for_file: camel_case_types,file_names

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:naraakom/config/httpRequests/httpHelper.dart';
import 'package:naraakom/core/utils/Constants/Backend.dart';

class categoryViewerRepo {
  Future<Map<String, dynamic>> getConsultantsWithThisId(
      int specialistId) async {
    try {
      var response = await http.post(Uri.parse(apispecialistListDoctors),
          body: json.encode(
            {'specialist_id': specialistId},
          ),
          headers: await httpHelper.getHeaderwithToken());
      print(response.body);
      return json.decode(response.body);
    } on SocketException {
      return httpHelper.returnNetworkError();
    } catch (e) {
      return httpHelper.returnServerError();
    }
  }
}
