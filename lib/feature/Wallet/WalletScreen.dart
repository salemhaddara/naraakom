import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naraakom/config/localisation/translation.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/text400normal.dart';
import 'package:naraakom/core/widgets/text600normal.dart';
import 'package:naraakom/core/widgets/text700normal.dart';
import 'package:naraakom/feature/PaymentMethod/paymentmethod.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: white,
      body: Directionality(
          textDirection:
              defaultLang == 'en' ? TextDirection.ltr : TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.only(
              top: size.height * .05,
            ),
            child: Column(children: [
              _topbar(size),
              _Wallet(size),
              _title(language[defaultLang]['paymentmethods'], size),
              _addnewPaymentMethod(size)
            ]),
          )),
    );
  }

  _addnewPaymentMethod(Size size) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: cyan,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          builder: (BuildContext context) {
            return const PaymentMethodsBottomSheet();
          },
        );
      },
      child: Container(
        height: 30,
        width: size.width,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(16),
        child: Row(children: [
          Icon(
            Icons.add,
            color: cyan,
          ),
          text400normal(
              text: language[defaultLang]['addnewpaymentmethod'],
              color: cyan,
              fontsize: 16),
        ]),
      ),
    );
  }

  _Wallet(Size size) {
    return Container(
      height: size.height * 0.15,
      width: size.width,
      margin: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/Rectangle.png',
              fit: BoxFit.cover,
              height: size.height * 0.15,
              width: size.width,
            ),
            SvgPicture.asset(
              'assets/images/walletback.svg',
            ),
            Container(
              margin: const EdgeInsets.all(16),
              height: size.height * 0.15,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: text700normal(
                        text: ' QAR 8,456.00',
                        fontsize: 28,
                        color: white,
                        align: TextAlign.start,
                      )),
                  Expanded(
                      flex: 1,
                      child: text400normal(
                        text: language[defaultLang]['totalbalance'],
                        fontsize: 22,
                        color: white,
                        align: TextAlign.start,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _title(String text, Size size) {
    return Container(
        margin: const EdgeInsets.all(16),
        width: size.width,
        child: text700normal(text: text, fontsize: 20, color: darkblack));
  }

  _topbar(Size size) {
    return Material(
      elevation: 1,
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24))),
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                  color: Color(0xffF5F5F5),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Transform.rotate(
                angle: defaultLang == 'ar' ? 3.14159265 : 0,
                child: SvgPicture.asset(
                  'assets/images/back.svg',
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: text600normal(
              text: language[defaultLang]['Wallet'],
              fontsize: 20,
              color: lightblack,
            ),
          )
        ]),
      ),
    );
  }
}
