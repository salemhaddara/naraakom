import 'package:flutter/widgets.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/button.dart';
import 'package:naraakom/core/widgets/inputfield.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/feature/splash/splash.dart';

class PayPalPaymentMethodForm extends StatelessWidget {
  final VoidCallback onCancel;

  const PayPalPaymentMethodForm({super.key, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: AlignmentDirectional.bottomStart,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: text400normal(
                text: language[defaultLang]['paypalaccountemail'],
                color: darkblack,
                fontsize: 14),
          ),
          InputField(
            hint: '',
            isPassword: false,
            initialState: false,
            validator: (text) {
              return null;
            },
            onChanged: (text) {},
          ),
          const SizedBox(height: 16),
          button(
              text: language[defaultLang]['paywithpaypal'],
              width: MediaQuery.of(context).size.width,
              onTap: () {}),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
