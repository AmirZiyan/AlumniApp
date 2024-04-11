import 'package:firebase_services_with_bloc/features/alumni_home_screen/presentation/alumni_home_screen.dart';
import 'package:firebase_services_with_bloc/features/fun_raising/fundraising.dart';
import 'package:flutter/material.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Center(
      child: Text('Profile'),
    );
  }
}

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AlumniCards(
            width: width,
            height: height,
            imagePath: 'assets/images/fund.png',
            label: 'Fund Raising',
            callback: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FundRaisingPage(),
                ),
              );
            },
          ),
          SizedBox(
            height: height * 0.1,
          ),
          AlumniCards(
            width: width,
            height: height,
            imagePath: 'assets/images/chat.png',
            label: 'Chats',
            callback: () {},
          ),
        ],
      ),
    );
  }
}
