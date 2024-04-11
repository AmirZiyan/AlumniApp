import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/alumni_login_page.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/auth_button.dart';
import 'package:firebase_services_with_bloc/features/alumni_home_screen/presentation/alumni_home_screen.dart';
import 'package:firebase_services_with_bloc/features/student/auth/student_login.dart';
import 'package:firebase_services_with_bloc/features/student_home/student_g_nav.dart';
import 'package:firebase_services_with_bloc/features/student_home/student_jobs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
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
              'Choose The Type of Student ',
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
                    :  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AlumniHomeScreen()), (route) => false); 
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
                    : Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>StudentGNav()), (route) => false);
              },
            )
          ],
        ),
      ).animate().fade(delay: 500.ms ,duration: 500.ms),
    );
  }
}
