import 'package:firebase_services_with_bloc/constant/size/sized.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/bloc/alumni_auth_bloc.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/action_button.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/auth_button.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class AlumniSignUpPage extends StatefulWidget {
  const AlumniSignUpPage({super.key});
  @override
  State<AlumniSignUpPage> createState() => _AlumniSignUpPageState();
}

class _AlumniSignUpPageState extends State<AlumniSignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AlumniAuthBloc, AlumniAuthState>(
        listener: (context, state) {
          if (state is AlumniAuthSuccess) {
            
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                content: Text('User Created Successfully for ${state.email}'),
              ),
             
            );
             Navigator.pop(context);
          }
        else if (state is AlumniAuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AlumniAuthLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return Center(
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
                    callback: () async {
                      context.read<AlumniAuthBloc>().add(
                            AlumniAuthSignUpEvent(
                              nameController.text.trim(),
                              context,
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
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
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
