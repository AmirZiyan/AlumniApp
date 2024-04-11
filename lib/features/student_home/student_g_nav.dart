import 'package:firebase_services_with_bloc/features/student/Student_profile/student_profile.dart';
import 'package:firebase_services_with_bloc/features/student_home/student_jobs_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class StudentGNav extends StatefulWidget {
  const StudentGNav({super.key});

  @override
  State<StudentGNav> createState() => _StudentGNavState();
}

class _StudentGNavState extends State<StudentGNav> {
  List<Widget> pages = [StudentHome(), StudentJobsPage(), StudentProfilePage()];
  @override
  int index = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: GNav(
          onTabChange: (value) {
            setState(() {
              index = value;
            });
          },
          selectedIndex: 0,
          tabs: [
            GButton(
              icon: Icons.home,
              text: ' Home',
            ),
            GButton(icon: Icons.work, text: ' Jobs'),
            GButton(icon: Icons.account_circle, text: ' Profile')
          ]),
    );
  }
}
