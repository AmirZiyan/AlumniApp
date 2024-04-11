import 'dart:async';

import 'package:firebase_services_with_bloc/constant/size/sized.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/bloc/alumni_auth_bloc.dart';
import 'package:firebase_services_with_bloc/features/alumni/auth/login/presentation/alumni_login_page.dart';
import 'package:firebase_services_with_bloc/features/start_up_page/start_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        FadePageRoute(builder: (context)=> StartPage(), nextPage: StartPage())
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animation/girl.json'),
          const Height20(),
          Text(
            'Campus Connect',
            style: GoogleFonts.blackOpsOne(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.deepOrange[300])
          ).animate(
            
          ).fade(delay: 500.ms,duration:500.ms)
        ],
      ),
    );
  }
}






class FadePageRoute extends PageRouteBuilder {
  final WidgetBuilder builder ;
  final Widget nextPage;

  FadePageRoute({required this.builder,required this.nextPage})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 3.0;
            const curve = Curves.bounceIn;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );
            var opacityAnimation = animation.drive(tween);
            return FadeTransition(
              opacity: opacityAnimation,
              child: nextPage,
            );
          },
        );
}