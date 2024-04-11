part of 'alumni_auth_bloc.dart';

sealed class AlumniAuthEvent extends Equatable {
  const AlumniAuthEvent();

  @override
  List<Object> get props => [];
}

class AlumniAuthLoginEvent extends AlumniAuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  const AlumniAuthLoginEvent(
      {required this.email, required this.password, required this.context});
  @override
  List<Object> get props => [email, password, context];
}

class AlumniAuthSignUpEvent extends AlumniAuthEvent {
  final String name;
  final String email;
  final String password;
  final BuildContext context;
  const AlumniAuthSignUpEvent(this.name, this.context,
      {required this.email, required this.password});
  @override
  List<Object> get props => [email, password, name];
}
