import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_services_with_bloc/features/student_home/student_g_nav.dart';
import 'package:flutter/material.dart';
part 'student_auth_event.dart';
part 'student_auth_state.dart';

class StudentAuthBloc extends Bloc<StudentAuthEvent, StudentAuthState> {
  final auth = FirebaseAuth.instance;

  StudentAuthBloc() : super(StudentAuthInitial()) {
    on<StudentAuthSignUpEvent>(_studentAuthSignUpEvent);
    on<StudentAuthLoginEvent>(_studentAuthLoginEvent);
  }

  FutureOr<void> _studentAuthSignUpEvent(
      StudentAuthSignUpEvent event, Emitter<StudentAuthState> emit) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: event.email, password: event.password)
          .then(
            (value) => auth.signOut().then(
                  (value) => ScaffoldMessenger.of(event.context).showSnackBar(
                    SnackBar(
                      content: Text('Student Data Created With ${event.email}'),
                    ),
                  ),
                ),
          )
          .then((value) => Navigator.pop(event.context));
    } catch (error) {
      ScaffoldMessenger.of(event.context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );
    }
  }

  FutureOr<void> _studentAuthLoginEvent(
      StudentAuthLoginEvent event, Emitter<StudentAuthState> emit) async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: event.email, password: event.password)
          .then(
            (value) => Navigator.pushAndRemoveUntil(
                event.context,
                MaterialPageRoute(
                  builder: (context) => const StudentGNav(),
                ),
                (route) => false),
          );
    } catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }
}
