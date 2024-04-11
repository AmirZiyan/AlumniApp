


import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  const CustomTextField({super.key, required this.label,  this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            label: Text(label),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
