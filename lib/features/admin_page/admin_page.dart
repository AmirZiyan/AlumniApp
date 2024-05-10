import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_services_with_bloc/features/admin_page/admin_job_page.dart';
import 'package:firebase_services_with_bloc/features/admin_page/booked_jobs/booked_jobes.dart';
import 'package:firebase_services_with_bloc/features/admin_page/create_get_togetherr.dart';
import 'package:firebase_services_with_bloc/features/admin_page/create_talks.dart';
import 'package:firebase_services_with_bloc/features/admin_page/funds/received_funds.dart';
import 'package:firebase_services_with_bloc/features/admin_page/getTogether_booked/booked_gettogether.dart';
import 'package:firebase_services_with_bloc/features/admin_page/talkes_booked/talks_booked_page.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/widgets/auth_button.dart';
import 'package:firebase_services_with_bloc/features/alumni_home_screen/presentation/alumni_home_screen.dart';
import 'package:firebase_services_with_bloc/features/alumni_post_job/post_job_scree.dart';
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
                          builder: (context) => const AppliedJobs(),
                        ),
                      );
                    },
                    height: height,
                    width: width,
                    imagePath: 'assets/images/jobs.png',
                    label: 'Applied Jobs')
                    ,AlumniCards(
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PostJObScreen(),
                        ),
                      );
                    },
                    height: height,
                    width: width,
                    imagePath: 'assets/images/post_job.png',
                    label: 'Post Jobs')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AlumniCards(
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateTalksFromAdmin(),
                        ),
                      );
                    },
                    height: height,
                    width: width,
                    imagePath: 'assets/images/talks.png',
                    label: 'Create Talks'),

                     AlumniCards(
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateTalksFromAdminn(),
                        ),
                      );
                    },
                    height: height,
                    width: width,
                    imagePath: 'assets/images/get_together.png',
                    label: 'Create GetTogether'),
          
              ],
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               
                          AlumniCards(
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReceivedFund(),
                        ),
                      );
                    },
                    height: height,
                    width: width,
                    imagePath: 'assets/images/fund.png',
                    label: 'Received Funds'), AlumniCards(
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TalksBookedPage(),
                        ),
                      );
                    },
                    height: height,
                    width: width,
                    imagePath: 'assets/images/booked_talks.png',
                    label: 'Booked Talks')
              ],
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               
                          AlumniCards(
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookedGetTogether(),
                        ),
                      );
                    },
                    height: height,
                    width: width,
                    imagePath: 'assets/images/booked_get.png',
                    label: 'Get-together'), 
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
                    imagePath: 'assets/images/view_jobs.png',
                    label: 'View Jobs'), 
              ],
            ),
            AuthButton(
              label: 'Logout',
              callback: () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StartPage(),
                    ),
                    (route) => false);
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
