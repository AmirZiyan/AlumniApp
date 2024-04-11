import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_services_with_bloc/features/firebase_services/fire_base_api.dart';
import 'package:flutter/material.dart';
part 'alumni_auth_event.dart';
part 'alumni_auth_state.dart';

class AlumniAuthBloc extends Bloc<AlumniAuthEvent, AlumniAuthState> {
  AlumniAuthBloc() : super(AlumniAuthInitial()) {
    on<AlumniAuthLoginEvent>(_alumniAuthLoginEvent);
    on<AlumniAuthSignUpEvent>(_alumniAuthSignUpEvent);
  }
  // alumni log in
  FutureOr<void> _alumniAuthLoginEvent(
      AlumniAuthLoginEvent event, Emitter<AlumniAuthState> emit) async {
    emit(
      AlumniAuthLoading(),
    );
    try {
      await FirebaseApi.signInAlumni(event.email, event.password);
      emit(
        AlumniLoginSuccessState(),
      );
    } catch (error) {
      log(
        error.toString(),
      );
      emit(
        AlumniLoginFailedState(
          error: error.toString(),
        ),
      );
    }
  }

  // alumni sign up
  FutureOr<void> _alumniAuthSignUpEvent(
      AlumniAuthSignUpEvent event, Emitter<AlumniAuthState> emit) async {
    emit(
      AlumniAuthLoading(),
    );
    try {
      await FirebaseApi.signUpAlumni(
          event.email, event.password, event.name, event.context);
      emit(
        AlumniAuthSuccess(email: event.email),
      );
    } catch (error) {
      emit(
        AlumniAuthFailure(error: error.toString()),
      );
    }
  }
}
