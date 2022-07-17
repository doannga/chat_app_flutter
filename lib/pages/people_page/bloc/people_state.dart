part of 'people_bloc.dart';

abstract class PeopleState extends Equatable {}

class PeopleInitial extends PeopleState {
  @override
  List<Object> get props => [];
}

class PeopleLoadInprogress extends PeopleState {
  @override
  List<Object> get props => [];
}

class PeopleLoadFailure extends PeopleState {
  final String message;
  PeopleLoadFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class PeopleLoadSuccess extends PeopleState {
  final List<AppUser> peopleList;
  PeopleLoadSuccess({required this.peopleList});
  @override
  List<Object> get props => [peopleList];
}
