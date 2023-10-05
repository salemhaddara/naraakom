import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/button.dart';
import 'package:naraakom/core/widgets/inputfield.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';

class PaymentMethodsBottomSheet extends StatefulWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  _PaymentMethodsBottomSheetState createState() =>
      _PaymentMethodsBottomSheetState();
}

class _PaymentMethodsBottomSheetState extends State<PaymentMethodsBottomSheet> {
  String selectedPaymentMethod = "QNB";

  void _onPaymentMethodSelected(String method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  Widget _buildPaymentMethodTile(String method, String imageUrl) {
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
                text600normal(text: 'Add New Card', fontsize: 16, color: white),
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

class PaymentMethodForm extends StatelessWidget {
  final String paymentMethod;
  final VoidCallback onCancel;

  const PaymentMethodForm(
      {super.key, required this.paymentMethod, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text400normal(text: 'Card Number', color: darkblack, fontsize: 14),
          const SizedBox(height: 16),
          InputField(
            hint: '1234 5678 9101 1121',
            isPassword: false,
            initialState: false,
            validator: (text) {
              return null;
            },
            onChanged: (text) {},
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.bottomStart,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: text400normal(
                          text: 'MM/YYYY', color: darkblack, fontsize: 14),
                    ),
                    InputField(
                        isPassword: false,
                        hint: '00/000',
                        initialState: false,
                        validator: (validator) {
                          return null;
                        },
                        onChanged: (onChanged) {})
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: AlignmentDirectional.bottomStart,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: text400normal(
                          text: 'CCV', color: darkblack, fontsize: 14),
                    ),
                    InputField(
                        isPassword: false,
                        hint: '000',
                        initialState: false,
                        validator: (validator) {
                          return null;
                        },
                        onChanged: (onChanged) {})
                  ],
                ),
              ),
            ],
          ),
          Container(
            alignment: AlignmentDirectional.bottomStart,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: text400normal(
                text: 'Card Holder Name', color: darkblack, fontsize: 14),
          ),
          InputField(
            hint: 'Card Holder Name',
            isPassword: false,
            initialState: false,
            validator: (text) {
              return null;
            },
            onChanged: (text) {},
          ),
          const SizedBox(height: 16),
          button(
              text: 'Add New Card',
              width: MediaQuery.of(context).size.width,
              onTap: () {}),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

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
                text: 'Paypal Account Email', color: darkblack, fontsize: 14),
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
              text: 'Pay With PayPal ',
              width: MediaQuery.of(context).size.width,
              onTap: () {}),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
