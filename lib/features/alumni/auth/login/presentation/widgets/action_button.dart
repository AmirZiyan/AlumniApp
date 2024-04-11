




import 'package:flutter/material.dart';

class AccountActionButton extends StatelessWidget {
 final String label;
 final String statusText;
 final VoidCallback callback;

  const AccountActionButton({super.key,required this.statusText,required this.label, required this.callback});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
    
     [
      Text(statusText), TextButton(onPressed:callback, child: Text(label))
    ],);
  }
}