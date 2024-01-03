// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/core/utils/Models/PaymentMethod.dart';
import 'package:naraakom/feature/booking/PaymentMethod/paymentComponents/PayPalPaymentMethodForm.dart';
import 'package:naraakom/feature/booking/PaymentMethod/paymentComponents/PaymentMethodForm.dart';
import 'package:naraakom/feature/splash/splash.dart';
import 'package:naraakom/config/theme/colors.dart';

import 'package:naraakom/core/widgets/text600normal.dart';

class PaymentMethodsBottomSheet extends StatefulWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  _PaymentMethodsBottomSheetState createState() =>
      _PaymentMethodsBottomSheetState();
}

class _PaymentMethodsBottomSheetState extends State<PaymentMethodsBottomSheet> {
  String selectedPaymentMethod = "QNB";
  PaymentMethod? paymentMethod;
  void _onPaymentMethodSelected(String method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  _buildPaymentMethodTile(String method, String imageUrl) {
    final isSelected = selectedPaymentMethod == method;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _onPaymentMethodSelected(method);
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
              color: white,
              border: Border.all(
                color: isSelected ? cyan : homebackgrey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: SvgPicture.asset('assets/images/$imageUrl.svg'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.all(Radius.circular(14))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: cyan,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14))),
              child: Row(children: [
                text600normal(
                    text: language[defaultLang]['addnewcard'],
                    fontsize: 16,
                    color: white),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset('assets/images/exit.svg'))
              ]),
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildPaymentMethodTile('QNB', 'qnb'),
                  _buildPaymentMethodTile('QIB', 'qib'),
                  _buildPaymentMethodTile('PayPal', 'paypal'),
                ],
              ),
            ),
            const Divider(),
            if (selectedPaymentMethod == 'QNB' ||
                selectedPaymentMethod == 'QIB')
              PaymentMethodForm(
                paymentMethod: selectedPaymentMethod,
                onCancel: () {
                  setState(() {
                    selectedPaymentMethod = "";
                  });
                },
              ),
            if (selectedPaymentMethod == 'PayPal')
              PayPalPaymentMethodForm(
                onCancel: () {
                  setState(() {
                    selectedPaymentMethod = "";
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
