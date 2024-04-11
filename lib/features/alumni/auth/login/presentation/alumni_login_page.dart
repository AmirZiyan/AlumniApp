import 'package:firebase_services_with_bloc/constant/size/sized.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/bloc/alumni_auth_bloc.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/action_button.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/auth_button.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/textfield.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/signup/presentation/alumni_sign_up.dart';
import 'package:firebase_services_with_bloc/features/alumni_home_screen/presentation/alumni_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class AlumniLoginPage extends StatefulWidget {
  const AlumniLoginPage({super.key});

  @override
  State<AlumniLoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<AlumniLoginPage> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login as Alumni'),
        centerTitle: true,
      ),
      body: BlocConsumer<AlumniAuthBloc, AlumniAuthState>(
        listener: (context, state) {
          if (state is AlumniLoginSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AlumniHomeScreen(),
              ),
            );
            
          }
        },
        builder: (context, state) {
          if (state is AlumniAuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animation/login.json',
                    height: 300,
                  ),
                  const Height20(),
                  CustomTextField(
                    controller: emailController,
                    label: 'Email',
                  ),
                  const Height20(),
                  CustomTextField(
                      controller: passwordController, label: 'Password'),
                  const Height20(),
                  AuthButton(
                    callback: () async {
                      context.read<AlumniAuthBloc>().add(
                            AlumniAuthLoginEvent(
                                email: emailController.text,
                                password: passwordController.text,
                                context: context),
                          );
                    },
                    label: 'Login',
                  ),
                  AccountActionButton(
                      callback: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AlumniSignUpPage(),
                          ),
                        );
                      },
                      statusText: "Don't Have An Account",
                      label: 'Sign Up'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
