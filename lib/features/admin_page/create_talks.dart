import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/auth_button.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';

class CreateTalksFromAdmin extends StatefulWidget {
  const CreateTalksFromAdmin({super.key});

  @override
  State<CreateTalksFromAdmin> createState() => _CreateTalksFromAdminState();
}

class _CreateTalksFromAdminState extends State<CreateTalksFromAdmin> {
  final speaksController = TextEditingController();
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();
  final tittleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Talks '),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          CustomTextField(
            label: 'Speaker',
            controller: speaksController,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            label: 'Date',
            controller: dateController,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            label: 'Description',
            controller: descriptionController,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            label: 'Time',
            controller: timeController,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            label: 'Tittle',
            controller: tittleController,
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
                      'title': tittleController.text,
                      'description': descriptionController.text,
                      'speaker': speaksController.text,
                      'time': timeController.text,
                      'date': timeController.text
                    },
                  )
                  .then((value) => Navigator.pop(context))
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
