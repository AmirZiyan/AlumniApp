import 'package:firebase_services_with_bloc/constant/size/sized.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/action_button.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/auth_button.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/textfield.dart';
import 'package:firebase_services_with_bloc/features/student/auth/bloc/student_auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class StudentSignUp extends StatefulWidget {
  const StudentSignUp({super.key});

  @override
  State<StudentSignUp> createState() => _StudentSignUpPageState();
}

class _StudentSignUpPageState extends State<StudentSignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('assets/animation/signUp.json', height: 300),
              const Height20(),
              CustomTextField(
                label: 'Name',
                controller: nameController,
              ),
              const Height20(),
              CustomTextField(
                label: 'email',
                controller: emailController,
              ),
              const Height20(),
              CustomTextField(
                label: 'Password',
                controller: passwordController,
              ),
              const Height20(),
              AuthButton(
                label: 'SignUp',
                callback: () {
                  context.read<StudentAuthBloc>().add(
                        StudentAuthSignUpEvent(
      context: context,
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          name: nameController.text.trim(),
                        ),
                      );
                },
              ),
              const Height20(),
              AccountActionButton(
                  statusText: "Already have an account back to",
                  label: "Login",
                  callback: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
