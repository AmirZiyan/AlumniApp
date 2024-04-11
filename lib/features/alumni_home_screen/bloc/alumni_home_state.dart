part of 'alumni_home_bloc.dart';

sealed class AlumniHomeState extends Equatable {
  const AlumniHomeState();
  
  @override
  List<Object> get props => [];
}

final class AlumniHomeInitial extends AlumniHomeState {}
class JobPostSuccessState extends AlumniHomeState{}
class JobPostErrorState extends AlumniHomeState{}
class JobPostProgressState extends AlumniHomeState{}
