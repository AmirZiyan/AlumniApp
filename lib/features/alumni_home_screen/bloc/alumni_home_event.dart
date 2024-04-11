part of 'alumni_home_bloc.dart';

sealed class AlumniHomeEvent extends Equatable {
  const AlumniHomeEvent();
  @override
  List<Object> get props => [];
}

class AlumniJobPostEvent extends AlumniHomeEvent {
  final BuildContext context;
    final String companyName;
  final String place;
  final String contactNumber;
  final String position;
  final String email;
  final String salary;
  const AlumniJobPostEvent(this.context, 
      {required this.companyName,
      required this.place,
      required this.contactNumber,
      required this.position,
      required this.email,
      required this.salary});
  @override
  List<Object> get props =>
      [companyName, place, contactNumber, position, email, salary];
}
