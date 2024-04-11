part of 'student_auth_bloc.dart';

sealed class StudentAuthState extends Equatable {
  const StudentAuthState();

  @override
  List<Object> get props => [];
}

final class StudentAuthInitial extends StudentAuthState {}

final class StudentSignUpSuccess extends StudentAuthState {}

final class StudentSignUpFailed extends StudentAuthState {}

final class StudentSignUpLoading extends StudentAuthState {}

final class StudentLoginLoading extends StudentAuthState {}

final class StudentLoadingError extends StudentAuthState {}

final class StudentLoginSuccess extends StudentAuthState {}
