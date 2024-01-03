// ignore_for_file: file_names

abstract class PaymentMethod {
  String paymentName;
  String paymentHolderName;

  PaymentMethod({required this.paymentName, required this.paymentHolderName});
}

class Paypal extends PaymentMethod {
  String email;

  Paypal({
    required this.email,
    required String paymentName,
    required String paymentHolderName,
  }) : super(
          paymentName: paymentName,
          paymentHolderName: paymentHolderName,
        );
}

class QNB extends PaymentMethod {
  String cardNumber, expiryDate;

  QNB({
    required this.cardNumber,
    required String paymentName,
    required String paymentHolderName,
    required this.expiryDate,
  }) : super(
          paymentName: paymentName,
          paymentHolderName: paymentHolderName,
        );
}

class QIB extends PaymentMethod {
  String cardNumber, expiryDate;

  QIB({
    required this.cardNumber,
    required String paymentName,
    required String paymentHolderName,
    required this.expiryDate,
  }) : super(
          paymentName: paymentName,
          paymentHolderName: paymentHolderName,
        );
}
