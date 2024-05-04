// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

void main() {
  if (Platform.isAndroid) {
    // Execute Android-specific code
    print('Running on Android');
  } else if (Platform.isIOS) {
    // Execute iOS-specific code
    print('Running on iOS');
  } if (kIsWeb) {
    // Handle web-specific code
    print('Web platform detected');
  }
  else {
    // Handle unsupported platforms
    print('Unsupported platform');
  }
}


class PaymentGatewayPage extends StatefulWidget {
  const PaymentGatewayPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PaymentGatewayPageState createState() => _PaymentGatewayPageState();
}

class _PaymentGatewayPageState extends State<PaymentGatewayPage> {
  TextEditingController amount=new TextEditingController();
  Razorpay? _razorpay;
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Payment Success: ${response.paymentId}');
    print("success");
    // Handle payment success
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment Error: ${response.message}');
    print("success");
    // Handle payment error
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet: ${response.walletName}');
    print("success");
    // Handle external wallet
  }

  @override
  void initState() {
    super.initState();
    _razorpay=Razorpay();
     _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
     _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
     _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet );
  }

  void initiatePayment() async {
    int enteredAmount = int.tryParse(amount.text) ?? 0;
    print("payment");
    var options = {
      'key': 'rzp_test_TtSDhSH3AFn8Su',
      'amount': enteredAmount *100, // Payment amount in paisa (e.g., 10000 for ₹100)
      'name': 'Fisat',
      'description': 'Test Payment',
      'prefill': {'contact': '9876543210', 'email': 'test@example.com'},
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());

      // Handle payment error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Gateway'),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: amount,
              decoration: InputDecoration(labelText: "Enter the amount",border: OutlineInputBorder()),),
            Center(
              child: ElevatedButton(
                onPressed: initiatePayment,
                child: const Text('Pay Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}