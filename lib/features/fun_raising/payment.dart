import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _showCardDetails = false;
  String _paymentMethod = '';

  TextEditingController _amountController = TextEditingController();
  TextEditingController _cardHolderNameController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _paymentMethod = 'Debit Card';
                    _showCardDetails = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Debit Card',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _paymentMethod = 'Credit Card';
                    _showCardDetails = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Credit Card',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              if (_showCardDetails) ...[
                TextField(
                  controller: _cardHolderNameController,
                  decoration: InputDecoration(
                    labelText: 'Card Holder Name',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _expiryDateController,
                        decoration: InputDecoration(
                          labelText: 'Expiry Date (MM/YYYY)',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _cvvController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'CVV',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Amount',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _submitPayment();
                  },
                  style: ElevatedButton.styleFrom(
                    
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Pay',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _submitPayment() {
    if (_amountController.text.isEmpty ||
        _cardHolderNameController.text.isEmpty ||
        _cardNumberController.text.isEmpty ||
        _expiryDateController.text.isEmpty ||
        _cvvController.text.isEmpty) {
      // Show an error message if any of the fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
    } else {
      // Display a confirmation message with the amount sent
      double amount = double.parse(_amountController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('\Rs$amount Sent Successfully')),
      );
      // Navigate back to the previous page
      Navigator.of(context).pop();
    }
  }
}