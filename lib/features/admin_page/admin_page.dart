import 'package:firebase_services_with_bloc/features/admin_page/admin_job_page.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/auth_button.dart';
import 'package:firebase_services_with_bloc/features/alumni_home_screen/presentation/alumni_home_screen.dart';
import 'package:firebase_services_with_bloc/features/start_up_page/start_page.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AlumniCards(
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminJobPage(),
                        ),
                      );
                    },
                    height: height,
                    width: width,
                    imagePath: 'assets/images/jobs.png',
                    label: 'Jobs'),
                AlumniCards(
                    height: height,
                    width: width,
                    imagePath: 'assets/images/fund.png',
                    label: 'Fund Raising')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AlumniCards(
                    height: height,
                    width: width,
                    imagePath: 'assets/images/talks.png',
                    label: 'Talks'),
                AlumniCards(
                    height: height,
                    width: width,
                    imagePath: 'assets/images/sponsor.png',
                    label: 'SponsorShip')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AlumniCards(
                    height: height,
                    width: width,
                    imagePath: 'assets/images/chat.png',
                    label: 'Chats'),
                AlumniCards(
                    height: height,
                    width: width,
                    imagePath: 'assets/images/get_together.png',
                    label: 'GetTogether')
              ],
            ),
            AuthButton(
              label: 'Logout',
              callback: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StartPage(),
                    ),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
