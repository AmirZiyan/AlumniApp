import 'package:firebase_services_with_bloc/constant/size/sized.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/auth_button.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/textfield.dart';
import 'package:firebase_services_with_bloc/features/alumni_home_screen/bloc/alumni_home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostJObScreen extends StatefulWidget {
  const PostJObScreen({super.key});

  @override
  State<PostJObScreen> createState() => _PostJObScreenState();
}

class _PostJObScreenState extends State<PostJObScreen> {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  @override
  void dispose() {
    companyNameController.dispose();
    positionController.dispose();
    emailController.dispose();
    salaryController.dispose();
    locationController.dispose();
    contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    // final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post A Job'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            CustomTextField(
              label: 'Company Name',
              controller: companyNameController,
            ),
            const Height20(),
            CustomTextField(
              label: 'Position',
              controller: positionController,
            ),
            const Height20(),
            CustomTextField(
              label: 'Salary',
              controller: salaryController,
            ),
            const Height20(),
            CustomTextField(
              label: 'Email',
              controller: emailController,
            ),
            const Height20(),
            CustomTextField(
              label: 'Contact Number',
              controller: contactController,
            ),
            const Height20(),
            CustomTextField(
              label: 'Place',
              controller: locationController,
            ),
            const Height20(),
            AuthButton(
              label: 'Post',
              callback: () async {
                context.read<AlumniHomeBloc>().add(
                      AlumniJobPostEvent(
                        context,
                        companyName: companyNameController.text.trim(),
                        place: locationController.text.trim(),
                        contactNumber: contactController.text.trim(),
                        position: positionController.text.trim(),
                        email: emailController.text.trim(),
                        salary: salaryController.text.trim(),
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
