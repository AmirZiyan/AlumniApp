


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/auth_button.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';

class CreateGetTogether extends StatefulWidget {
  const CreateGetTogether({super.key});

  @override
  State<CreateGetTogether> createState() => _CreateGetTogetherState();
}

class _CreateGetTogetherState extends State<CreateGetTogether> {
  final batchController = TextEditingController();
    final dateController = TextEditingController();
      final timeController = TextEditingController();
      final venueController =TextEditingController();




  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: const Text('Create Talks '),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          CustomTextField(
            label: 'Batch',
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            label: 'Date',
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            label: 'Time',
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            label: 'Venue',
          ),
          const SizedBox(
            height: 20,
          ),
          
          AuthButton(
            label: 'Create Talks',
            callback: () async {
              await db
                  .collection('jobs')
                  .add(
                    {
                      // 'title': tittleController.text,
                      // 'description': descriptionController.text,
                      // 'speaker': speaksController.text,
                      // 'time': timeController.text,
                      // 'date': timeController.text
                    },
                  )
                  .then(
                    (value) => Navigator.pop(context),
                  )
                  .then(
                    (value) => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Talks Created Successfully'),
                      ),
                    ),
                  );
            },
          )
        ],
      ),
    );
  }
}