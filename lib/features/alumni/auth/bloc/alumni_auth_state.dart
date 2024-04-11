part of 'alumni_auth_bloc.dart';

sealed class AlumniAuthState extends Equatable {
  const AlumniAuthState();

  @override
  List<Object> get props => [];
}

final class AlumniAuthInitial extends AlumniAuthState {}

class AlumniAuthLoading extends AlumniAuthState {}

class AlumniAuthSuccess extends AlumniAuthState {
  final String email;

  const AlumniAuthSuccess({required this.email});
}

class AlumniAuthFailure extends AlumniAuthState {
  final String error;
  const AlumniAuthFailure({required this.error});
}

class AlumniLoginFailedState extends AlumniAuthState {
  final String error;

  const AlumniLoginFailedState({required this.error});
}

class AlumniLoginSuccessState extends AlumniAuthState {}
