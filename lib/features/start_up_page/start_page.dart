import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_services_with_bloc/constant/size/sized.dart';
import 'package:firebase_services_with_bloc/features/admin_page/admin_page.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/alumni_login_page.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/auth_button.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/textfield.dart';
import 'package:firebase_services_with_bloc/features/alumni_home_screen/presentation/alumni_home_screen.dart';
import 'package:firebase_services_with_bloc/features/student/auth/student_login.dart';
import 'package:firebase_services_with_bloc/features/student_home/student_g_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class StartPage extends StatelessWidget {
  final securityCode = '2662';
  const StartPage({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController codeController = TextEditingController();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animation/campus.json'),
            Text(
              'Welcome Back',
              style: TextStyle(
                  fontSize: width * 0.07, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              'Choose The Type of Account ',
              style: TextStyle(fontSize: width * 0.04),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            AuthButton(
              label: "Alumni",
              callback: () {
                (FirebaseAuth.instance.currentUser == null)
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AlumniLoginPage(),
                        ),
                      )
                    : Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AlumniHomeScreen(),
                        ),
                        (route) => false);
              },
            ),
            SizedBox(
              height: height * 0.03,
            ),
            AuthButton(
              label: "Student",
              callback: () {
                (FirebaseAuth.instance.currentUser == null)
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StudentLoginPage(),
                        ),
                      )
                    : Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StudentGNav(),
                        ),
                        (route) => false);
              },
            ),
            const Height20(),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Material(
                    child: Center(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: height * 0.3,
                          width: width * 0.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Please Enter Your Security Code'),
                              const Height20(),
                              CustomTextField(
                                controller: codeController,
                                label: 'Security code',
                              ),
                              const Height20(),
                              AuthButton(
                                label: 'Login As admin',
                                callback: () {
                                  if (codeController.text.trim() == '2662') {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AdminPage(),
                                        ),
                                        (route) => false);
                                  } else {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Incorrect Security Code'),
                                      ),
                                    );
                                  }
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Tap Here To Go Back'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Login As Admin'),
            )
          ],
        ),
      ).animate().fade(delay: 500.ms, duration: 500.ms),
    );
  }
}
