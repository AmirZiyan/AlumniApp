import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/auth_button.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';

class CreateTalksFromAdminn extends StatefulWidget {
  const CreateTalksFromAdminn({super.key});

  @override
  State<CreateTalksFromAdminn> createState() => _CreateTalksFromAdminnState();
}

class _CreateTalksFromAdminnState extends State<CreateTalksFromAdminn> {
  final batchController = TextEditingController();
  final dateController = TextEditingController();
  final venueController = TextEditingController();
  final timeController = TextEditingController();
  final tittleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create GetTogether '),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              label: 'Batch',
              controller: batchController,
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
              label: 'Venue',
              controller: venueController,
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
         
            const SizedBox(
              height: 20,
            ),
            AuthButton(
              label: 'Create GetTogether',
              callback: () async {
                await db
                    .collection('Get_together')
                    .add(
                      {
                        'batch': batchController.text,
                        'venue': venueController.text,
                       
                        'time': timeController.text,
                        'date': timeController.text
                      },
                    )
                    .then(
                      (value) => Navigator.pop(context),
                    )
                    .then(
                      (value) => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('get-together Created Successfully'),
                        ),
                      ),
                    );
              },
            )
          ],
        ),
      ),
    );
  }
}
