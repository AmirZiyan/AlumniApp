import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_services_with_bloc/constant/size/sized.dart';
import 'package:firebase_services_with_bloc/features/admin_page/admin_page.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/auth_button.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login As Admin'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animation/admin.json',
                height: 300,
              ),
              const Height20(),
              CustomTextField(
                label: 'Email',
                controller: emailController,
              ),
              const Height20(),
              CustomTextField(
                label: 'Password',
                controller: passwordController,
              ),
              const Height20(),
              AuthButton(
                label: 'Login',
                callback: () async {
                  try{
                    await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                      .then(
                        (value) => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminPage()),
                            (route) => false),
                      );

                  }catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                 
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
