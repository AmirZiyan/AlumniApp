part of 'student_auth_bloc.dart';

sealed class StudentAuthEvent extends Equatable {
  const StudentAuthEvent();
  @override
  List<Object> get props => [];
}

class StudentAuthLoginEvent extends StudentAuthEvent {
  final String email;
  final String password;
  final BuildContext context;
  const StudentAuthLoginEvent(
      {required this.email, required this.password, required this.context});
  @override
  List<Object> get props => [email, password, context];
}

class StudentAuthSignUpEvent extends StudentAuthEvent {
  final BuildContext context;
  final String email;
  final String password;
  final String name;
  const StudentAuthSignUpEvent(
      {required this.email,
      required this.password,
      required this.name,
      required this.context});
  @override
  List<Object> get props => [email, password, name, context];
}
