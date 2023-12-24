// ignore_for_file: camel_case_types,file_names

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:naraakom/config/httpRequests/httpHelper.dart';
import 'package:naraakom/core/utils/Constants/Backend.dart';

class termsAndConditionsRepo {
  Future<Map<String, dynamic>> getTermsAndConditions() async {
    try {
      var response = await http.post(Uri.parse(apimobilePrivacyPolicy),
          headers: await httpHelper.getHeaderwithToken());
      print(json.decode(response.body));
      return json.decode(response.body);
    } on SocketException {
      print('Socket exception');
      return httpHelper.returnNetworkError();
    } catch (e) {
      print('$e exception');

      return httpHelper.returnServerError();
    }
  }
}
