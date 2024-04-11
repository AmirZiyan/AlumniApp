import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'alumni_home_event.dart';
part 'alumni_home_state.dart';

class AlumniHomeBloc extends Bloc<AlumniHomeEvent, AlumniHomeState> {
  AlumniHomeBloc() : super(AlumniHomeInitial()) {
    on<AlumniJobPostEvent>(_alumniJobPostEvent);
  }

  FutureOr<void> _alumniJobPostEvent(
      AlumniJobPostEvent event, Emitter<AlumniHomeState> emit) async {
    BuildContext context = event.context;
    final db = FirebaseFirestore.instance;
    try {
      await db
          .collection('jobs')
          .add(
            {
              "company_name": event.companyName,
              "position": event.position,
              'email': event.email,
              'salary': event.salary,
              'place': event.place,
              'contact_number': event.contactNumber,
              'posted_by': FirebaseAuth.instance.currentUser!.email
            },
          )
          .then((value) => emit(
                JobPostSuccessState(),
              ))
          .then((value) => Navigator.pop(context))
          .then(
            (value) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Job Posted SuccessFully'),
              ),
            ),
          );
    } catch (error) {
      emit(
        JobPostErrorState(),
      );
    }
  }
}
