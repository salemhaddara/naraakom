// ignore_for_file: camel_case_types,file_names

import 'dart:io';

import 'package:naraakom/config/httpRequests/httpHelper.dart';

class termsAndConditionsRepo {
  Future<Map<String, dynamic>> getTermsAndConditions() async {
    try {
      await Future.delayed(const Duration(seconds: 3), () {});
      return {
        'status': 'success',
        'data': {
          'time': '10/10/2022',
          'terms_and_conditions_ar':
              "هذا النص هو نموذج بسيط للنص يمكن أن يستخدم كتطبيق تجريبي في الترجمة. إنه ليس له معنى محدد، بل هو مجرد مثال للغة العربيهذا النص هو نموذج بسيط للنص يمكن أن يستخدم كتطبيق تجريبي في الترجمة. إنه ليس له معنى محدد، بل هو مجرد مثال للغة العربيهذا النص هو نموذج بسيط للنص يمكن أن يستخدم كتطبيق تجريبي في الترجمة. إنه ليس له معنى محدد، بل هو مجرد مثال للغة العربيهذا النص هو نموذج بسيط للنص يمكن أن يستخدم كتطبيق تجريبي في الترجمة. إنه ليس له معنى محدد، بل هو مجرد مثال للغة العربية.",
          'terms_and_conditions_en':
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'
        }
      };
    } on SocketException {
      return httpHelper.returnNetworkError();
    } catch (e) {
      return httpHelper.returnServerError();
    }
  }
}
