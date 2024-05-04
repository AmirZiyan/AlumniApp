import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_slide_to_act/gradient_slide_to_act.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AlumniViewSponsor extends StatefulWidget {
  const AlumniViewSponsor({super.key});

  @override
  State<AlumniViewSponsor> createState() => _AlumniViewSponsorState();
}

class _AlumniViewSponsorState extends State<AlumniViewSponsor> {
  Razorpay? _razorpay;
  TextEditingController fundamount =new TextEditingController();
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
    // TODO: implement initState
    super.initState();
    _razorpay=Razorpay();
     _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
     _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
     _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet );
  }

  void initiatePayment() async {
    int enteredAmount = int.tryParse(fundamount.text) ?? 0;
    print("payemnt");
    var options = {
      'key': 'rzp_test_TtSDhSH3AFn8Su',
      'amount':enteredAmount *100, // Payment amount in paisa (e.g., 10000 for ₹100)
      'name': 'Merchant Name',
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
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SponsorShip Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('sponsor').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Student Name :${data['name']}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Class :${data['class']}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Place :${data['place']}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Mark :${data['mark']}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Account no: :${data['ac_no']}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'Contact Number:${data['contact_number']}'),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                      showBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            color: Colors.transparent,
                                            height: height * 0.6,
                                            width: width,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(20.0),
                                                  child: TextField(
                                                    controller: fundamount, // Assign the controller here
                                                    decoration: InputDecoration(
                                                      hintText: 'Enter Amount',
                                                      border: OutlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.8,
                                                  child: GradientSlideToAct(
                                                    width: width * 0.8,
                                                    textStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                    backgroundColor: const Color(0Xff172663),
                                                    onSubmit: () {
                                                      initiatePayment(); // Pass the entered amount here
                                                    },
                                                    gradient: const LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                      colors: [
                                                        Color(0xff0da6c2),
                                                        Color(0xff0E39C6),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.1,
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );

                                      },
                                      child: const Text('Sponsor Now'),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text('Call Student'),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Expanded(
                    child: Center(
                      child: Text('No Data'),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
